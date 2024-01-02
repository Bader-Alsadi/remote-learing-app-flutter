import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';

class TilteAndSubTile extends StatelessWidget {
  TilteAndSubTile({super.key, required this.title, required this.subtile});
  String title, subtile;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TEXT_NORMAL,
        ),
        SizedBox(
          height: MIN_SPACER,
        ),
        Text(
          subtile,
          style: GRAY_TEXT,
        ),
      ],
    );
  }
}