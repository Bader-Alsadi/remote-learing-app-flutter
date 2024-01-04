import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/featuer/models/lecturer_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/subjects_model.dart';
import 'package:remote_learing_app_frontend/featuer/views/dashbord_page/dashbord_page.dart';
import 'package:remote_learing_app_frontend/featuer/views/login_page/login_page.dart';
import 'package:remote_learing_app_frontend/featuer/views/material_page/material_page.dart';
import 'package:remote_learing_app_frontend/featuer/views/my_course_page/instrctor_lecturer.dart';
import 'package:remote_learing_app_frontend/featuer/views/profile_page/profile_page.dart';
import 'package:remote_learing_app_frontend/featuer/views/root_page.dart/root_page.dart';
import 'package:remote_learing_app_frontend/featuer/views/settings_page.dart/settings_page.dart';

class RouteManger {
  static Route<dynamic>? genrtedRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginPage.ROUTE:
        {
          return MaterialPageRoute(builder: (context) => LoginPage());
        }
      case Dashboard.ROUTE:
        {
          return MaterialPageRoute(builder: (context) => Dashboard());
        }
      case InstroctorSubject.ROUTE:
        {
          Subject subject = settings.arguments as Subject;
          return MaterialPageRoute(
              builder: (context) => InstroctorSubject(
                    subject: subject,
                  ));
        }
      case RootPage.ROUTE:
        {
          return MaterialPageRoute(builder: (context) => RootPage());
        }
      case Profilepage.ROUTE:
        {
          return MaterialPageRoute(builder: (context) => Profilepage());
        }
      case SettingsPage.ROUTE:
        {
          return MaterialPageRoute(builder: (context) => SettingsPage());
        }
      case MaterialP.ROUTE:
        {
          Lecturer lecturer = settings.arguments as Lecturer;
          return MaterialPageRoute(
              builder: (context) => MaterialP(
                    lecturer: lecturer,
                  ));
        }
    }
  }
}
