import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:remote_learing_app_frontend/core/helpers/directoryP_path_hb.dart';
import 'package:remote_learing_app_frontend/core/helpers/get_storge_helper.dart';
import 'package:remote_learing_app_frontend/core/manger_route.dart';
import 'package:remote_learing_app_frontend/core/them/app_them.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/assingment_vm.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/download_vm.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/course_vm.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/lectuer_vm.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/loaclixation_vm.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/material_vm.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/report_vm.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/submission_vm.dart';
import 'package:remote_learing_app_frontend/featuer/views/login_page/login_page.dart';
import 'package:remote_learing_app_frontend/featuer/views/on_board_page/on_bord.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:remote_learing_app_frontend/featuer/views/root_page.dart/root_page2.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init("user");
  await DirectoryPathHP.getInstanse();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // Loaclization inctanceLoaclization = Loaclization.getInstance();

  @override
  Widget build(BuildContext context) {
    // final inctanceLoaclization = Provider.of<Loaclization>(context);
    ;
    return MultiProvider(providers: [
      ChangeNotifierProvider<Loaclization>(
        create: (context) => Loaclization.getInstance(),
      ),
      ChangeNotifierProvider<CoucesVM>(
        create: (context) => CoucesVM(),
      ),
      ChangeNotifierProvider<LecturerVM>(
        create: (context) => LecturerVM(),
      ),
      ChangeNotifierProvider<DownloadVM>(
        create: (context) => DownloadVM(),
      ),
      ChangeNotifierProvider<MaterialVM>(
        create: (context) => MaterialVM(),
      ),
      ChangeNotifierProvider<AssingmentVM>(
        create: (context) => AssingmentVM(),
      ),
      ChangeNotifierProvider<SubmissionVM>(
        create: (context) => SubmissionVM(),
      ),
      ChangeNotifierProvider<ReportVM>(
        create: (context) => ReportVM(),
      ),
    ], child: MateAPP());
  }
}

class MateAPP extends StatelessWidget {
  MateAPP({super.key});
  GetStorage instance = GetStorageHelper.instance("user");
  GetStorage isFrist = GetStorageHelper.instance("isFrist");
  bool? isfrist;
  @override
  Widget build(BuildContext context) {
    isfrist = isFrist.read("isFrist") ?? true;
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        AppLocalizations.delegate
      ],
      locale: Locale(Provider.of<Loaclization>(context).getLanguageCode, ''),
      supportedLocales: [
        Locale('en', ''),
        Locale('ar', ''),
      ],
      theme: appThem.copyWith(
          textTheme: appThem.textTheme.apply(
        fontFamily: Provider.of<Loaclization>(context).languageCode == "ar"
            ? "Tajawal"
            : "Cairo",
      )),
      home: isfrist!
          ? Start1()
          : instance.read("token") == null
              ? LoginPage()
              : BaseScreen(),
      onGenerateRoute: RouteManger.genrtedRoute,
    );
  }
}
