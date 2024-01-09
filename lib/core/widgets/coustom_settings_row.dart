import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';

class RowSettings extends StatelessWidget {
  RowSettings(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.imagePath,
      this.onTap});
  String imagePath, title, subTitle;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: EdgeInsets.all(MIN_SPACER),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: GRAY_COLOR,
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(imagePath),
      ),
      title: Text(
        title,
        style: TEXT_NORMAL,
      ),
      subtitle: Text(
        subTitle,
        style: GRAY_TEXT,
      ),
      trailing: SvgPicture.asset(
        "assets/icons/right.svg",
        colorFilter: ColorFilter.mode(GRAY_COLOR, BlendMode.srcIn),
      ),
    );
  }
}
