import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/core/helpers/get_storge_helper.dart';
import 'package:remote_learing_app_frontend/core/widgets/costom_toggle.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_elevated_buttom.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_filed.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_icon.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_image.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_title_sub_title.dart';

class Profilepage extends StatefulWidget {
  Profilepage({
    super.key,
  });
  static const String ROUTE = "profile";

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  bool isconnectd = false;
  GetStorage instance = GetStorageHelper.instance("user");
  bool editmode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: BLACK_COLOR,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Circalicon(
            iconData: Icons.arrow_back_ios_new_rounded,
          ),
        ),
        title: Text(
          "Edit profile",
          style: TEXT_NORMAL.copyWith(color: BLACK_COLOR),
        ),
        centerTitle: true,
      ),

      body: Container(
        width: double.infinity,
        height: MediaQuery.sizeOf(context).height * .65,
        padding: EdgeInsets.symmetric(horizontal: SMALL_SPACER / 2),
        margin: EdgeInsets.symmetric(vertical: SMALL_SPACER * .5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Align(
              child: ImageProfile(
                imagePath: "assets/images/courses/profile.jpeg",
                name: instance.read("name"),
                subTilte: instance.read("role"),
              ),
            ),
            ToggleWidget(
                switchC: editmode,
                firstWidget: TilteAndSubTile(
                  title: "Email",
                  subtile: instance.read("email"),
                ),
                secondWidget: CustomTextFiled(
                  title: "Email",
                  lable: "",
                )),
            ToggleWidget(
                switchC: editmode,
                firstWidget: TilteAndSubTile(
                  title: "Email",
                  subtile: instance.read("email"),
                ),
                secondWidget: CustomTextFiled(
                  title: "Email",
                  lable: "",
                )),
            ToggleWidget(
                switchC: editmode,
                firstWidget: TilteAndSubTile(
                  title: "Email",
                  subtile: instance.read("email"),
                ),
                secondWidget: CustomTextFiled(
                  title: "Email",
                  lable: "",
                )),
          ],
        ),
      ),
      bottomNavigationBar: Container(
          // width: double.infinity,
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: SMALL_SPACER / 2),
          child: ToggleWidget(
            switchC: editmode,
            firstWidget: Row(
              children: [
                Flexible(
                  child: CustomElevatedBottom(
                    lable: "Eidt profile",
                    onPressedFun: () {
                      editmode = !editmode;
                      setState(() {});
                    },
                    mairgn: 0,
                    backColor: PRIMARY_COLOR,
                  ),
                ),
                Flexible(
                  child: CustomElevatedBottom(
                    lable: "Eidt password",
                    titleColor: BLACK_COLOR,
                    mairgn: 0,
                    backColor: THIRD_COLOR,
                  ),
                )
                // ElevatedButton(onPressed: () {}, child: Text("bader"))
              ],
            ),
            secondWidget: Flexible(
              child: CustomElevatedBottom(
                lable: "save",
                titleColor: WHITH_COLOR,
                mairgn: 0,
                backColor: PRIMARY_COLOR,
                onPressedFun: () {
                  editmode = !editmode;
                  setState(() {});
                },
              ),
            ),
          )),
    );
  }
}
