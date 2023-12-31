import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/featuer/views/my_course_page/my_course_page.dart';

const List<TabItem> items = [
  TabItem(
    icon: Icons.home,
    title: 'Home page',
  ),
  TabItem(
    icon: Icons.search_sharp,
    title: 'News',
  ),
  TabItem(
    icon: Icons.my_library_books_rounded,
    title: 'My Course',
  ),
  TabItem(
    icon: Icons.chat,
    title: 'Chat',
  ),
  TabItem(
    icon: Icons.account_box,
    title: 'profile',
  ),
];

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);
  static const String ROUTE = "root page";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<RootPage> {
  int selectPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITH_COLOR,
      body: [
        Center(
          child: Text(selectPage.toString()),
        ),
        Center(
          child: Text(selectPage.toString()),
        ),
        MyCourse(),
        Center(
          child: Text(selectPage.toString()),
        ),
        Center(
          child: Text(selectPage.toString()),
        ),
      ][selectPage],
      bottomNavigationBar: BottomBarCreative(
        top: 15,
        iconSize: 30,
        items: items,
        backgroundColor: WHITH_COLOR,
        color: THIRD_COLOR,
        colorSelected: PRIMARY_COLOR,
        indexSelected: selectPage,
        isFloating: true,
        highlightStyle: const HighlightStyle(
          sizeLarge: true,
          background: PRIMARY_COLOR,
          elevation: 3,
        ),
        onTap: (int index) => setState(() {
          selectPage = index;
        }),
      ),
    );
  }
}
