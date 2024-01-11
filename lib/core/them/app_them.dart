import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';

ThemeData appThem = ThemeData(
  // expansionTileTheme: ExpansionTileThemeData(
  //   tilePadding: EdgeInsets.all(0),
  //   iconColor: WHITH_COLOR,
  // ),
  bottomAppBarTheme: BottomAppBarTheme(color: SECONDRY_COLOR),
  useMaterial3: true,
  fontFamily: "Cairo",
  appBarTheme: AppBarTheme(
    backgroundColor: WHITH_COLOR,
    elevation: 0,
  ),
  scaffoldBackgroundColor: WHITH_COLOR,
);
