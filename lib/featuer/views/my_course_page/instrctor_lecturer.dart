import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/helpers/ui_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_api.dart';
import 'package:remote_learing_app_frontend/core/widgets/coustom_tool_bar.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_expancel_tile.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_icon.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_image_title.dart';
import 'package:remote_learing_app_frontend/featuer/models/subjects_model.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/lectuer_vm.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/material_vm.dart';
import 'package:remote_learing_app_frontend/featuer/views/lecturer_page/lecturer_page.dart';
import 'package:remote_learing_app_frontend/featuer/views/material_page/material_page.dart';
import 'package:remote_learing_app_frontend/featuer/views/my_course_page/widgets/show_doalog.dart';

class InstroctorSubject extends StatelessWidget {
  InstroctorSubject({super.key, required this.subject});
  static const String ROUTE = "instrictor_subject";
  Subject subject;
  bool isconnectd = true;
  @override
  Widget build(BuildContext context) {
    print("${subject.id}");
    final LVM = Provider.of<LecturerVM>(context);
    // InternetConnectionChecker().hasConnection.then((value) {
    //   if (!value) {
    //     print("connectd: $value");
    //     if (subject.Lecturers.isEmpty)
    //       LVM.feachDate(ReposteryAPI(), subject).then(
    //         (value) {
    //           isconnectd = true;
    //           LVM.lectrers = value;
    //         },
    //       );
    //   } else {
    //     print("connectd: $value");
    //   }
    // });
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Circalicon(
            iconData: Icons.arrow_back_ios_new_rounded,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Builder(builder: (context) {
              return Circalicon(
                iconData: Icons.list,
                onTap: () {
                  showMenu(
                      context: context,
                      position: RelativeRect.fill,
                      items: [
                        PopupMenuItem(
                          child: Text("Add Lecturer"),
                          onTap: () {
                            showDialogC(context, LVM, subject);
                          },
                        ),
                        PopupMenuItem(
                          child: Text("Add Assingment"),
                          onTap: () {
                            // showDialogC(context, LVM);
                          },
                        )
                      ]);
                },
              );
            }),
          ),
        ],
      ),
      body:
          // subject.Lecturers.isEmpty
          //     ? Center(
          //         child: isconnectd
          //             ? Text("no lecturers")
          //             : SpinKitFadingCircle(
          //                 color: PRIMARY_COLOR,
          //               ),
          //       )
          //     :
          SingleChildScrollView(
        child: Container(
          // padding: EdgeInsets.symmetric(horizontal: SMALL_SPACER / 2),
          margin: EdgeInsets.symmetric(vertical: SMALL_SPACER),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MIN_SPACER,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: SMALL_SPACER / 2),
                child: ImageAndTitle(
                  imagePath: "assets/images/courses/course1.jpeg",
                  title: "${subject.name} | ${subject.department!.name}",
                ),
              ),
              CustomTabBar(
                list: [
                  Container(
                    child: LecturerPage(
                      subject: subject,
                      LVM: LVM,
                    ),
                  ),
                  Container(
                    color: BLACK_COLOR,
                    child: Text("a"),
                  )
                ],
                tabsTitle: ["Lecturers", "Assingment"],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
