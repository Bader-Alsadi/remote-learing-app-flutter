import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/helpers/get_storge_helper.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_elevated_buttom.dart';
import 'package:remote_learing_app_frontend/featuer/views/login_page/login_page.dart';
import 'package:remote_learing_app_frontend/featuer/views/on_board_page/widgets/on_borad_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Start1 extends StatefulWidget {
  Start1({super.key});

  @override
  State<Start1> createState() => _Start1State();
}

class _Start1State extends State<Start1> {
  PageController pageController = PageController();

  int selsctePage = 0;
 late AppLocalizations? locale;

  @override
  Widget build(BuildContext context) {
    locale = AppLocalizations.of(context);
    List <Map> onBoradList = [
      {
        "image_path":"assets/images/on_bording_pahe/Welcome.gif",
        "title": locale!.fristPageTitle,
        "sub_title":locale!.fristPageDescripct,
      },
      {
        "image_path":"assets/images/on_bording_pahe/Transfer.gif",
        "title": locale!.secondPageTitle,
        "sub_title":locale!.secondPageDescripct,
      },
      {
        "image_path":"assets/images/on_bording_pahe/Learning .gif",
        "title": locale!.thiredPageTitle,
        "sub_title":locale!.secondPageDescripct,
      },

    ];
    return Scaffold(
      backgroundColor: WHITH_COLOR,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
              controller: pageController,
              onPageChanged: (int page) {
                selsctePage = page;

                setState(() {});
              },
              children: onBoradList
                  .map(
                    (e) => OnBoradPage(
                      imagePath: e["image_path"],
                      title: e["title"],
                      subTitle: e["sub_title"],
                    ),
                  )
                  .toList()),
          Positioned(
            top: MediaQuery.sizeOf(context).height * .75,
            child: Container(
              width: 60,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    3,
                    (index) => AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: 10,
                      width: index == selsctePage ? 20 : 10,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.5),
                          color: index == selsctePage
                              ? PRIMARY_COLOR
                              : GRAY_COLOR),
                    ),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: SPACER),
            child: CustomElevatedBottom(
              backColor: PRIMARY_COLOR,
              lable: locale!.getStrart,
              onPressedFun: () {
                GetStorageHelper.instance("user").write("isFrist", false);
                Navigator.pushReplacementNamed(context, LoginPage.ROUTE);
              },
            ),
          ),
        ],
      ),
    );
  }
}
