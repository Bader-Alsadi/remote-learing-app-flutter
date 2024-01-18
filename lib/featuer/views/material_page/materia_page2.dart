import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/core/helpers/file_hp.dart';
import 'package:remote_learing_app_frontend/core/helpers/get_storge_helper.dart';
import 'package:remote_learing_app_frontend/core/helpers/peremition_hp.dart';
import 'package:remote_learing_app_frontend/core/helpers/ui_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_api.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_elevated_buttom.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_filed.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_icon.dart';
import 'package:remote_learing_app_frontend/featuer/models/lecturer_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/material_model.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/material_vm.dart';
import 'package:remote_learing_app_frontend/featuer/views/material_page/widgets/card_material.dart';
import 'package:remote_learing_app_frontend/featuer/views/material_page/widgets/place_holder_matrieal.dart';

class Material2 extends StatefulWidget {
  Material2({super.key, required this.lecturer});
  static const String ROUTE = "material_page";
  Lecturer lecturer;

  @override
  State<Material2> createState() => _Material2State();
}

class _Material2State extends State<Material2> {
  GetStorage instance = GetStorageHelper.instance("user");
  bool isPermission = false;
  var checkAllPermissions = PermissionHL();
  bool? isConnect;
  bool isloaded = false;
  List<Materiall> materials = [];

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
    InternetConnectionChecker().hasConnection.then((value) {
      if (value) {
        isConnect = value;
        Provider.of<MaterialVM>(context, listen: false)
            .feachDate(ReposteryAPI(), widget.lecturer)
            .then((value) {
          materials = value;
          isloaded = true;
          setState(() {});
        });
      } else {
        isConnect = value;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final SCVM = Provider.of<MaterialVM>(context);
    MaterialVM MVM = Provider.of<MaterialVM>(context);

    return Scaffold(
      backgroundColor: WHITH_COLOR,
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        foregroundColor: WHITH_COLOR,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Circalicon(
            iconData: Icons.arrow_back_ios_new_rounded,
            color: WHITH_COLOR,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(widget.lecturer.title!),
      ),
      floatingActionButton: instance.read("role") == "Student"
          ? null
          : Builder(builder: (context) {
              return FloatingActionButton(
                backgroundColor: PRIMARY_COLOR,
                onPressed: () {
                  GlobalKey<FormState> FormKey = GlobalKey();
                  AutovalidateMode validation = AutovalidateMode.always;
                  List<TextEditingController> controllers =
                      List.generate(2, (index) => TextEditingController());
                  showBottomSheetMT(
                      context, FormKey, validation, controllers, MVM);
                },
                child: Icon(
                  Icons.add,
                  size: 30,
                  color: WHITH_COLOR,
                ),
              );
            }),
      body: isConnect != null
          ? isConnect!
              ? Container(
                  color: THIRD_COLOR.withOpacity(0.2),
                  height: MediaQuery.sizeOf(context).height,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: SPACER + 8),
                      child: Column(
                        children: SCVM.materials
                            .map((e) => CardListtile(
                                  material: e,
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                )
              : Center(
                  child: Text("no internet"),
                )
          : PlaceHolderMaterial(),
    );
  }

  Future<dynamic> showBottomSheetMT(
      BuildContext context,
      GlobalKey<FormState> FormKey,
      AutovalidateMode validation,
      List<TextEditingController> controllers,
      MaterialVM MVM) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          File? pickFile;
          return StatefulBuilder(builder: (context, setState) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  child: Form(
                      key: FormKey,
                      autovalidateMode: validation,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomTextFiled(
                            title: "",
                            lable: "Title",
                            controller: controllers[0],
                            validate: validaterequired,
                          ),
                          CustomTextFiled(
                            title: "",
                            lable: "Description",
                            controller: controllers[1],
                            validate: validaterequired,
                          ),
                          SizedBox(
                            height: SMALL_SPACER,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${pickFile?.path.split("/").last}",
                                style: TEXT_NORMAL.copyWith(color: BLACK_COLOR),
                              ),
                              Flexible(
                                child: CustomElevatedBottom(
                                  backColor: FOURTH_COLOR.withOpacity(0.4),
                                  borderColor: FOURTH_COLOR.withOpacity(0.4),
                                  titleColor: WHITH_COLOR,
                                  lable: "Pickup File",
                                  onPressedFun: () async {
                                    pickFile = await FileHP().pickupFile();
                                    setState(() {});
                                    print("file: ${pickFile?.path}");
                                  },
                                ),
                              ),
                            ],
                          ),
                          StatefulBuilder(
                            builder: (context, setstate) =>
                                CustomElevatedBottom(
                              child: AnimatedButoom(isloaded: isloaded),
                              lable: "save",
                              backColor: PRIMARY_COLOR,
                              onPressedFun: () async {
                                if (FormKey.currentState!.validate()) {
                                  if (pickFile != null) {
                                    Materiall material = Materiall(
                                        title: controllers[0].text,
                                        type: controllers[0].text,
                                        lecturerId: widget.lecturer.id,
                                        path: pickFile!.path);
                                    var result = await MVM.storeMaterial(
                                        ReposteryAPI(),
                                        widget.lecturer,
                                        material);
                                    showSnackBar(context, result["message"],
                                        result["status"]);
                                    Navigator.pop(context);
                                  } else {
                                    showSnackBar(
                                        context, "file path is empty", false);
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
  }
}
