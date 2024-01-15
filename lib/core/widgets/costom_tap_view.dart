import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';

class CustomTabView extends StatefulWidget {
  final Function(int) changeTab;
  final int index;
  CustomTabView(
      {Key? key,
      required this.changeTab,
      required this.index,
      this.activeBotton,
      this.unactiveBotton,
      this.activeText,
      this.unactiveText,
      required this.tags})
      : super(key: key);
  Color? activeBotton, unactiveBotton, activeText, unactiveText;
  final List<String> tags ;
  @override
  State<CustomTabView> createState() => _CustomTabViewState();
}

class _CustomTabViewState extends State<CustomTabView> {

  Widget _buildTags(int index) {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          widget.changeTab(index);
        },
        child: Container(
          width: MediaQuery.sizeOf(context).width * .5,
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .07,
              vertical: 10),
          decoration: BoxDecoration(
            color: widget.index == index
                ? widget.activeBotton ?? PRIMARY_COLOR
                : null,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            widget.tags[index],
            style: TEXT_NORMAL.copyWith(
                color: widget.index != index
                    ? widget.unactiveText ?? BLACK_COLOR
                    : widget.activeText ?? WHITH_COLOR),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: MIN_SPACER * .7,
        ),
        width: MediaQuery.sizeOf(context).width * .9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: widget.unactiveBotton ?? FOURTH_COLOR.withOpacity(0.1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: widget.tags
              .asMap()
              .entries
              .map((MapEntry map) => _buildTags(map.key))
              .toList(),
        ),
      ),
    );
  }
}
