import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:remote_learing_app_frontend/core/helpers/get_storge_helper.dart';
import 'package:remote_learing_app_frontend/core/manger_route.dart';
import 'package:remote_learing_app_frontend/core/them/app_them.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/download_vm.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/instructor_vm.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/lectuer_vm.dart';
import 'package:remote_learing_app_frontend/featuer/views/login_page/login_page.dart';
import 'package:remote_learing_app_frontend/featuer/views/material_page/material_page.dart';
import 'package:remote_learing_app_frontend/featuer/views/on_board_page/on_bord.dart';
import 'package:remote_learing_app_frontend/featuer/views/root_page.dart/root_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init("user");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  GetStorage instance = GetStorageHelper.instance("user");
  GetStorage isFrist = GetStorageHelper.instance("isFrist");
  bool? isfrist;
  @override
  Widget build(BuildContext context) {
    isfrist = isFrist.read("isFrist") ?? true;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<InstroctorVM>(
          create: (context) => InstroctorVM(),
        ),
        ChangeNotifierProvider<LecturerVM>(
          create: (context) => LecturerVM(),
        ),
        ChangeNotifierProvider<DownloadVM>(
          create: (context) => DownloadVM(),
        ),
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        theme: appThem,
        home: isfrist!
            ? Start1()
            : instance.read("token") == null
                ? LoginPage()
                : RootPage(),
        onGenerateRoute: RouteManger.genrtedRoute,
      ),
    );
  }
}
