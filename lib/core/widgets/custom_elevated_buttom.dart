import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';

class CustomElevatedBottom extends StatelessWidget {
  CustomElevatedBottom({
    super.key,
    this.backColor,
    this.borderColor,
    this.child,
    this.titleColor,
    this.onPressedFun,
    this.lable = "",
    this.mairgn = 40.0,
  });
  String? lable;
  Color? backColor;
  Color? borderColor;
  Color? titleColor;
  Widget? child;
  Function()? onPressedFun;
  double? mairgn;
  double? width;

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
                  width: 1,
                  color: borderColor ?? backColor ?? PRIMARY_COLOR,
                ),
              ),
              backgroundColor: backColor ?? PRIMARY_COLOR,
            ),
            onPressed: onPressedFun ?? () {},
            child: child ??
                Text(
                  "  $lable  ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: titleColor ?? Colors.white,
                  ),
                )));
  }
}
