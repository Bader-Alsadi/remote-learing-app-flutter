import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/core/widgets/coustom_tool_bar.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_expancel_tile.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_icon.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_image_title.dart';

class ShowCourseInfo extends StatelessWidget {
  const ShowCourseInfo({super.key});

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
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 8.0),
        //     child: Circalicon(
        //       iconData: Icons.arrow_back_ios_new_rounded,
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: SMALL_SPACER / 2),
          margin: EdgeInsets.symmetric(vertical: SMALL_SPACER),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Introdction into c++ ",
                style: TEXT_BIG,
              ),
              SizedBox(
                height: MIN_SPACER,
              ),
              ImageAndTitle(
                imagePath: "assets/images/courses/course1.jpeg",
                title: "Bader Alsdy | moblie devloper",
              ),
              CustomTabBar(
                list: [
                  Container(
                    child: ExpansionTileC(
                      title: "Introdction into c++ ",
                      date: "week",
                      vidoe: "5",
                      hours: "5",
                      note:
                          "Lorem Ipsum is simply dummy text of the printing and typesetting indu Lorem Ipsum is simply dummy text of the printing and typesetting indu Lorem Ipsum is simply dummy text of the printing and typesetting indu.",
                    ),
                  ),
                  Container(
                    color: BLACK_COLOR,
                    child: Text("a"),
                  )
                ],
                tabsTitle: ["cds", "sdcs"],
              )
            ],
          ),
        ),
      ),
    );
  }
}

