// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';

class CustomTabBar extends StatefulWidget {
  List<Widget> list;
  List<String> tabsTitle;
  CustomTabBar({Key? key, required this.list, required this.tabsTitle})
      : super(key: key);

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with TickerProviderStateMixin {
  // TabController? _tabController;

  // @override
  // void initState() {
  //   _tabController = TabController(length: 2, vsync: this);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(
        length: 2, vsync: this, animationDuration: Duration(milliseconds: 700));

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              vertical: SMALL_SPACER, horizontal: SMALL_SPACER / 2),
          padding: EdgeInsets.symmetric(
            vertical: MIN_SPACER,
          ),
          decoration: BoxDecoration(
              color: GRAY_COLOR.withOpacity(.3),
              borderRadius: BorderRadius.circular(SMALL_SPACER)),
          child: TabBar(
            indicator: BoxDecoration(
                color: BLACK_COLOR, borderRadius: BorderRadius.circular(30)),
            labelColor: WHITH_COLOR,
            unselectedLabelColor: BLACK_COLOR,
            controller: _tabController,
            unselectedLabelStyle: TextStyle(
              overflow: TextOverflow.ellipsis,
            ),
            tabs: [
              Tab(
                  child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                    child: Text(
                  widget.tabsTitle[0] ?? "",
                  selectionColor: Colors.blue,
                )),
              )),
              Tab(
                  child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(child: Text(widget.tabsTitle[1] ?? "")),
              )),
            ],
          ),
        ),
        Container(
          height: 521,
          width: double.maxFinite,
          child: TabBarView(
            controller: _tabController,
            children: widget.list,
          ),
        )
      ],
    );
  }
}
