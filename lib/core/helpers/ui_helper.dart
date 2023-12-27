import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';

String? validateName(String? value) {
  // String pattern = r'(^[a-zA-Zا-ي]*$)';
  String pattern = '[a-zA-Zء-ي ]+';

  RegExp regExp = RegExp(pattern);
  if (value?.isEmpty ?? true) {
    return "حقل الاسم متطلب";
  } else if (!regExp.hasMatch(value ?? '')) {
    return "الاسم ينبغي ان يكون من ١-ي او من a-z";
  }
  return null;
}

String? validateEmail(String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value ?? '')) {
    return "Ebter valid Email";
  } else {
    return null;
  }
}

bool isDarkMode(BuildContext context) {
  if (Theme.of(context).brightness == Brightness.light) {
    return false;
  } else {
    return true;
  }
}

InputDecoration getInputDecoration(
    {required String hint,
    required bool darkMode,
    required Color errorColor,
    Widget? suffixIcon}) {
  return InputDecoration(
    suffixIconColor: THIRD_COLOR,
    suffixIcon: suffixIcon,
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    fillColor: darkMode ? Colors.black54 : WHITH_COLOR,
    hintText: hint,
    hintStyle: GRAY_TEXT,
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(color: PRIMARY_COLOR, width: 2.0)),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: errorColor),
      borderRadius: BorderRadius.circular(25.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: errorColor),
      borderRadius: BorderRadius.circular(25.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: THIRD_COLOR),
      borderRadius: BorderRadius.circular(25.0),
    ),
  );
}

InputDecoration getInputDecorationSB(
    {required String hint, required bool darkMode, Widget? suffixIcon}) {
  double borderRadius = 15;
  return InputDecoration(
    suffixIconColor: THIRD_COLOR,
    suffixIcon: suffixIcon,
    contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
    fillColor: darkMode ? Colors.black54 : WHITH_COLOR,
    hintText: hint,
    hintStyle: GRAY_TEXT,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: THIRD_COLOR),
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: THIRD_COLOR),
      borderRadius: BorderRadius.circular(borderRadius),
    ),
  );
}

showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
}
