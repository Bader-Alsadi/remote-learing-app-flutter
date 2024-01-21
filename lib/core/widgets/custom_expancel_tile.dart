import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/core/helpers/get_storge_helper.dart';
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
       this.onPress,
      this.lecturer,
      this.assingment});
  String title, date, note, hours, vidoe;
  Subject subject;
  Lecturer? lecturer;
  Assingment? assingment;
  ALVM LVM;
  VoidCallback? onPress;
  @override
  Widget build(BuildContext context) {
    bool? assinmentState;
    if(assingment != null){
       assinmentState= DateTime.parse(date).difference(DateTime.now()).isNegative;
    }
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
            style: TEXT_NORMAL.copyWith(color: BLACK_COLOR),
          ),
          leading: Text(lecturer != null ? "${DateTime.parse(date).weekday} week": " ${(assingment != null && assinmentState!) ? "":"still"} ${DateTime.parse(date).difference(DateTime.now()).inDays} days" , style: TEXT_NORMAL.copyWith(color: (assingment != null && assinmentState!) ? Colors.red :FOURTH_COLOR.withOpacity(.7))),
          children: [
            Text(
              note,
              style: SUB_TITLE.copyWith(color: BLACK_COLOR),
              softWrap: true,
              textAlign: TextAlign.justify,
            ),
            if (lecturer != null)
              ...[
                SizedBox(
                  height: MIN_SPACER,
                ),
                if(lecturer!.note != null)
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Note : ${lecturer!.note}",style: TEXT_NORMAL.copyWith(color: FOURTH_COLOR),)),
                SizedBox(
                  height: SMALL_SPACER,
                ),

                Align(
                    alignment: Alignment.center,
                    child:
                FilledButton(onPressed: onPress, child: Text("Show Material",style: TEXT_NORMAL,),
                  style: ButtonStyle(
                     backgroundColor: MaterialStatePropertyAll( PRIMARY_COLOR)
                  ),
                )),
                SizedBox(
                  height: MIN_SPACER,
                ),
              ]
            else
              ...[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Grade : ${assingment!.grade }",style: TEXT_NORMAL.copyWith(color: FOURTH_COLOR),)),
                SizedBox(
                  height: SMALL_SPACER,
                ),
              GetStorageHelper.instance("user").read("role") != "Student"?
                Align(
                    alignment: Alignment.center,
                    child:
                    FilledButton(onPressed: onPress, child: Text("Show Submissions",style: TEXT_NORMAL,),
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll( PRIMARY_COLOR)
                      ),
                    )):Container(),
                SizedBox(
                  height: MIN_SPACER,
                ),

                ]

          ],
        ),
      ),
    );
  }
}
