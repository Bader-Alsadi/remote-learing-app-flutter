import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/core/helpers/get_storge_helper.dart';
import 'package:remote_learing_app_frontend/core/widgets/costom_crical_bottom.dart';
import 'package:remote_learing_app_frontend/core/widgets/costom_serash_filed.dart';

class StudentCouresAppBar extends StatefulWidget {
  StudentCouresAppBar({
    Key? key,
  }) : super(key: key);

  @override
  State<StudentCouresAppBar> createState() => _StudentCouresAppBarState();
}

class _StudentCouresAppBarState extends State<StudentCouresAppBar> {
  GetStorage instance = GetStorageHelper.instance("user");
  late int timeNow;
  @override
  void initState() {
    timeNow = DateTime.now().hour;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: SPACER, left: SMALL_SPACER * .5, right: SMALL_SPACER * .5),
      height: MediaQuery.sizeOf(context).height * 0.23,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(RADIUS),
          bottomRight: Radius.circular(RADIUS),
        ),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
          stops: [0.1, 0.4],
          colors: [
            SECONDRY_COLOR,
            PRIMARY_COLOR,
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello,\n${timeNow >= 1 && timeNow < 12 ? "Good Mornikng" : timeNow >= 12 && timeNow < 16 ? "Good Afternoon" : "Good Eveing "} ${instance.read("name")}",
                style: TEXT_BIG.copyWith(color: WHITH_COLOR),
              ),
              Badge(
                backgroundColor: FOURTH_COLOR.withOpacity(0.8),
                textColor: WHITH_COLOR,
                label: Text("2"),
                smallSize: 14,
                child: CircleButton(
                  icon: Icon(
                    Icons.notifications,
                    color: PRIMARY_COLOR,
                  ),
                  color: WHITH_COLOR,
                  onPressed: () {},
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const SearchTextField(),
        ],
      ),
    );
  }
}
