import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/image_paths.dart';
import 'package:remote_learing_app_frontend/core/helpers/get_storge_helper.dart';
import 'package:remote_learing_app_frontend/core/helpers/ui_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_api.dart';
import 'package:remote_learing_app_frontend/core/widgets/costom_cjhange_langouge_mathod.dart';
import 'package:remote_learing_app_frontend/core/widgets/costom_svg_pictuer.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/loaclixation_vm.dart';
import 'package:remote_learing_app_frontend/featuer/views/dashbord_page/dashbord_page.dart';
import 'package:remote_learing_app_frontend/featuer/views/login_page/login_page.dart';
import 'package:remote_learing_app_frontend/featuer/views/root_page.dart/root_page2.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:settings_ui/settings_ui.dart';

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
        backgroundColor: PRIMARY_COLOR,
        foregroundColor: WHITH_COLOR,
        title: NotmalWhitText(
          value: widget.title,
          color: WHITH_COLOR,
        ),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(tiles: [
            SettingsTile(
              title: ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: AssetImage(PLACE_HOLDER))),
                ),
                title: NotmalWhitText(value: instanceGetStorge.read("name")),
                subtitle:
                    NotmalGrayText(value: instanceGetStorge.read("email")),
              ),
            ),
          ]),
          SettingsSection(
            margin: EdgeInsetsDirectional.all(20),
            title: NotmalWhitText(
              value: locale!.presonalInformation,
              color: FOURTH_COLOR,
            ),
            tiles: [
              SettingsTile(
                title: NotmalWhitText(value: locale!.editProfile),
                leading: NavRouteImage(
                  path: "${SETTINGS_PAGE_PATH}person.svg",
                ),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: NotmalWhitText(value: locale!.changePassword),
                leading: NavRouteImage(
                  path: "${SETTINGS_PAGE_PATH}password.svg",
                ),
                onPressed: (BuildContext context) {},
              ),
            ],
          ),
          SettingsSection(
            margin: EdgeInsetsDirectional.all(20),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                NotmalWhitText(
                  value: locale!.theme,
                  color: FOURTH_COLOR,
                ),
              ],
            ),
            tiles: [
              SettingsTile(
                title: NotmalWhitText(value: locale!.language),
                description: NotmalWhitText(
                    color: BLACK_COLOR.withOpacity(0.3),
                    value:
                        "${locale!.localeName == "ar" ? "العربية" : "English"}"),
                leading: NavRouteImage(
                  path: "${SETTINGS_PAGE_PATH}language.svg",
                ),
                onPressed: (BuildContext context) {
                  changeLangauge(context);
                },
              ),
              SettingsTile.switchTile(
                activeSwitchColor: FOURTH_COLOR,
                initialValue: true,
                title: NotmalWhitText(value: locale!.darkMode),
                leading: NavRouteImage(
                  path: "${SETTINGS_PAGE_PATH}dark-mode.svg",
                ),
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
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                NotmalWhitText(
                  value: locale!.more,
                  color: FOURTH_COLOR,
                ),
              ],
            ),
            tiles: [
              SettingsTile(
                title: NotmalWhitText(value: locale!.aboutUs),
                leading: NavRouteImage(
                  path: "${SETTINGS_PAGE_PATH}about-us.svg",
                ),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                  title: NotmalWhitText(
                    value: locale!.privacy,
                  ),
                  leading: NavRouteImage(
                    path: "${SETTINGS_PAGE_PATH}shield-user.svg",
                  ),
                  onPressed: (BuildContext context) {}),
              SettingsTile(
                  title: NotmalWhitText(value: locale!.logout),
                  leading: NavRouteImage(
                    path:
                        "${SETTINGS_PAGE_PATH}logout-${Provider.of<Loaclization>(
                              context,
                            ).languageCode == "ar" ? "ar" : "en"}.svg",
                  ),
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
        showSnackBar(context, result["message"], result["status"]);
      }
    });
  }
}
