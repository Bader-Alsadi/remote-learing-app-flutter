
import 'package:flutter/material.dart';

class ToggleWidget extends StatelessWidget {
  ToggleWidget(
      {super.key,
      required this.switchC,
      required this.firstWidget,
      required this.secondWidget});
  bool switchC;
  Widget firstWidget, secondWidget;
  @override
  Widget build(BuildContext context) {
    return switchC ? firstWidget : secondWidget;
  }
}
