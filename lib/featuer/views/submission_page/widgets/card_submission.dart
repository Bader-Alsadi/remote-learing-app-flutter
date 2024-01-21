import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/core/helpers/file_hp.dart';
import 'package:remote_learing_app_frontend/core/helpers/ui_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_api.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_elevated_buttom.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_filed.dart';
import 'package:remote_learing_app_frontend/featuer/models/submission_model.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/submission_vm.dart';

class CardListtile extends StatelessWidget {
  CardListtile({super.key, required this.submission});
  Submission submission;
  late int index;
  FileHP instanceFile = FileHP.getInstanse();
  CancelToken cancelToken = CancelToken();
  @override
  Widget build(BuildContext context) {
    final SVM = Provider.of<SubmissionVM>(context);
    index = SVM.submissions.indexOf(submission);
    if (submission.fileExists == null)
      instanceFile.checkFileExit(submission.path!).then((valu) {
        SVM.fileExtis(SVM.submissions.indexOf(submission), valu);
      });
    return Column(
      children: [
        Card(
          child: ListTile(
              onTap: () {
                updateGrade(context, SVM);
              },
              title: Text(
                "Student Name : ${submission.studentName!}",
                style: TEXT_NORMAL,
              ),
              subtitle: Text(
                "grade : ${submission.grade} | ",
                style: TEXT_NORMAL,
              ),
              leading: submission.dowloading
                  ? InkWell(
                      onTap: () {
                        instanceFile.cancelDownload(cancelToken);
                        SVM.downloading(index, false);
                      },
                      child: Icon(Icons.cancel))
                  :
              SvgPicture.asset((getFormatImage(submission.studentName!)),
              height: 50,),
              trailing: IconButton(
                onPressed: () {
                  submission.fileExists == null
                      ? null
                      : submission.fileExists!
                          ? instanceFile
                              .deletafiel(submission.path!)
                              .then((value) {
                              SVM.deleteFromDivese(index, value);
                            })
                          : instanceFile.startDownload(
                              CancelToken(), SVM, submission);
                },
                icon: submission.fileExists == null
                    ? SpinKitWaveSpinner(
                        color: THIRD_COLOR,
                        size: 30,
                      )
                    : submission.fileExists!
                        ? Icon(
                            Icons.delete,
                            color: Colors.red,
                          )
                        : submission.dowloading
                            ? Text(
                                "${(submission.progress * 100).toStringAsFixed(2)} %")
                            : Icon(Icons.download),
              )),
        ),
        IconButton(
            onPressed: () {

            },
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "To UpLoad -> ",
                  style: TEXT_NORMAL,
                ),
               Icon(Icons.grade),
              ],
            ))
      ],
    );
  }

  Future<dynamic> updateGrade(BuildContext context, SubmissionVM SVM) {
    TextEditingController gradeC = TextEditingController();
    AutovalidateMode validtion = AutovalidateMode.always;
    GlobalKey<FormState> FormKey = GlobalKey();
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
                              int temp = submission.grade ?? 0;
                              submission..grade = int.parse(gradeC.text);
                              isloaded = false;
                              Map resutle;
                              SVM
                                  .updateSubmission(
                                      ReposteryAPI(), submission, temp)
                                  .then((value) {
                                resutle = value;
                                if (resutle["status"]) Navigator.pop(context);

                                isloaded = true;

                                showSnackBar(context, resutle["message"],resutle["status"]);
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
