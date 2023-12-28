import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';

class ImageAndTitle extends StatelessWidget {
   ImageAndTitle({
    super.key,
    required this.imagePath,
    required this.title
  });
  String imagePath;
  String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(
            imagePath,
          ),
        ),
        SizedBox(
          width: MIN_SPACER,
        ),
        Text(
          title,
          style: TEXT_NORMAL,
        ),
      ],
    );
  }
}
