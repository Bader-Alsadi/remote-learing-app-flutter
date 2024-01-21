import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
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
            .map((e) => Card(
          color: THIRD_COLOR,
                    child: ExpansionTileC(
                      subject: widget.subject,
                      lecturer: e,
                      LVM: LVM,
                      title: e.title!,
                      date: e.lecturerData!.split(" ").first,
                      vidoe: "",
                      hours: "s",
                      note: e.description!,
                      onPress: (){Navigator.pushNamed(context, Material2.ROUTE,
                          arguments: e);}
                  ),
                ))
            .toList(),
      ),
    );
  }
}
