import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';

class CustomElevatedBottom extends StatelessWidget {
  CustomElevatedBottom(
      {super.key,
      this.backColor,
      this.titleColor,
      this.onPressedFun,
      this.lable = "",
      this.mairgn = 40.0});
  String? lable;
  Color? backColor;
  Color? titleColor;
  Function()? onPressedFun;
  double? mairgn;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            horizontal: SMALL_SPACER / 2, vertical: mairgn! * .3),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.only(
                  top: SMALL_SPACER * .6, bottom: SMALL_SPACER * .6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
                side: BorderSide(
                  color: backColor ?? BLACK_COLOR,
                ),
              ),
              backgroundColor: backColor ?? BLACK_COLOR,
            ),
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
