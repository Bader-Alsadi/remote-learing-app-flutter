import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/core/helpers/file_hp.dart';
import 'package:remote_learing_app_frontend/core/helpers/ui_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_api.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_elevated_buttom.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_filed.dart';
import 'package:remote_learing_app_frontend/featuer/models/assingment_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/submission_model.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/submission_vm.dart';

class CardWidget extends StatefulWidget {
  CardWidget({super.key, required this.submission, required this.assingment});
  Submission submission;
  Assingment assingment;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  bool dowloading = false;
  bool fileExists = false;
  TextEditingController gradeC = TextEditingController();
  AutovalidateMode validtion = AutovalidateMode.always;
  GlobalKey<FormState> FormKey = GlobalKey();
  CancelToken cancelToken = CancelToken();
  FileHP? fileHP;
  checkFile() async {
    fileHP = await FileHP.getInstanse();
    fileExists = await fileHP!.checkFileExit(widget.submission.path!);
    setState(() {});
  }

  @override
  void initState() {
    checkFile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final SVM = Provider.of<SubmissionVM>(context);
    return Card(
      child: ListTile(
          onTap: () {
            updateGrade(context, SVM);
          },
          leading: Text(widget.submission.submissionsDate!.split(" ").first),
          title: Text(
            widget.submission.studentName!,
            style: TEXT_NORMAL,
          ),
          subtitle: Text(
            "${widget.submission.grade ?? "grade not assing yet "}",
            style: GRAY_TEXT,
          ),
          trailing: Column(
            children: [
              widget.submission.state!
                  ? Icon(
                      Icons.assignment_rounded,
                      color: PRIMARY_COLOR,
                    )
                  : Icon(
                      Icons.assignment_late_rounded,
                      color: Colors.red,
                    ),
              Flexible(
                child: IconButton(
                    onPressed: () {
                      fileExists
                          ? fileHP!.openfile(widget.submission.path!)
                          : fileHP!.startDownload(
                              cancelToken, SVM, widget.submission);
                    },
                    icon: fileExists
                        ? Icon(
                            Icons.visibility,
                          )
                        : Icon(
                            Icons.download,
                          )),
              )
            ],
          )),
    );
  }

  Future<dynamic> updateGrade(BuildContext context, SubmissionVM SVM) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Add grade"),
              content: Form(
                key: FormKey,
                autovalidateMode: validtion,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextFiled(
                      title: "grade",
                      filedType: TextInputType.number,
                      lable: "",
                      controller: gradeC,
                      validate: validaterequired,
                    ),
                    StatefulBuilder(
                      builder: (context, setstate) {
                        bool isloaded = true;
                        return CustomElevatedBottom(
                          child: AnimatedButoom(isloaded: isloaded),
                          lable: "save",
                          backColor: PRIMARY_COLOR,
                          onPressedFun: () async {
                            if (FormKey.currentState!.validate()) {
                              print("studID:${widget.submission.studentId}");
                              int temp = widget.submission.grade!;
                              widget.submission..grade = int.parse(gradeC.text);
                              isloaded = false;
                              Map resutle;
                              SVM
                                  .updateSubmission(
                                      ReposteryAPI(), widget.submission,temp)
                                  .then((value) {
                                resutle = value;
                                if (resutle["status"]) Navigator.pop(context);

                                isloaded = true;

                                showSnackBar(context, resutle["message"]);
                                setstate(
                                  () {},
                                );
                              });
                              setstate(
                                () {},
                              );
                            }
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
            ));
  }
}
