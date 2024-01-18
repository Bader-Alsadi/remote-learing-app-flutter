import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/helpers/peremition_hp.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_api.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_icon.dart';
import 'package:remote_learing_app_frontend/featuer/models/assingment_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/submission_model.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/submission_vm.dart';
import 'package:remote_learing_app_frontend/featuer/views/submission_page/widgets/card_submission.dart';
import 'package:remote_learing_app_frontend/featuer/views/submission_page/widgets/place_holder_matrieal.dart';

class SubmissionPage2 extends StatefulWidget {
  SubmissionPage2({super.key, required this.assingment});
  static const String ROUTE = "submission_page";
  Assingment assingment;

  @override
  State<SubmissionPage2> createState() => _SubmissionState();
}

class _SubmissionState extends State<SubmissionPage2> {
  bool isPermission = false;
  var checkAllPermissions = PermissionHL();
  bool? isConnect;
  bool isloaded = false;
  List<Submission> submissions = [];

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
        Provider.of<SubmissionVM>(context, listen: false)
            .feachDate(ReposteryAPI(), widget.assingment)
            .then((value) {
          submissions = value;
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
    final SVM = Provider.of<SubmissionVM>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        foregroundColor: WHITH_COLOR,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Circalicon(
            color: WHITH_COLOR,
            iconData: Icons.arrow_back_ios_new_rounded,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(widget.assingment.title!),
      ),
      body: isConnect != null
          ? isConnect!
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: SPACER + 8),
                    child: Column(
                      children: SVM.submissions
                          .map((e) => CardListtile(
                                submission: e,
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
}
