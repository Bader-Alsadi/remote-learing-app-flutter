
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:remote_learing_app_frontend/core/helpers/ui_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_api.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_expancel_tile.dart';
import 'package:remote_learing_app_frontend/featuer/models/subjects_model.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/lectuer_vm.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/material_vm.dart';
import 'package:remote_learing_app_frontend/featuer/views/material_page/material_page.dart';

class LecturerPage extends StatefulWidget {
  LecturerPage({super.key, required this.subject, required this.LVM});
  LecturerVM LVM;
  Subject subject;

  @override
  State<LecturerPage> createState() => _LecturerPageState();
}

class _LecturerPageState extends State<LecturerPage> {
  bool isconnectd = true;
  @override
  void initState() {
    // final LVM = Provider.of<LecturerVM>(context);
    InternetConnectionChecker().hasConnection.then((value) {
      if (!value) {
        print("connectd: $value");
        if (widget.subject.Lecturers.isEmpty)
          widget.LVM.feachDate(ReposteryAPI(), widget.subject).then(
            (value) {
              isconnectd = true;
              widget.LVM.lectrers = value;
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
        children: widget.subject.Lecturers
            .map((e) => Container(
                  child: InkWell(
                    onLongPress: () async {
                      MaterialVM MVM = MaterialVM();
                      var result = await MVM.feachDate(ReposteryAPI(), e);
                      showSnackBar(context, result["message"]);
                      if (result["status"])
                        Navigator.pushNamed(context, MaterialP.ROUTE,
                            arguments: e);
                    },
                    child: ExpansionTileC(
                      subject: widget.subject,
                      lecturer: e,
                      LVM: widget.LVM,
                      title: e.title!,
                      date: e.lecturerData!.split(" ").first,
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
