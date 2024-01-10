import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/loaclixation_vm.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<dynamic> changeLangauge(BuildContext context) {
  Loaclization instance = Loaclization.getInstance();
  AppLocalizations? locale = AppLocalizations.of(context);

  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(locale!.language),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile(
                    title: Text(locale.arabic),
                    value: "ar",
                    groupValue: instance.getLanguageCode,
                    onChanged: (value) {
                      instance.setLanguageCode = value!;
                    }),
                RadioListTile(
                    title: Text("English"),
                    value: "en",
                    groupValue: instance.getLanguageCode,
                    onChanged: (value) {
                      instance.setLanguageCode = value!;
                    }),
              ],
            ),
          ));
}
