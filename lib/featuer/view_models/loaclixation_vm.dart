import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:remote_learing_app_frontend/core/helpers/get_storge_helper.dart';

class Loaclization with ChangeNotifier {
  static Loaclization? instance;

  String? languageCode;
  static Loaclization getInstance() {
    if (instance == null) {
      instance = Loaclization();
    }
    return instance!;
  }

  GetStorage _insatncLocal = GetStorageHelper.instance("laocliztion");

  String get getLanguageCode {
    print(languageCode);
    return _insatncLocal.read("langugae") ?? "en";
  }

  set setLanguageCode(String languageCode) {
    _insatncLocal.write("langugae", languageCode);
    this.languageCode = _insatncLocal.read("langugae") ?? "ar";
    print(languageCode);
    notifyListeners();
  }
}
