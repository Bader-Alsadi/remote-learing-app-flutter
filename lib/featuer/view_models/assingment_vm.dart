import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/api_url.dart';
import 'package:remote_learing_app_frontend/core/helpers/Dio_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_data.dart';
import 'package:remote_learing_app_frontend/featuer/models/assingment_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/lecturer_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/subjects_model.dart';

class AssingmentVM with ChangeNotifier {
  List<Assingment> assingments = [];
  Dio instanceDio = DioHL.instance();
  feachDate(ReposteryData repo, Subject subject) async {
    Map result = await repo
        .fetcheData("${APIurl.EROLLMENT}/${subject.id}${APIurl.ASSINGMENT}");
    print(result);
    if (result["status"]) {
      dynamic serverData = result["data"];
      assingments = subject.Lecturers = serverData
          .map<Assingment>(
              (e) => Assingment.fromJson(e as Map<String, dynamic>))
          .toList();
    } else
      assingments = [];
    notifyListeners();
    return assingments;
  }

  storeLectuer(ReposteryData repo, int id, Lecturer lecturer) async {
    Map result = await repo.stroeData(
        "${APIurl.EROLLMENT}/${id}${APIurl.ASSINGMENT}", lecturer.toJson());
    print(result);
    if (result["data"] != null && result["status"])
      assingments.add(Assingment.fromJson(result["data"]));
    print(assingments);
    notifyListeners();
    return result;
  }

  updateLectuer(ReposteryData repo, int subjectID, int lectuerID,
      Lecturer lecturer) async {
    Map result = await repo.updateData(
        "${APIurl.EROLLMENT}/${subjectID}${APIurl.ASSINGMENT}/${lectuerID}",
        lecturer.toJson());
    print(result);
    if (result["data"] != null && result["status"]) {
      int index = assingments.indexWhere((element) => element.id == lectuerID);
      print(assingments[index].title);
      if (index != null) {
        assingments[index] = Assingment.fromJson(result["data"]);
      }
      notifyListeners();
    }
    return result;
  }

  deleteLectuer(
    ReposteryData repo,
    int subjectID,
    int lectuerID,
  ) async {
    print("${APIurl.EROLLMENT}/${subjectID}${APIurl.ASSINGMENT}/${lectuerID}");
    Map result = await repo.deleteData(
        "${APIurl.EROLLMENT}/${subjectID}${APIurl.ASSINGMENT}/${lectuerID}");
    print(result);
    if (result["data"] != null && result["status"]) {
      int index = assingments.indexWhere((element) => element.id == lectuerID);
      assingments.removeAt(index);
      notifyListeners();
    }

    return result;
  }
}
