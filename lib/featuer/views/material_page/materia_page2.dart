import 'dart:io';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/core/helpers/file_hp.dart';
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
      if (!value) {
        isConnect = !value;
        Provider.of<MaterialVM>(context, listen: false)
            .feachDate(ReposteryAPI(), widget.lecturer)
            .then((value) {
          materials = value;
          isloaded = true;
          setState(() {});
        });
      } else {
        isConnect = !value;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final SCVM = Provider.of<MaterialVM>(context);
    MaterialVM MVM = Provider.of<MaterialVM>(context);

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Circalicon(
            iconData: Icons.arrow_back_ios_new_rounded,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(widget.lecturer.title!),
      ),
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton(
          backgroundColor: FOURTH_COLOR,
          onPressed: () {
            GlobalKey<FormState> FormKey = GlobalKey();
            AutovalidateMode validation = AutovalidateMode.always;
            List<TextEditingController> controllers =
                List.generate(2, (index) => TextEditingController());

            showBottomSheetMT(context, FormKey, validation, controllers, MVM);
          },
          child: Icon(
            Icons.add_box_rounded,
          ),
        );
      }),
      body: isConnect != null
          ? isConnect!
              ? SingleChildScrollView(
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
                              Flexible(
                                child: CustomElevatedBottom(
                                  backColor: WHITH_COLOR,
                                  borderColor: BLACK_COLOR,
                                  titleColor: BLACK_COLOR,
                                  lable: "Pickup File",
                                  onPressedFun: () async {
                                    pickFile = await FileHP().pickupFile();
                                    setState(() {});
                                    print("file: ${pickFile?.path}");
                                  },
                                ),
                              ),
                              Text(
                                "${pickFile?.path.split("/").last}",
                                style: TEXT_NORMAL.copyWith(color: BLACK_COLOR),
                              )
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
                                    showSnackBar(context, result["message"]);
                                    Navigator.pop(context);
                                  } else {
                                    showSnackBar(context, "file path is empty");
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