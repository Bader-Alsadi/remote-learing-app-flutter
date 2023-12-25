
import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/featuer/views/login_page/login_page.dart';

class RouteManger {
 static Route<dynamic>? genrtedRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginPage.ROUTE:
        {
          return MaterialPageRoute(builder: (context) =>  LoginPage());
        }
    }
  }
}
