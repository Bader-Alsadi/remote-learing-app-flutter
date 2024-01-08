import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_expancel_tile.dart';
import 'package:remote_learing_app_frontend/featuer/models/subjects_model.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/lectuer_vm.dart';
import 'package:remote_learing_app_frontend/featuer/views/material_page/materia_page2.dart';

class LecturerPage extends StatefulWidget {
  LecturerPage({super.key, required this.subject});
  Subject subject;

  @override
  State<LecturerPage> createState() => _LecturerPageState();
}

class _LecturerPageState extends State<LecturerPage> {
  @override
  Widget build(BuildContext context) {
    final LVM = Provider.of<LecturerVM>(context);
    return SingleChildScrollView(
      child: Column(
        children: LVM.lectrers
            .map((e) => Container(
                  child: InkWell(
                    onLongPress: () async {
                      // MaterialVM MVM = MaterialVM();
                      // var result = await MVM.feachDate(ReposteryAPI(), e);
                      // showSnackBar(context, result["message"]);
                      // if (result["status"])
                      Navigator.pushNamed(context, Material2.ROUTE,
                          arguments: e);
                    },
                    child: ExpansionTileC(
                      subject: widget.subject,
                      lecturer: e,
                      LVM: LVM,
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
