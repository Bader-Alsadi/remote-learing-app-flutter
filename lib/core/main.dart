import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:remote_learing_app_frontend/core/helpers/get_storge_helper.dart';
import 'package:remote_learing_app_frontend/core/manger_route.dart';
import 'package:remote_learing_app_frontend/core/them/app_them.dart';
import 'package:remote_learing_app_frontend/featuer/views/dashbord_page/dashbord_page.dart';
import 'package:remote_learing_app_frontend/featuer/views/login_page/login_page.dart';
import 'package:remote_learing_app_frontend/featuer/views/show_course_page/show_course_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init("user");
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
GetStorage instance = GetStorageHelper.instance("user");
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: appThem,
      home:instance.read("token")==null? LoginPage() :ShowCourseInfo(),
      onGenerateRoute: RouteManger.genrtedRoute,
    );
  }
}
