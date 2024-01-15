import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
class ImageAndTitle extends StatelessWidget {
  ImageAndTitle(
      {super.key,
      required this.imagePath,
      required this.title,
      this.textColor});
  String imagePath;
  String title;
  Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
            imagePath,
          ),
        ),
        SizedBox(
          width: MIN_SPACER,
        ),
        Flexible(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        )
      ],
    );
  }
}
