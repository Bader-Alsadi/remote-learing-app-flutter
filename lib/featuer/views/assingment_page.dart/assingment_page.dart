import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/image_paths.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/core/helpers/file_hp.dart';
import 'package:remote_learing_app_frontend/core/helpers/get_storge_helper.dart';
import 'package:remote_learing_app_frontend/core/helpers/ui_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_api.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_elevated_buttom.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_expancel_tile.dart';
import 'package:remote_learing_app_frontend/featuer/models/assingment_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/subjects_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/submission_model.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/assingment_vm.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/submission_vm.dart';
import 'package:remote_learing_app_frontend/featuer/views/submission_page/submission_page.dart';

class AssingmentPage extends StatefulWidget {
  AssingmentPage({super.key, required this.subject});

  Subject subject;

  @override
  State<AssingmentPage> createState() => _LecturerPageState();
}

class _LecturerPageState extends State<AssingmentPage> {
  GetStorage instance = GetStorageHelper.instance("user");
  File? pickFile;
  bool isloaded = false;

  @override
  Widget build(BuildContext context) {
    final AVM = Provider.of<AssingmentVM>(context);
    final SubmmissonVM = Provider.of<SubmissionVM>(context);
    return SingleChildScrollView(
      child: Column(
        children: AVM.assingments
            .map((e) => Column(
                  children: [
                    InkWell(
                      onLongPress: instance.read("role") == "Student"
                          ? null
                          : () {
                              Navigator.pushNamed(
                                  context, SubmissionPage2.ROUTE,
                                  arguments: e);
                            },
                      child: Container(
                        child: ExpansionTileC(
                          subject: widget.subject,
                          assingment: e,
                          LVM: AVM,
                          title: e.title!,
                          date: e.deadline!.split(" ").first,
                          vidoe: "",
                          hours: "s",
                          note: e.description!,
                        ),
                      ),
                    ),
                    instance.read("role") == "Student"
                        ? IconButton(
                            onPressed: () {
                              uploadeSubmisson(context, e, SubmmissonVM);
                            },
                            icon: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "To UpLoad -> ",
                                  style: TEXT_NORMAL,
                                ),
                                SvgPicture.asset("${ICONS}${FILE_UPLODAE}"),
                              ],
                            ))
                        : Container()
                  ],
                ))
            .toList(),
      ),
    );
  }

  Future<dynamic> uploadeSubmisson(
      BuildContext context, Assingment e, SubmissionVM SubmmissonVM) {
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: Row(
            children: [
              // SvgPicture.asset(),
              Text("Uploade Submission")
            ],
          ),
          content: Column(
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
              StatefulBuilder(
                builder: (context, setstate) => CustomElevatedBottom(
                    child: AnimatedButoom(isloaded: isloaded),
                    lable: "save",
                    backColor: PRIMARY_COLOR,
                    onPressedFun: () async {
                      print(
                        instance.read("student_id"),
                      );
                      if (pickFile != null) {
                        Submission submission = Submission(
                            studentId: instance.read("student_id"),
                            assingmentId: e.id,
                            path: pickFile!.path);
                        var result = await SubmmissonVM.storeSubmission(
                            ReposteryAPI(), e.id!, submission);
                        showSnackBar(
                            context, result["message"], result["status"]);
                        Navigator.pop(context);
                      } else {
                        showSnackBar(context, "file path is empty", false);
                      }
                    }),
              )
            ],
          ),
        );
      }),
    );
  }
}
