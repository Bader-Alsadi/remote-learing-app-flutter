import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/featuer/models/lecturer_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/subjects_model.dart';
import 'package:remote_learing_app_frontend/featuer/views/dashbord_page/dashbord_page.dart';
import 'package:remote_learing_app_frontend/featuer/views/login_page/login_page.dart';
import 'package:remote_learing_app_frontend/featuer/views/my_course_page/instrctor_lecturer.dart';
import 'package:remote_learing_app_frontend/featuer/views/root_page.dart/root_page.dart';

class RouteManger {
  static Route<dynamic>? genrtedRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginPage.ROUTE:
        {
          return MaterialPageRoute(builder: (context) => LoginPage());
        }
      case Dashboard.ROUTE:
        {
          String role = settings.arguments as String;
          return MaterialPageRoute(
              builder: (context) => Dashboard(
                    role: role,
                  ));
        }
      case InstroctorSubject.ROUTE:
        {
          Subject subject  = settings.arguments as Subject;
          return MaterialPageRoute(builder: (context) => InstroctorSubject(subject: subject,));
        }
         case RootPage.ROUTE:
        {
          return MaterialPageRoute(builder: (context) => RootPage());
        }
    }
  }
}
