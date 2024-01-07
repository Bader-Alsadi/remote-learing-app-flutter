import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_api.dart';
import 'package:remote_learing_app_frontend/core/widgets/coustom_tool_bar.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_icon.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_image_title.dart';
import 'package:remote_learing_app_frontend/featuer/models/subjects_model.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/assingment_vm.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/lectuer_vm.dart';
import 'package:remote_learing_app_frontend/featuer/views/assingment_page.dart/assingment_page.dart';
import 'package:remote_learing_app_frontend/featuer/views/lecturer_page/lecturer_page.dart';
import 'package:remote_learing_app_frontend/featuer/views/my_course_page/widgets/lecturer_assingment_.dart';
import 'package:remote_learing_app_frontend/featuer/views/my_course_page/widgets/show_doalog.dart';
import 'package:shimmer/shimmer.dart';

class InstroctorSubject extends StatefulWidget {
  InstroctorSubject({super.key, required this.subject});
  static const String ROUTE = "instrictor_subject";
  Subject subject;

  @override
  State<InstroctorSubject> createState() => _InstroctorSubjectState();
}

class _InstroctorSubjectState extends State<InstroctorSubject> {
  bool? isconnectd;
  bool lectrersIsLoaded = false;
  bool assingmentIsLoaded = false;
  final lvm = LecturerVM();
  final avm = AssingmentVM();
  @override
  void initState() {
    InternetConnectionChecker().hasConnection.then((value) {
      if (!value) {
        isconnectd = true;
        setState(() {});
        print("connectd: $value");

        Provider.of<LecturerVM>(context, listen: false)
            .feachDate(ReposteryAPI(), widget.subject)
            .then(
          (value) {
            widget.subject.Lecturers = value;
            setState(() {
              lectrersIsLoaded = true;
            });
          },
        );
        Provider.of<AssingmentVM>(context, listen: false)
            .feachDate(ReposteryAPI(), widget.subject)
            .then(
          (value) {
            widget.subject.assingments = value;
            setState(() {
              assingmentIsLoaded = true;
            });
          },
        );
      } else {
        isconnectd = false;
        print("connectd: $value");
      }
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    
    print("${widget.subject.id}");
    final LVM = Provider.of<LecturerVM>(context);
    final AVM = Provider.of<AssingmentVM>(context);

    return isconnectd != null
        ? isconnectd!
            ? Scaffold(
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
                                      showDialogC(context, LVM, widget.subject);
                                    },
                                  ),
                                  PopupMenuItem(
                                    child: Text("Add Assingment"),
                                    onTap: () {
                                      showDialogC(context, AVM, widget.subject);
                                    },
                                  )
                                ]);
                          },
                        );
                      }),
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  child: Container(
                    // padding: EdgeInsets.symmetric(horizontal: SMALL_SPACER / 2),
                    margin: EdgeInsets.symmetric(vertical: SMALL_SPACER),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: SMALL_SPACER / 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Chip(
                                label: Text(
                                  "${widget.subject.department!.name}",
                                  style: TITLE,
                                ),
                              ),
                              SizedBox(
                                height: MIN_SPACER,
                              ),
                              ImageAndTitle(
                                imagePath: "assets/images/courses/course1.jpeg",
                                title: "${widget.subject.name}",
                              ),
                            ],
                          ),
                        ),
                        CustomTabBar(
                          list: [
                            Container(
                              child: LecturerPage(
                                subject: widget.subject,
                              ),
                            ),
                            Container(
                              child: AssingmentPage(
                                subject: widget.subject,
                              ),
                            )
                          ],
                          tabsTitle: ["Lecturers", "Assingment"],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Center(
                child: Text("noct"),
              )
        : LecturerAssingmentPH();
  }
}
