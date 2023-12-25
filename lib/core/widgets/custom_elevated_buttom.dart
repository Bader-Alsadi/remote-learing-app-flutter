import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';

class CustomElevatedBottom extends StatelessWidget {
  CustomElevatedBottom(
      {super.key, backColor, titleColor, onPressedFun, lable = "", padding});
  String? lable;
  Color? backColor;
  Color? titleColor;
  Function()? onPressedFun;
  double? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            right: padding ?? 40.0, left: padding ?? 40.0, top: padding ?? 40),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
                side: BorderSide(
                  color: backColor ?? BLACK_COLOR,
                ),
              ),
              backgroundColor: backColor ?? BLACK_COLOR,
            ),
            // onPressed: () {},
            onPressed: onPressedFun ?? () {},
            child: Text(
              "  $lable  ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: titleColor ?? Colors.white,
              ),
            )));
  }
}
