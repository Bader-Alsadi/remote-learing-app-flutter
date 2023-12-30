import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/api_url.dart';
import 'package:remote_learing_app_frontend/core/helpers/Dio_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_data.dart';
import 'package:remote_learing_app_frontend/featuer/models/insturctor_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/subjects_model.dart';

class InstroctorVM with ChangeNotifier {
  Insturoctor? insturoctor;
  List<Subject> subjects = [];
  bool isloaded = false;
  Dio instanceDio = DioHL.instance();
  Future<Insturoctor> feachDate(ReposteryData repo, int id) async {
    Map result = await repo.fetcheData("${APIurl.INSTROUCTOR_INFO}/$id");
    print(result);
    Insturoctor insturoctor =
        Insturoctor.fromJson(result["data"] as Map<String, dynamic>);
    subjects = insturoctor.subjects!;
    notifyListeners();
    isloaded = true;

    return insturoctor;
  }
}
