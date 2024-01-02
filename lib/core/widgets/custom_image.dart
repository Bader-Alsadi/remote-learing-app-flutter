import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';

class ImageProfile extends StatelessWidget {
  ImageProfile({super.key, required this.imagePath, this.name, this.subTilte});
  String imagePath;
  String? name;
  String? subTilte;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: Image.asset(
            imagePath,
            height: 100,
          ),
        ),
        SizedBox(
          height: MIN_SPACER,
        ),
        Text(
          name!,
          style: TITLE,
        ),
        Text(
          subTilte!,
          style: GRAY_TEXT.copyWith(fontSize: 16),
        )
      ],
    );
  }
}