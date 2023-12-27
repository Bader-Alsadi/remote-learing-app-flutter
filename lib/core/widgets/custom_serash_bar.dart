import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/helpers/ui_helper.dart';

class SerachBar extends StatelessWidget {
  SerachBar({super.key, this.hint = "", this.controller,this.suffixIcon,});
  String? hint;
  TextEditingController? controller;
    Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: getInputDecorationSB(
        suffixIcon: suffixIcon,
        hint: hint!,
        darkMode: isDarkMode(context),
      ),
    );
  }
}
