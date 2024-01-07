import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';

class Circalicon extends StatelessWidget {
  Circalicon({
    super.key,
    required this.iconData,
    this.onTap
  });
  Function ()? onTap;
  IconData iconData;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap ,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: GRAY_COLOR, width: 2.0)),
        child: Icon(
          iconData,
          color: BLACK_COLOR,
          size: 20,
        ),
      ),
    );
  }
}
