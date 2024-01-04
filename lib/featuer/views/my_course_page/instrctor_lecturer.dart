import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/helpers/ui_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_api.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_elevated_buttom.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_expancel_tile.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_filed.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_icon.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_image_title.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_pickdate.dart';
import 'package:remote_learing_app_frontend/featuer/models/lecturer_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/subjects_model.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/lectuer_vm.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/material_vm.dart';
import 'package:remote_learing_app_frontend/featuer/views/material_page/material_page.dart';

class InstroctorSubject extends StatelessWidget {
  InstroctorSubject({super.key, required this.subject});
  static const String ROUTE = "instrictor_subject";
  GlobalKey<FormState> FormKey = GlobalKey();
  AutovalidateMode validation = AutovalidateMode.always;
  List<TextEditingController> controllers =
      List.generate(3, (index) => TextEditingController());
  DateTime? selectData = DateTime.now();
  bool isloaded = true;
  Subject subject;
  bool isconnectd = true;
  @override
  Widget build(BuildContext context) {
    print("${subject.id}");
    final LVM = Provider.of<LecturerVM>(context);
    InternetConnectionChecker().hasConnection.then((value) {
      if (!value) {
        print("connectd: $value");
        if (subject.Lecturers.isEmpty)
          LVM.feachDate(ReposteryAPI(), subject).then(
            (value) {
              isconnectd = true;
              LVM.lectrers = value;
            },
          );
      } else {
        print("connectd: $value");
      }
    });
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
                iconData: Icons.add_card_rounded,
                onTap: () {
                  var showBottomSheet2 = showBottomSheet(
                      context: context,
                      builder: (context) => SingleChildScrollView(
                            child: Form(
                              key: FormKey,
                              autovalidateMode: validation,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomTextFiled(
                                    title: "Title",
                                    lable: "",
                                    controller: controllers[0],
                                    validate: validaterequired,
                                  ),
                                  CustomTextFiled(
                                    title: "Description",
                                    lable: "",
                                    controller: controllers[1],
                                    validate: validaterequired,
                                  ),
                                  CustomTextFiled(
                                    title: "Note",
                                    lable: "",
                                    controller: controllers[2],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 32.0,
                                      horizontal: SMALL_SPACER / 2,
                                    ).copyWith(bottom: 0),
                                    child:
                                        pickDateWidget(selectData: selectData),
                                  ),
                                  StatefulBuilder(
                                    builder: (context, setstate) =>
                                        CustomElevatedBottom(
                                      child: AnimatedButoom(isloaded: isloaded),
                                      lable: "save",
                                      backColor: PRIMARY_COLOR,
                                      onPressedFun: () async {
                                        if (FormKey.currentState!.validate()) {
                                          Lecturer lecturer = Lecturer(
                                              title: controllers[0].text,
                                              description: controllers[1].text,
                                              note: controllers[2].text,
                                              subjectId: subject.id,
                                              lecturerData: "$selectData"
                                                  .split(" ")
                                                  .first);
                                          isloaded = false;
                                          Map resutle;
                                          LVM
                                              .storeLectuer(ReposteryAPI(),
                                                  subject.id!, lecturer)
                                              .then((value) {
                                            resutle = value;
                                            if (resutle["status"])
                                              Navigator.pop(context);
                                            isloaded = true;
                                            showSnackBar(
                                                context, resutle["message"]);
                                            setstate(
                                              () {},
                                            );
                                          });

                                          setstate(
                                            () {},
                                          );
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ));
                },
              );
            }),
          ),
        ],
      ),
      body: subject.Lecturers.isEmpty
          ? Center(
              child: isconnectd
                  ? Text("no lecturers")
                  : SpinKitFadingCircle(
                      color: PRIMARY_COLOR,
                    ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: SMALL_SPACER / 2),
                margin: EdgeInsets.symmetric(vertical: SMALL_SPACER),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MIN_SPACER,
                    ),
                    ImageAndTitle(
                      imagePath: "assets/images/courses/course1.jpeg",
                      title: "${subject.name} | ${subject.department!.name}",
                    ),
                    Column(
                      children: subject.Lecturers.map((e) => Container(
                            child: InkWell(
                              onLongPress: () async {
                                MaterialVM MVM = MaterialVM();
                                var result =
                                    await MVM.feachDate(ReposteryAPI(), e);
                                showSnackBar(context, result["message"]);
                                if(result["status"])
                                Navigator.pushNamed(context, MaterialP.ROUTE,arguments: e);
                              },
                              child: ExpansionTileC(
                                subjectID: subject.id!,
                                lecturerID: e.id!,
                                LVM: LVM,
                                title: e.title!,
                                date: e.lecturerData!.split(" ").first,
                                vidoe: "",
                                hours: "s",
                                note: e.description!,
                              ),
                            ),
                          )).toList(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
