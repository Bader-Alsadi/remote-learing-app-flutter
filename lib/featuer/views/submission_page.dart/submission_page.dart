import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
import 'package:remote_learing_app_frontend/featuer/models/assingment_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/submission_model.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/submission_vm.dart';

class SubmissionPage extends StatefulWidget {
  SubmissionPage({super.key, required this.assingment});
  Assingment assingment;
  static const String ROUTE = "submissionPage";

  @override
  State<SubmissionPage> createState() => _SubmissionPageState();
}

class _SubmissionPageState extends State<SubmissionPage> {
  bool isPermission = false;
  bool _isLoaded = false;

  var checkAllPermissions = PermissionHL();
  final SVM = SubmissionVM();
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

    SVM.feachDate(ReposteryAPI(), widget.assingment).then((value) {
      _isLoaded = true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Submission for ${widget.assingment.title}",
            style: TEXT_NORMAL,
          ),
        ),
        body: isPermission
            ? _isLoaded
                ? SingleChildScrollView(
                    child: Column(
                    children: widget.assingment.submissions!
                        .map((e) => CardWidget(
                              submission: e,
                              assingment: widget.assingment,
                            ))
                        .toList(),
                  ))
                : Text("nothu")
            : TextButton(
                onPressed: () {
                  checkPermission();
                },
                child: const Text("Permission issue")));
  }
}

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
            showDialog(
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
                                      print(
                                          "studID:${widget.submission.studentId}");
                                      Submission submission = Submission(
                                        grade: int.parse(gradeC.text),
                                        studentId: widget.submission.studentId,
                                        assingmentId: widget.assingment.id,
                                      );

                                      isloaded = false;
                                      Map resutle;
                                      SVM
                                          .updateLectuer(
                                              ReposteryAPI(),
                                              widget.assingment.id!,
                                              widget.submission.id!,
                                              submission)
                                          .then((value) {
                                        resutle = value;
                                        if (resutle["status"])
                                          Navigator.pop(context);

                                        isloaded = true;
                                        showSnackBar(
                                            context, resutle["message"]);
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
}
