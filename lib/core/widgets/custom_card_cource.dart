import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_image_title.dart';

class CourseCard extends StatelessWidget {
  CourseCard(
      {super.key,
      required this.title,
      required this.courseName,
      required this.courseImage,
      required this.instructorImage,
      required this.courseDescription});
  String title;
  String courseImage;
  String instructorImage;
  String courseName;
  String courseDescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * .25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  courseImage,
                  height: 120,
                  width: 150,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                width: MIN_SPACER,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    courseName,
                    style: TEXT_NORMAL,
                  ),
                  Text(
                    courseDescription,
                    style: TEXT_NORMAL,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: SMALL_SPACER,
                  ),
                  ImageAndTitle(
                    imagePath: instructorImage,
                    title: title,
                  ),
                ],
              )),
            ],
          ),
          LinearPercentIndicator(
            padding: EdgeInsets.all(0),
            percent: .5,
            progressColor: Color(0xFF479E4A),
            animation: true,
            lineHeight: 10,
            barRadius: Radius.circular(15),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "4/5 Module",
                style: TEXT_NORMAL,
              ),
              Text(
                "89%",
                style: TEXT_NORMAL,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
