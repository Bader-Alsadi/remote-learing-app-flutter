import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';

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
