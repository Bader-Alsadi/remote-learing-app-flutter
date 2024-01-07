import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/api_url.dart';
import 'package:remote_learing_app_frontend/core/helpers/Dio_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_data.dart';
import 'package:remote_learing_app_frontend/featuer/models/assingment_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/lescutrer_sub.dart';
import 'package:remote_learing_app_frontend/featuer/models/subjects_model.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/Assingment_lecturer.dart';

class AssingmentVM extends ALVM with ChangeNotifier {
  List<Assingment> assingments = [];
  Dio instanceDio = DioHL.instance();
  feachDate(ReposteryData repo, Subject subject) async {
    Map result = await repo
        .fetcheData("${APIurl.EROLLMENT}/${subject.id}${APIurl.ASSINGMENT}");
    print(result);
    if (result["status"]) {
      dynamic serverData = result["data"];
      assingments = subject.assingments = serverData
          .map<Assingment>(
              (e) => Assingment.fromJson(e as Map<String, dynamic>))
          .toList();
    } else
      assingments = [];
    notifyListeners();
    return assingments;
  }

  storeLectuer(ReposteryData repo, int id, LeacturerSub lecturer) async {
    print(lecturer.toJson().toString());
    Map result = await repo.stroeData(
        "${APIurl.EROLLMENT}/${id}${APIurl.ASSINGMENT}", lecturer.toJson());
    print(result);
    if (result["data"] != null && result["status"])
      assingments.add(Assingment.fromJson(result["data"]));
    print(assingments);
    notifyListeners();
    return result;
  }

  updateLectuer(ReposteryData repo, int subjectID, int assingmentID,
      LeacturerSub lecturer) async {
    // print("${APIurl.ROOT}${APIurl.ASSINGMENT_UPDATE}/${assingmentID}");
    Map result = await repo.updateData(
        "${APIurl.ROOT}${APIurl.ASSINGMENT_UPDATE}/${assingmentID}",
        lecturer.toJson());
    print(result);
    if (result["data"] != null && result["status"]) {
      int index =
          assingments.indexWhere((element) => element.id == assingmentID);
      print(assingments[index].title);
      assingments[index] = Assingment.fromJson(result["data"]);
      notifyListeners();
    }
    return result;
  }

  deleteLectuer(
    ReposteryData repo,
    int subjectID,
    int assingmentID,
  ) async {
    print(
        "${APIurl.EROLLMENT}/${subjectID}${APIurl.ASSINGMENT}/${assingmentID}");
    Map result = await repo.deleteData(
        "${APIurl.EROLLMENT}/${subjectID}${APIurl.ASSINGMENT}/${assingmentID}");
    print(result);
    if (result["data"] != null && result["status"]) {
      int index =
          assingments.indexWhere((element) => element.id == assingmentID);
      assingments.removeAt(index);
      notifyListeners();
    }

    return result;
  }
}
