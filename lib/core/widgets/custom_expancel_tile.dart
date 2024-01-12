import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/core/helpers/ui_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_api.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_icon_title.dart';
import 'package:remote_learing_app_frontend/featuer/models/assingment_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/lecturer_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/subjects_model.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/Assingment_lecturer.dart';
import 'package:remote_learing_app_frontend/featuer/views/my_course_page/widgets/show_doalog.dart';

class ExpansionTileC extends StatelessWidget {
  ExpansionTileC(
      {super.key,
      required this.title,
      required this.date,
      required this.note,
      required this.hours,
      required this.vidoe,
      required this.LVM,
      required this.subject,
      this.lecturer,
      this.assingment});
  String title, date, note, hours, vidoe;
  Subject subject;
  Lecturer? lecturer;
  Assingment? assingment;
  ALVM LVM;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(motion: ScrollMotion(), children: [
        SlidableAction(
          onPressed: (context) async {
            final result = await LVM.deleteLectuer(ReposteryAPI(), subject.id!,
                lecturer != null ? lecturer!.id! : assingment!.id!);
            showSnackBar(context, result["message"],result["status"]);
          },
          icon: Icons.delete,
          backgroundColor: PRIMARY_COLOR,
        ),
        SlidableAction(
          onPressed: (context) async {
            showDialogC(context, LVM, subject, lecturer: lecturer);
          },
          foregroundColor: BLACK_COLOR,
          icon: Icons.edit_calendar_rounded,
          backgroundColor: FOURTH_COLOR.withOpacity(.2),
        )
      ]),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SMALL_SPACER / 2),
        child: ExpansionTile(
          tilePadding: EdgeInsets.all(0),
          title: Text(
            title,
            style: TEXT_BIG.copyWith(color: BLACK_COLOR),
          ),
          leading: Text(date, style: TEXT_NORMAL.copyWith(color: GRAY_COLOR)),
          // trailing: InkWell(
          //     onTap: () {},
          //     child: Icon(Icons.file_download_outlined, color: BLACK_COLOR)),
          children: [
            Text(
              note,
              style: SUB_TITLE,
              softWrap: true,
              textAlign: TextAlign.justify,
            ),
            if (lecturer != null)
              IconWithText(
                icon: Icons.access_time_outlined,
                title: "${lecturer?.materials?.length ?? 0} matrials",
              ),
            assingment != null
                ? IconWithText(
                    icon: Icons.access_time_outlined,
                    title:
                        "${assingment?.submissions?.length ?? 0} submissions",
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
