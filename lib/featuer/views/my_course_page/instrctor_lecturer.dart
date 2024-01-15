import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/helpers/get_storge_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_api.dart';
import 'package:remote_learing_app_frontend/core/widgets/costom_tap_view.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_icon.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_image_title.dart';
import 'package:remote_learing_app_frontend/featuer/models/subjects_model.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/assingment_vm.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/lectuer_vm.dart';
import 'package:remote_learing_app_frontend/featuer/views/assingment_page.dart/assingment_page.dart';
import 'package:remote_learing_app_frontend/featuer/views/lecturer_page/lecturer_page.dart';
import 'package:remote_learing_app_frontend/featuer/views/my_course_page/widgets/lecturer_assingment_.dart';
import 'package:remote_learing_app_frontend/featuer/views/my_course_page/widgets/show_doalog.dart';
import 'package:remote_learing_app_frontend/featuer/views/repout_page/report_page.dart';

class InstroctorSubject extends StatefulWidget {
  InstroctorSubject({super.key, required this.subject});
  static const String ROUTE = "instrictor_subject";
  Subject subject;

  @override
  State<InstroctorSubject> createState() => _InstroctorSubjectState();
}

class _InstroctorSubjectState extends State<InstroctorSubject> {
  int _selectedTag = 0;
  bool? isconnectd;
  bool lectrersIsLoaded = false;
  bool assingmentIsLoaded = false;
  GetStorage instance = GetStorageHelper.instance("user");

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

  void changeTab(int index) {
    setState(() {
      _selectedTag = index;
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
                  backgroundColor: PRIMARY_COLOR,
                  foregroundColor: WHITH_COLOR,
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Circalicon(
                      iconData: Icons.arrow_back_ios_new_rounded,
                      color: WHITH_COLOR,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  actions: [
                    instance.read("role") == "Student"
                        ? Container()
                        : instrctorAddLeactuerAssingment(
                            LVM: LVM, widget: widget, AVM: AVM),
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
                              Text(
                                "${widget.subject.department!.name}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: MIN_SPACER,
                              ),
                              ImageAndTitle(
                                imagePath: widget.subject.image!,
                                title: "${widget.subject.name}",
                                textColor: BLACK_COLOR,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: SMALL_SPACER * .5),
                        CustomTabView(
                          tags: ["Lectuers", "assignments"],
                          index: _selectedTag,
                          changeTab: changeTab,
                        ),
                        SizedBox(
                          height: MIN_SPACER,
                        ),
                        _selectedTag == 0
                            ? Container(
                                child: LecturerPage(
                                  subject: widget.subject,
                                ),
                              )
                            : Container(
                                child: AssingmentPage(
                                  subject: widget.subject,
                                ),
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

class instrctorAddLeactuerAssingment extends StatelessWidget {
  const instrctorAddLeactuerAssingment({
    super.key,
    required this.LVM,
    required this.widget,
    required this.AVM,
  });

  final LecturerVM LVM;
  final InstroctorSubject widget;
  final AssingmentVM AVM;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Builder(builder: (context) {
        return PopupMenuButton(
            itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text("Add Lecturer"),
                    onTap: () => showDialogC(context, LVM, widget.subject),
                  ),
                  PopupMenuItem(
                    child: Text("Add Assingment"),
                    onTap: () => showDialogC(context, AVM, widget.subject),
                  ),
                  PopupMenuItem(
                    child: Text("show student"),
                    onTap: () => Navigator.pushNamed(context, RepoutPage.ROUTE,
                        arguments: widget.subject),
                  )
                ]);
      }),
    );
  }
}
