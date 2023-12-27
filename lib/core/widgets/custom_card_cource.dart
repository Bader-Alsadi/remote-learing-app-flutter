import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';

class CourseCard extends StatelessWidget {
  CourseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.sizeOf(context).height * .20,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  "assets/images/courses/course1.jpeg",
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
                    "course 1",
                    style: TEXT_NORMAL,
                  ),
                  Text(
                    "this corse speek about c++his corse speek about c++",
                    style: TEXT_NORMAL,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: SMALL_SPACER,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(
                          "assets/images/courses/course1.jpeg",
                        ),
                      ),
                      SizedBox(
                        width: MIN_SPACER,
                      ),
                      Text(
                        "course 1",
                        style: TEXT_NORMAL,
                      ),
                    ],
                  )
                ],
              )),
            ],
          ),
          SizedBox(
            height: SMALL_SPACER,
          ),
          LinearPercentIndicator(
            padding: EdgeInsets.all(0),
            percent: .5,
            progressColor: Color(0xFF479E4A),
            animation: true,
            lineHeight: 10,
            barRadius: Radius.circular(15),
          ),
        ],
      ),
    );
  }
}
