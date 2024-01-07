import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/api_url.dart';
import 'package:remote_learing_app_frontend/core/helpers/Dio_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_data.dart';
import 'package:remote_learing_app_frontend/featuer/models/assingment_model.dart';
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

  updateSubmission(ReposteryData repo, Submission date, int temp) async {
    print(date.studentId);
    Map result = await repo.updateData(
        "${APIurl.ROOT}${APIurl.SUBMISSION_GRADE_UPD}/${date.id}",
        date.toJson());
    if (!result["status"]) {
      date.grade = temp;
    }
    print(result);
    notifyListeners();
    return result;
  }

  download(int index, double value) {
    submissions![index].progress = value;
    notifyListeners();
  }
}
