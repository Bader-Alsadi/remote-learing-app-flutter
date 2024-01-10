
import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';

class CircleButton extends StatelessWidget {
  final Icon icon;
  final GestureTapCallback onPressed;
  CircleButton(
      {Key? key,
      required this.icon,
      required this.onPressed,
      this.color = PRIMARY_COLOR})
      : super(key: key);
  Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration:  BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Padding(
        padding:  EdgeInsets.all(8.0),
        child: 
          icon
       
      ),
    );
  }
}
