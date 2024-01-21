import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';

class IconWithText extends StatelessWidget {
  IconWithText({super.key, required this.icon, required this.title,this.iconColor});
  String title;
  IconData icon;
  Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: MIN_SPACER),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color:iconColor?? GRAY_COLOR,
          ),
          Text(title)
        ],
      ),
    );
  }
}
