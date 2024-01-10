import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';

class HeadLine extends StatelessWidget {
  HeadLine({super.key, required this.head, this.onPressed});

  final String head;
  VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          head,
          style: TEXT_NORMAL,
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            "See All",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: PRIMARY_COLOR),
          ),
        )
      ],
    );
  }
}
