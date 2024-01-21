import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
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

String? validaterequired(String? value) {
  // String pattern = r'(^[a-zA-Zا-ي]*$)';
  String pattern = '[0-9a-zA-Zء-ي ]+';

  RegExp regExp = RegExp(pattern);
  if (value!.isEmpty) {
    return "filed required";
  } else if (!regExp.hasMatch(value)) {
    return "الاسم ينبغي ان يكون من ١-ي او من a-z";
  }
  return null;
}

String? validatepassword(String? value) {
  // String pattern = r'(^[a-zA-Zا-ي]*$)';
  String pattern = '[0-9a-zA-Zء-ي ]+';

  RegExp regExp = RegExp(pattern);
  if (value!.isEmpty) {
    return "password required";
  } else if (!regExp.hasMatch(value)) {
    return "الاسم ينبغي ان يكون من ١-ي او من a-z";
  }
  return null;
}

String? validateEmail(String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value!.trim() ?? '')) {
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

////////////////////////Text file decortiont Start //////////////////////////////

InputDecoration getInputDecoration(
    {required String hint,
    required bool darkMode,
    required Color errorColor,
    Widget? suffixIcon}) {
  return InputDecoration(
    suffixIconColor: GRAY_COLOR,
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
      borderSide: BorderSide(color: GRAY_COLOR),
      borderRadius: BorderRadius.circular(25.0),
    ),
  );
}

InputDecoration getInputDecorationSB(
    {required String hint, required bool darkMode, Widget? suffixIcon}) {
  double borderRadius = 15;
  return InputDecoration(
    suffixIconColor: GRAY_COLOR,
    suffixIcon: suffixIcon,
    contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
    fillColor: darkMode ? Colors.black54 : WHITH_COLOR,
    hintText: hint,
    hintStyle: GRAY_TEXT,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: GRAY_COLOR),
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: GRAY_COLOR),
      borderRadius: BorderRadius.circular(borderRadius),
    ),
  );
}

InputDecoration textfiledDecortion() {
  return InputDecoration(
      prefixIcon: const Icon(
        Icons.search,
        color: PRIMARY_COLOR,
        size: ICON_SIZE,
      ),
      // helperText: "Search your topic",
      floatingLabelBehavior: FloatingLabelBehavior.never,
      labelText: "Search...",
      labelStyle: const TextStyle(color: GRAY_COLOR),
      filled: true,
      fillColor: WHITH_COLOR,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      isDense: true);
}
////////////////////////Text file decortiont end //////////////////////////////

///////////////////////BoxShadow design start /////////////////////////////////

var boxShadow2 = BoxShadow(
  color: BLACK_COLOR.withOpacity(.1),
  blurRadius: 4.0,
  spreadRadius: .05,
);
///////////////////////BoxShadow design end  ////////////////////////////////////

showSnackBar(BuildContext context, String message, bool state) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.startToEnd,
        showCloseIcon: true,
        backgroundColor: state ? PRIMARY_COLOR : FOURTH_COLOR,
        content: Text(
          message,
          style: TextStyle(color: WHITH_COLOR),
        ),
      ),
    );
}

Widget? AnimatedButoom({required bool isloaded}) {
  return isloaded
      ? null
      : SpinKitFadingGrid(
          size: 25,
          color: WHITH_COLOR,
        );
}

getFormatImage(String type) {
  switch (type) {

    case "png" || "jpg" || "jpeg":
      return "assets/images/media_format/png-svgrepo-com.svg";
    case "pdf":
      return "assets/images/media_format/pdf-svgrepo-com.svg";
    // case "xls":
    //   return "assets/images/media_format/icons8-xls-80.png";
    // case "mp4":
    //   return "assets/images/media_format/doc-svgrepo-com.svg";
    // case "doc" || "docm" || "docx":
    //   return "assets/images/media_format/icons8-doc-64.png";
    case "pptx" || "ppt":
      return "assets/images/media_format/ppt-svgrepo-com.svg";
    // case "rar":
    //   return "assets/images/media_format/icons8-rar-80.png";
    // case "zip":
    //   return "assets/images/media_format/icons8-zip-80.png";
    // case "txt":
    //   return "assets/images/media_format/icons8-txt-80.png";
    default:
      return "assets/images/media_format/file-minus-svgrepo-com.svg";
  }
}
