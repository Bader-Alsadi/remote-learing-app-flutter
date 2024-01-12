import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/core/helpers/ui_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_api.dart';
import 'package:remote_learing_app_frontend/core/widgets/costom_cjhange_langouge_mathod.dart';
import 'package:remote_learing_app_frontend/core/widgets/coustom_settings_row.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/loaclixation_vm.dart';
import 'package:remote_learing_app_frontend/featuer/views/login_page/login_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  static const ROUTE = "settings_page";
  Loaclization instance = Loaclization.getInstance();
  late AppLocalizations? locale;

  @override
  Widget build(BuildContext context) {
    locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TEXT_NORMAL.copyWith(
            color: BLACK_COLOR,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(MIN_SPACER),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MIN_SPACER,
            ),
            Container(
              height: MediaQuery.sizeOf(context).height * 0.35,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    PRIMARY_COLOR,
                    PRIMARY_COLOR.withOpacity(0.6),
                  ]),
                  borderRadius: BorderRadius.circular(25)),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        VerticalDivider(
                          thickness: 2,
                          width: 10,
                          color: WHITH_COLOR,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    height: 2,
                    color: WHITH_COLOR,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        VerticalDivider(
                          thickness: 2,
                          width: 10,
                          color: WHITH_COLOR,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SMALL_SPACER,
            ),
            Text(
              "Account Details",
              style: TEXT_NORMAL,
            ),
            RowSettings(
              title: "Profile",
              subTitle: "show youe dettails",
              imagePath: "assets/icons/user.svg",
            ),
            RowSettings(
              title: locale!.language,
              subTitle: " ",
              imagePath: "assets/icons/exit.svg",
              onTap: () {
                changeLangauge(context);
              },
            ),
            RowSettings(
              title: "Exist",
              subTitle: " ",
              imagePath: "assets/icons/exit.svg",
              onTap: () {
                ReposteryAPI().logout().then((value) {
                  Map result = value;
                  if (result["status"]) {
                    Navigator.pushReplacementNamed(context, LoginPage.ROUTE);
                  } else {
                    showSnackBar(context, result["message"],result["status"]);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

}
