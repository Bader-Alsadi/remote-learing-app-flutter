
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';

class LoadingPage extends StatelessWidget {
   LoadingPage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitFadingCube(
              color: PRIMARY_COLOR,
            ),
            SizedBox(
              height: SMALL_SPACER,
            ),
            Text(
              "Loading...",
              style: TEXT_NORMAL,
            )

          ],
        ),
      );
  }
}
