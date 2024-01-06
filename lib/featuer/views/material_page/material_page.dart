import 'dart:io';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as Path;
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/core/helpers/directoryP_path_hb.dart';
import 'package:remote_learing_app_frontend/core/helpers/file_hp.dart';
import 'package:remote_learing_app_frontend/core/helpers/peremition_hp.dart';
import 'package:remote_learing_app_frontend/core/helpers/ui_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_api.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_elevated_buttom.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_filed.dart';
import 'package:remote_learing_app_frontend/featuer/models/lecturer_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/material_model.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/download_vm.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/material_vm.dart';

class MaterialP extends StatefulWidget {
  MaterialP({super.key, required this.lecturer});
  static const String ROUTE = "material_page";
  Lecturer lecturer;

  @override
  State<MaterialP> createState() => _FileListState();
}

class _FileListState extends State<MaterialP> {
  bool isPermission = false;
  var checkAllPermissions = PermissionHL();
  GlobalKey<FormState> FormKey = GlobalKey();
  AutovalidateMode validation = AutovalidateMode.always;
  List<TextEditingController> controllers =
      List.generate(2, (index) => TextEditingController());

  checkPermission() async {
    var permission = await checkAllPermissions.isStoragePermission();
    if (permission) {
      setState(() {
        isPermission = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    List<Materiall> materials = widget.lecturer.materials!;
    bool isloaded = true;
    MaterialVM MVM = Provider.of<MaterialVM>(context);

    return Scaffold(
        backgroundColor: WHITH_COLOR,
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    File? pickFile;
                    return StatefulBuilder(builder: (context, setState) {
                      return SingleChildScrollView(
                        child: Dialog(
                          child: Container(
                            child: Form(
                                key: FormKey,
                                autovalidateMode: validation,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomTextFiled(
                                      title: "Title",
                                      lable: "",
                                      controller: controllers[0],
                                      validate: validaterequired,
                                    ),
                                    CustomTextFiled(
                                      title: "Description",
                                      lable: "",
                                      controller: controllers[1],
                                      validate: validaterequired,
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          child: CustomElevatedBottom(
                                            backColor: THIRD_COLOR,
                                            lable: "pick file",
                                            onPressedFun: () async {
                                              pickFile =
                                                  await FileHP().pickupFile();
                                              setState(() {});
                                              print("file: ${pickFile?.path}");
                                            },
                                          ),
                                        ),
                                        Flexible(
                                            child: Text(
                                          "${pickFile?.path.split("/").last}",
                                          style: TEXT_NORMAL.copyWith(
                                              color: BLACK_COLOR),
                                        ))
                                      ],
                                    ),
                                    SizedBox(
                                      height: SMALL_SPACER,
                                    ),
                                    StatefulBuilder(
                                      builder: (context, setstate) =>
                                          CustomElevatedBottom(
                                        child:
                                            AnimatedButoom(isloaded: isloaded),
                                        lable: "save",
                                        backColor: PRIMARY_COLOR,
                                        onPressedFun: () async {
                                          if (FormKey.currentState!
                                              .validate()) {
                                            if (pickFile != null) {
                                              Materiall material = Materiall(
                                                  title: controllers[0].text,
                                                  type: controllers[0].text,
                                                  lecturerId:
                                                      widget.lecturer.id,
                                                  path: pickFile!.path);
                                              var result =
                                                  await MVM.storeMaterial(
                                                      ReposteryAPI(),
                                                      widget.lecturer,
                                                      material);
                                              showSnackBar(
                                                  context, result["message"]);
                                              Navigator.pop(context);
                                            } else {
                                              showSnackBar(context,
                                                  "file path is empty");
                                            }
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ),
                      );
                    });
                  });
            },
            child: Icon(Icons.add_box_rounded),
          );
        }),
        appBar: AppBar(
          title: Text(widget.lecturer.title!),
        ),
        body: isPermission
            ? ListView.builder(
                itemCount: materials.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = materials[index];
                  return TileList(
                    material: data,
                  );
                })
            : TextButton(
                onPressed: () {
                  checkPermission();
                },
                child: const Text("Permission issue")));
  }
}

class TileList extends StatefulWidget {
  TileList({super.key, required this.material});
  final Materiall material;

  @override
  State<TileList> createState() => _TileListState();
}

class _TileListState extends State<TileList> {
  bool dowloading = false;
  bool fileExists = false;
  double progress = 0;
  String fileName = "";
  late String filePath;
  late CancelToken cancelToken;
  var getPathFile = DirectoryPathHP();

  startDownload() async {
    cancelToken = CancelToken();
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';
    setState(() {
      dowloading = true;
      // DVMprogress = 0;
    });

    try {
      await Dio().download(widget.material.path!, filePath,
          onReceiveProgress: (count, total) {
        setState(() {
          progress = (count / total);
        });
      }, cancelToken: cancelToken);
      setState(() {
        dowloading = false;
        fileExists = true;
      });
    } catch (e) {
      print(e);
      setState(() {
        dowloading = false;
      });
    }
  }

  cancelDownload() {
    cancelToken.cancel();
    setState(() {
      dowloading = false;
    });
  }

  checkFileExit() async {
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';
    bool fileExistCheck = await File(filePath).exists();
    setState(() {
      fileExists = fileExistCheck;
    });
  }

  openfile() {
    OpenFile.open(filePath);
  }

  deletafiel() async {
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';
    bool fileExistCheck = await File(filePath).exists();
    await File(filePath).delete();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      fileName = Path.basename(widget.material.path!);
    });
    checkFileExit();
  }

  zScore(double progress) {
    print("d:${(progress - 0) / (1 - 0)}");
    return (progress - 0) / (1 - 0);
  }

  @override
  Widget build(BuildContext context) {
    final DVM = Provider.of<DownloadVM>(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: SMALL_SPACER / 2),
      child: Column(
        children: [
          if (widget.material.madiaType! == "png")
            Image.network(
              widget.material.path!,
              height: MediaQuery.sizeOf(context).height * .3,
            ),
          ListTile(
              title: Text(widget.material.title!, style: TEXT_NORMAL),
              subtitle: Text(
                "${widget.material.size?.toStringAsFixed(2)} MP",
                style: TEXT_NORMAL,
              ),
              leading: IconButton(
                  onPressed: () {
                    fileExists && dowloading == false
                        ? deletafiel()
                        : cancelDownload();
                  },
                  icon: fileExists && dowloading == false
                      ? const Icon(
                          Icons.delete,
                          color: PRIMARY_COLOR,
                        )
                      : const Icon(Icons.close)),
              trailing: IconButton(
                  onPressed: () {
                    fileExists && dowloading == false
                        ? openfile()
                        : startDownload();
                  },
                  icon: fileExists
                      ? const Icon(
                          Icons.save,
                          color: SECONDRY_COLOR,
                        )
                      : dowloading
                          ? Text("${progress.toStringAsFixed(2)} %")
                          : const Icon(Icons.download))),
          if (dowloading)
            LinearPercentIndicator(
              animateFromLastPercent: true,
              padding: EdgeInsets.all(0),
              percent: zScore(progress),
              progressColor: FOURTH_COLOR,
              animation: true,
              lineHeight: 10,
              barRadius: Radius.circular(15),
            ),
        ],
      ),
    );
  }
}
