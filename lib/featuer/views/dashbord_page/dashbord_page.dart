import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/core/helpers/get_storge_helper.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_image_title.dart';

class Dashboard extends StatelessWidget {
  Dashboard({
    super.key,
  });
  static const String ROUTE = "dashbord";

  TextEditingController seashCo = TextEditingController();
  GetStorage instance = GetStorageHelper.instance("user");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: ImageAndTitle(
            textColor: BLACK_COLOR,
            imagePath: "assets/images/courses/course1.jpeg",
            title: "welcome, ${instance.read("role")} !",
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(MIN_SPACER),
            child: Column(
              children: [
                Text(
                  "lets learing some thing new today!",
                  style: TITLE,
                ),
                SizedBox(
                  height: MIN_SPACER,
                ),
                Container(
                  height: MediaQuery.sizeOf(context).height * 0.35,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        PRIMARY_COLOR,
                        PRIMARY_COLOR.withOpacity(0.6),
                      ]),
                      borderRadius: BorderRadius.circular(25)),
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            VerticalDivider(
                              thickness: 2,
                              width: 10,
                              color: WHITH_COLOR,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 2,
                        height: 2,
                        color: WHITH_COLOR,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            VerticalDivider(
                              thickness: 2,
                              width: 10,
                              color: WHITH_COLOR,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
