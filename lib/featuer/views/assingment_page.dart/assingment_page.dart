import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_api.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_expancel_tile.dart';
import 'package:remote_learing_app_frontend/featuer/models/subjects_model.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/assingment_vm.dart';

class AssingmentPage extends StatefulWidget {
  AssingmentPage({super.key, required this.subject, required this.AVM});
  AssingmentVM AVM;
  Subject subject;

  @override
  State<AssingmentPage> createState() => _LecturerPageState();
}

class _LecturerPageState extends State<AssingmentPage> {
  bool isconnectd = true;
  @override
  void initState() {
    // final AVM = Provider.of<LecturerVM>(context);
    InternetConnectionChecker().hasConnection.then((value) {
      if (!value) {
        print("connectd: $value");
        if (widget.subject.assingments.isEmpty)
          widget.AVM.feachDate(ReposteryAPI(), widget.subject).then(
            (value) {
              isconnectd = true;
              widget.AVM..assingments = value;
            },
          );
      } else {
        print("connectd: $value");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: widget.subject.assingments
            .map((e) => Container(
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
                ))
            .toList(),
      ),
    );
  }
}
