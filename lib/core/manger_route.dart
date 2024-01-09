import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/featuer/models/assingment_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/lecturer_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/subjects_model.dart';
import 'package:remote_learing_app_frontend/featuer/views/dashbord_page/dashbord_page.dart';
import 'package:remote_learing_app_frontend/featuer/views/login_page/login_page.dart';
import 'package:remote_learing_app_frontend/featuer/views/material_page/materia_page2.dart';
import 'package:remote_learing_app_frontend/featuer/views/my_course_page/instrctor_lecturer.dart';
import 'package:remote_learing_app_frontend/featuer/views/profile_page/profile_page.dart';
import 'package:remote_learing_app_frontend/featuer/views/root_page.dart/root_page.dart';
import 'package:remote_learing_app_frontend/featuer/views/settings_page.dart/settings_page.dart';
import 'package:remote_learing_app_frontend/featuer/views/submission_page/submission_page.dart';

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
      //   case SubmissionPage.ROUTE:
      //   {
      //     return MaterialPageRoute(builder: (context) => SettingsPage());
      //   }
      // case SubmissionPage.ROUTE:
      //   {
      //     var assingment = settings.arguments as Assingment;
      //     return MaterialPageRoute(
      //         builder: (context) => SubmissionPage(
      //               assingment: assingment,
      //             ));
      //   }
      case Material2.ROUTE:
        {
          Lecturer lecturer = settings.arguments as Lecturer;
          return MaterialPageRoute(
              builder: (context) => Material2(
                    lecturer: lecturer,
                  ));
        }

        case SubmissionPage2.ROUTE:
        {
          Assingment assingment = settings.arguments as Assingment;
          return MaterialPageRoute(
              builder: (context) => SubmissionPage2(
                    assingment: assingment,
                  ));
        }
    }
    
    return null;
  }
}
