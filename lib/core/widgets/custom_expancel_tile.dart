import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_icon_title.dart';

class ExpansionTileC extends StatelessWidget {
  ExpansionTileC({
    super.key,
    required this.title,
    required this.date,
    required this.note,
    required this.hours,
    required this.vidoe,
  });
  String title, date, note, hours, vidoe;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.all(0),
      title: Text(
        title,
        style: TEXT_BIG.copyWith(color: BLACK_COLOR),
      ),
      leading: Text(date, style: TEXT_NORMAL.copyWith(color: GRAY_COLOR)),
      trailing: Icon(Icons.file_download_outlined, color: BLACK_COLOR),
      children: [
        Text(
          note,
          style: SUB_TITLE,
          softWrap: true,
          textAlign: TextAlign.justify,
        ),
        IconWithText(
          icon: Icons.access_time_outlined,
          title: "${hours} hours",
        ),
        IconWithText(
          icon: Icons.slow_motion_video_rounded,
          title: "${vidoe} vidoe",
        ),
      ],
    );
  }
}
