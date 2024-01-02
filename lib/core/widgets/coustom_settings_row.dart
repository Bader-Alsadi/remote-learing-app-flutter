import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';

class RowSettings extends StatelessWidget {
  RowSettings(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.imagePath});
  String imagePath, title, subTitle;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: GRAY_COLOR, width: 2.0)),
          child: SvgPicture.asset("assets/icons/bell-bing.svg")),
    );
  }
}
