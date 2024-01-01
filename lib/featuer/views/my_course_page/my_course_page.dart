import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_api.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_card_cource.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_icon.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_serash_bar.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/instructor_vm.dart';
import 'package:remote_learing_app_frontend/featuer/views/my_course_page/instrctor_lecturer.dart';

class MyCourse extends StatelessWidget {
  MyCourse({super.key});
  static const String ROUTE = "dashbord";
  TextEditingController seashCo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final IVM = Provider.of<InstroctorVM>(context);
    if (!IVM.isloaded)
      IVM.feachDate(ReposteryAPI(), 7).then(
        (value) {
          IVM.insturoctor = value;
        },
      );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "My Courses",
          style: TextStyle(color: BLACK_COLOR),
        ),
      ),
      body: IVM.subjects.isEmpty
          ? Center(
              child: SpinKitCircle(
                color: PRIMARY_COLOR,
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: SMALL_SPACER / 2),
              margin: EdgeInsets.only(top: SMALL_SPACER),
              child: ListView(
                children: [
                  SerachBar(
                    hint: "searsh bar",
                    controller: seashCo,
                    suffixIcon: Icon(Icons.search),
                  ),
                  SizedBox(
                    height: SMALL_SPACER,
                  ),
                  Column(
                    children: IVM.subjects
                        .map((e) => InkWell(
                              onTap: () {
                                
                                Navigator.pushNamed(
                                    context, InstroctorSubject.ROUTE,
                                    arguments: e);
                              },
                              child: CourseCard(
                                  title:
                                      "${e.department!.name!}",
                                  courseName: e.name!,
                                  courseImage:
                                      "assets/images/courses/course1.jpeg",
                                  instructorImage:
                                      "assets/images/courses/course1.jpeg",
                                  courseDescription: e.description!),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
    );
  }
}
