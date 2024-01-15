import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/image_paths.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/widgets/costom_svg_pictuer.dart';
import 'package:remote_learing_app_frontend/featuer/models/lecturer_model.dart';
import 'package:remote_learing_app_frontend/featuer/views/chat/list_chat.dart';
import 'package:remote_learing_app_frontend/featuer/views/settings_page/settings_page.dart';
import 'package:remote_learing_app_frontend/featuer/views/student_corces/student_corces.dart';
import 'package:remote_learing_app_frontend/featuer/views/student_materil_page.dart/student_matrial.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);
  static const String ROUTE = "route2";

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    StudentCorcesPage(),
    StudentMatrialPadge(
      title: " ",
      lecturer: Lecturer(),
    ),
    ChatList(),
    SettingsPage(
      title: "settings",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: PRIMARY_COLOR,
          backgroundColor: WHITH_COLOR,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              activeIcon: NavRouteImage(
                path: "${NAV_BAR_PATH}home${IS_SOLID}",
              ).animate().scale(duration: 300.ms),
              icon: NavRouteImage(
                path: "${NAV_BAR_PATH}home${IS_OUTLINE}",
              ),
              label: "Home Page",
            ),
            BottomNavigationBarItem(
              activeIcon: NavRouteImage(
                path: "${NAV_BAR_PATH}play${IS_SOLID}",
              ).animate().scale(duration: 300.ms),
              icon: NavRouteImage(
                path: "${NAV_BAR_PATH}play${IS_OUTLINE}",
              ),
              label: "My Learning",
            ),
            BottomNavigationBarItem(
              activeIcon: NavRouteImage(
                path: "${NAV_BAR_PATH}chat${IS_SOLID}",
              ).animate().scale(duration: 300.ms),
              icon: NavRouteImage(
                path: "${NAV_BAR_PATH}chat${IS_OUTLINE}",
              ),
              label: "Chat",
            ),
            BottomNavigationBarItem(
              activeIcon: NavRouteImage(
                path: "${NAV_BAR_PATH}settings${IS_SOLID}",
              ).animate().scale(duration: 300.ms),
              icon: NavRouteImage(
                path: "${NAV_BAR_PATH}settings${IS_OUTLINE}",
              ),
              label: "Settings",
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
    );
  }
}

const CourseImagesize = 120.0;
