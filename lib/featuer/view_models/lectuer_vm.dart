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

  storeLectuer(ReposteryData repo, int id, Lecturer lecturer) async {
    Map result = await repo.stroeData(
        "${APIurl.EROLLMENT}/${id}${APIurl.LECTURER}", lecturer.toJson());
    print(result);
    if (result["data"] != null && result["status"])
      lectrers.add(Lecturer.fromJson(result["data"]));
    notifyListeners();
    return result;
  }

  updateLectuer(ReposteryData repo, int subjectID, int lectuerID,
      Lecturer lecturer) async {
    Map result = await repo.updateData(
        "${APIurl.EROLLMENT}/${subjectID}${APIurl.LECTURER}/${lectuerID}",
        lecturer.toJson());
    print(result);
    if (result["data"] != null && result["status"]) {
      int index = lectrers.indexWhere((element) => element.id == lectuerID);
      if (index != null) {
        lectrers[index] = Lecturer.fromJson(result["data"]);
      }
      // lectrers.removeAt(index);
      notifyListeners();
    }
    return result;
  }

  deleteLectuer(
    ReposteryData repo,
    int subjectID,
    int lectuerID,
  ) async {
    print("${APIurl.EROLLMENT}/${subjectID}${APIurl.LECTURER}/${lectuerID}");
    Map result = await repo.deleteData(
        "${APIurl.EROLLMENT}/${subjectID}${APIurl.LECTURER}/${lectuerID}");
    print(result);
    if (result["data"] != null && result["status"]) {
      int index = lectrers.indexWhere((element) => element.id == lectuerID);
      lectrers.removeAt(index);
      notifyListeners();
    }

    return result;
  }
}
