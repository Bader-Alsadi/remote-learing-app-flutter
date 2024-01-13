import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';

class CustomTabView extends StatefulWidget {
  final Function(int) changeTab;
  final int index;
  const CustomTabView({Key? key, required this.changeTab, required this.index})
      : super(key: key);

  @override
  State<CustomTabView> createState() => _CustomTabViewState();
}

class _CustomTabViewState extends State<CustomTabView> {
  final List<String> _tags = ["Playlist (22)", "Description"];

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
            color: widget.index == index ? PRIMARY_COLOR : null,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            _tags[index],
            style: TEXT_NORMAL.copyWith(
                color: widget.index != index ? BLACK_COLOR : WHITH_COLOR),
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
        // padding: const EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(
          horizontal: MIN_SPACER * .7,
        ),
        width: MediaQuery.sizeOf(context).width * .9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: FOURTH_COLOR.withOpacity(0.1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _tags
              .asMap()
              .entries
              .map((MapEntry map) => _buildTags(map.key))
              .toList(),
        ),
      ),
    );
  }
}
