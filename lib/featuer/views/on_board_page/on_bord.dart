import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_elevated_buttom.dart';
import 'package:remote_learing_app_frontend/featuer/views/on_board_page/data/on_board_data.dart';

class Start1 extends StatefulWidget {
  Start1({super.key});

  @override
  State<Start1> createState() => _Start1State();
}

class _Start1State extends State<Start1> {
  PageController pageController = PageController();

  int selsctePage = 0;

  @override
  Widget build(BuildContext context) {
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
                              : THIRD_COLOR),
                    ),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: SPACER),
            child: CustomElevatedBottom(
              backColor: PRIMARY_COLOR,
              lable: "Get Started",
            ),
          ),
        ],
      ),
    );
  }
}

class OnBoradPage extends StatelessWidget {
  OnBoradPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subTitle,
  });
  String imagePath, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: AnimateList(
            interval: 200.ms,
            effects: [FadeEffect(duration: 300.ms)],
            children: [
              Image.asset(imagePath).animate(
                  autoPlay: true, effects: [FadeEffect(duration: 800.ms)]),
              SizedBox(
                height: SPACER,
              ),
              Text(
                title,
                style: TITLE,
              ),
              SizedBox(
                height: SMALL_SPACER * .6,
              ),
              Text(
                subTitle,
                style: SUB_TITLE,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SPACER * 4,
              )
            ],
          ),
        ));
  }
}
