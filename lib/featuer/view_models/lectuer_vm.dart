import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/api_url.dart';
import 'package:remote_learing_app_frontend/core/helpers/Dio_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_data.dart';
import 'package:remote_learing_app_frontend/featuer/models/lecturer_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/subjects_model.dart';

class LecturerVM with ChangeNotifier {
  List<Lecturer> lectrers = [];
  Dio instanceDio = DioHL.instance();
  feachDate(ReposteryData repo, Subject subject) async {
    Map result = await repo
        .fetcheData("${APIurl.EROLLMENT}/${subject.id}${APIurl.LECTURER}");
    print(result);
    if (result["status"]) {
      dynamic serverData = result["data"];
      lectrers = subject.Lecturers = serverData
          .map<Lecturer>((e) => Lecturer.fromJson(e as Map<String, dynamic>))
          .toList();
    } else
      lectrers = [];
    notifyListeners();
    return lectrers;
  }
}
