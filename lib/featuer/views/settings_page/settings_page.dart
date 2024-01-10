import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:remote_learing_app_frontend/core/constints/image_paths.dart';
import 'package:remote_learing_app_frontend/core/helpers/get_storge_helper.dart';
import 'package:remote_learing_app_frontend/core/helpers/ui_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_api.dart';
import 'package:remote_learing_app_frontend/core/widgets/costom_cjhange_langouge_mathod.dart';
import 'package:remote_learing_app_frontend/featuer/views/dashbord_page/dashbord_page.dart';
import 'package:remote_learing_app_frontend/featuer/views/login_page/login_page.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  AppLocalizations? locale;
  bool isSwitched = false;
  GetStorage instanceGetStorge = GetStorageHelper.instance("user");
  @override
  Widget build(BuildContext context) {
    locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: NotmalWhitText(value: widget.title),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(tiles: [
            SettingsTile(
              title: ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage(PLACE_HOLDER),
                ),
                title: NotmalWhitText(value: instanceGetStorge.read("name")),
                subtitle:
                    NotmalGrayText(value: instanceGetStorge.read("email")),
              ),
            ),
          ]),
          SettingsSection(
            margin: EdgeInsetsDirectional.all(20),
            title: NotmalWhitText(value: locale!.presonalInformation),
            tiles: [
              SettingsTile(
                title: NotmalWhitText(value: locale!.editProfile),
                leading: Icon(Icons.person),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: NotmalWhitText(value: locale!.changePassword),
                leading: Icon(Icons.password_rounded),
                onPressed: (BuildContext context) {},
              ),
            ],
          ),
          SettingsSection(
            margin: EdgeInsetsDirectional.all(20),
            title: NotmalWhitText(value: locale!.theme),
            tiles: [
              SettingsTile(
                title: NotmalWhitText(value: locale!.language),
                description: NotmalWhitText(
                    value:
                        "${locale!.localeName == "ar" ? "العربية" : "English"}"),
                leading: Icon(Icons.language),
                onPressed: (BuildContext context) {
                  changeLangauge(context);
                },
              ),
              SettingsTile.switchTile(
                initialValue: true,
                title: NotmalWhitText(value: locale!.darkMode),
                leading: Icon(Icons.phone_android),
                onToggle: (value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
            ],
          ),
          SettingsSection(
            margin: EdgeInsetsDirectional.all(20),
            title: NotmalWhitText(value: locale!.more),
            tiles: [
              SettingsTile(
                title: NotmalWhitText(value: locale!.aboutUs),
                leading: Icon(Icons.info_outline_rounded),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                  title: NotmalWhitText(
                    value: locale!.privacy,
                  ),
                  leading: Icon(Icons.privacy_tip_outlined),
                  onPressed: (BuildContext context) {}),
              SettingsTile(
                  title: NotmalWhitText(value: locale!.logout),
                  leading: Icon(Icons.login_outlined),
                  onPressed: (BuildContext context) {
                    logout();
                  }),
            ],
          ),
        ],
      ),
    );
  }

  logout() {
    ReposteryAPI().logout().then((value) {
      Map result = value;
      if (result["status"]) {
        Navigator.pushReplacementNamed(context, LoginPage.ROUTE);
      } else {
        showSnackBar(context, result["message"]);
      }
    });
  }
}
