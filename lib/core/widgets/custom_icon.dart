import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';

class Circalicon extends StatelessWidget {
  Circalicon({
    super.key,
    required this.iconData,
  });
  IconData iconData;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: THIRD_COLOR, width: 2.0)),
        child: Icon(
          iconData,
          color: BLACK_COLOR,
          size: 20,
        ),
      ),
    );
  }
}
