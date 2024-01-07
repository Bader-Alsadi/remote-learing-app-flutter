import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_expancel_tile.dart';
import 'package:remote_learing_app_frontend/featuer/models/subjects_model.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/assingment_vm.dart';
import 'package:remote_learing_app_frontend/featuer/views/submission_page.dart/submission_page.dart';

class AssingmentPage extends StatefulWidget {
  AssingmentPage({super.key, required this.subject, required this.AVM});
  AssingmentVM AVM;
  Subject subject;

  @override
  State<AssingmentPage> createState() => _LecturerPageState();
}

class _LecturerPageState extends State<AssingmentPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: widget.subject.assingments
            .map((e) => InkWell(
                  onLongPress: () {
                    Navigator.pushNamed(context, SubmissionPage.ROUTE,
                        arguments: e);
                  },
                  child: Container(
                    child: ExpansionTileC(
                      subject: widget.subject,
                      assingment: e,
                      LVM: widget.AVM,
                      title: e.title!,
                      date: e.deadline!.split(" ").first,
                      vidoe: "",
                      hours: "s",
                      note: e.description!,
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
