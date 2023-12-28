import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_card_cource.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_icon.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_serash_bar.dart';

class MyCourse extends StatelessWidget {
  MyCourse({super.key, required this.role});
  static const String ROUTE = "dashbord";
  late String role;
  TextEditingController seashCo = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Circalicon(
            iconData: Icons.arrow_back_ios_new_rounded,
          ),
        ),
        centerTitle: true,
        title: Text(
          "My Courses",
          style: TextStyle(color: BLACK_COLOR),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: SMALL_SPACER / 2),
        margin: EdgeInsets.symmetric(vertical: SMALL_SPACER),
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
            InkWell(
              onTap: () {
                
              },
              child: CourseCard(
                courseImage: "assets/images/courses/course1.jpeg",
                instructorImage: "assets/images/courses/course1.jpeg",
                courseName: "course 1",
                courseDescription:
                    "this corse speek about c++his corse speek about c++",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
