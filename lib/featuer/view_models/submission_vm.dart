import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/api_url.dart';
import 'package:remote_learing_app_frontend/core/helpers/Dio_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_data.dart';
import 'package:remote_learing_app_frontend/featuer/models/assingment_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/submission_model.dart';

class SubmissionVM with ChangeNotifier {
  List<Submission> submissions = [];
  Dio instanceDio = DioHL.instance();
  Future<List<Submission>> feachDate(
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

  storeSubmission(
      ReposteryData repo, int assignmentId, Submission submission) async {
    Map result = await repo.stroeData(
        "${APIurl.ROOT}${APIurl.ASSINGMENT}/${assignmentId}${APIurl.SUBMISSION}",
        submission.toJson());
    print(result);
    if (result["data"] != null && result["status"])
      // submission.add(Materiall.fromJson(result["data"]));
      notifyListeners();
    return result;
  }

  updateSubmission(ReposteryData repo, Submission date, int temp) async {
    print(date.studentId);
    Map result = await repo.updateData(
        "${APIurl.ROOT}${APIurl.SUBMISSION_GRADE_UPD}/${date.id}",
        date.toJsonG());
    if (!result["status"]) {
      date.grade = temp;
    }
    print(result);
    notifyListeners();
    return result;
  }

  // download(int index, double value) {
  //   submissions![index].progress = value;
  //   notifyListeners();
  // }

  download(int index, double value) {
    submissions[index].dowloading = true;
    submissions[index].progress = value;
    notifyListeners();
  }

  fileExtis(int index, bool value) {
    submissions[index].fileExists = value;
    notifyListeners();
  }

  downloading(int index, bool value) {
    submissions[index].dowloading = value;
    notifyListeners();
  }

  deleteFromDivese(int index, bool value) {
    submissions[index].fileExists = value;
    notifyListeners();
  }
}
