import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/api_url.dart';
import 'package:remote_learing_app_frontend/core/helpers/Dio_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_data.dart';
import 'package:remote_learing_app_frontend/featuer/models/assingment_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/lescutrer_sub.dart';
import 'package:remote_learing_app_frontend/featuer/models/submission_model.dart';

class SubmissionVM with ChangeNotifier {
  List<Submission>? submissions;
  Dio instanceDio = DioHL.instance();
  Future<List<Submission>?> feachDate(
      ReposteryData repo, Assingment assingment) async {
    print(
        "${APIurl.ROOT}${APIurl.ASSINGMENT}/${assingment.id}${APIurl.SUBMISSION}");
    Map result = await repo.fetcheData(
        "${APIurl.ROOT}${APIurl.ASSINGMENT}/${assingment.id}${APIurl.SUBMISSION}");
    print(result);
    if (result["status"]) {
      dynamic serverData = result["data"];
      submissions = assingment.submissions = serverData
          .map<Submission>(
              (e) => Submission.fromJson(e as Map<String, dynamic>))
          .toList();
    } else
      submissions = [];
    notifyListeners();
    return submissions;
  }

  updateLectuer(
      ReposteryData repo, int assingment_id, int submission_id,Submission date) async {
    print(date.toString());
    Map result = await repo.updateData(
        "${APIurl.ROOT}${APIurl.ASSINGMENT}/${assingment_id}${APIurl.SUBMISSION}/$submission_id",
        date.toJson());
    print(result);
    // if (result["data"] != null && result["status"]) {
    //   int index = lectrers.indexWhere((element) => element.id == lectuerID);
    //   print(lectrers[index].title);
    //   lectrers[index] = Lecturer.fromJson(result["data"]);
    //       notifyListeners();
    // }
    return result;
  }

  download(int index, double value) {
    submissions![index].progress = value;
    notifyListeners();
  }
}
