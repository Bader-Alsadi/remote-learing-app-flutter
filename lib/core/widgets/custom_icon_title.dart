import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';

class IconWithText extends StatelessWidget {
  IconWithText({super.key, required this.icon, required this.title});
  String title;
  IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: MIN_SPACER),
      child: Row(
        children: [
          Icon(
            icon,
            color: THIRD_COLOR,
          ),
          Text(title)
        ],
      ),
    );
  }
}