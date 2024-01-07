import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/core/helpers/peremition_hp.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_api.dart';
import 'package:remote_learing_app_frontend/featuer/models/assingment_model.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/submission_vm.dart';
import 'package:remote_learing_app_frontend/featuer/views/submission_page.dart/submission_card.dart';

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
