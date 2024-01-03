import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/api_url.dart';
import 'package:remote_learing_app_frontend/core/helpers/Dio_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_data.dart';
import 'package:remote_learing_app_frontend/featuer/models/lecturer_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/user_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/subjects_model.dart';

class InstroctorVM with ChangeNotifier {
  List<Subject> subjects = [];
  late User insturoctor;
  bool isloaded = false;
  Dio instanceDio = DioHL.instance();

  Future<User> feachDate(ReposteryData repo, int id) async {
    Map result = await repo.fetcheData("${APIurl.INSTROUCTOR_INFO}/$id");
    print("instructor: $result");
    if (result["status"]) {
      insturoctor = User.fromJson(result["data"] as Map<String, dynamic>);
      subjects = insturoctor.subjects!;
    } else
      insturoctor = User();
    notifyListeners();
    isloaded = true;

    return insturoctor;
  }

 
}
