

import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:shimmer/shimmer.dart';

class shmmierbox extends StatelessWidget {
  const shmmierbox(
      {super.key,
      required this.height,
      required this.width,
      this.boardRadius = 16});
  final double width, height, boardRadius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: GRAY_COLOR.withOpacity(0.4),
      highlightColor: WHITH_COLOR.withOpacity(0.4),
      period: Duration(seconds: 1),
      child: Container(
        height: height,
        width: width,
        margin: EdgeInsets.all(MIN_SPACER),
        decoration: BoxDecoration(
            color: BLACK_COLOR.withOpacity(0.4),
            borderRadius: BorderRadius.circular(boardRadius)),
      ),
    );
  }
}
