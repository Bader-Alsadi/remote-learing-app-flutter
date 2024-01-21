import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:remote_learing_app_frontend/featuer/models/student_submission.dart';

import '../../core/constints/api_url.dart';
import '../../core/helpers/Dio_helper.dart';
import '../../core/repostery/repostery_data.dart';

class StudentSubmissionVM with ChangeNotifier{

  List<StudentSubmissoin> studentSubmission=[];
  Dio instanceDio = DioHL.instance();
  feachDate(ReposteryData repo, Map<String,dynamic> data) async {
    Map result = await repo
        .stroeData("${APIurl.STUDENT_SUBMISSION}",FormData.fromMap(data));
    print(result);
    if (result["status"]) {
      dynamic serverData = result["data"];
      int count= 0;
      studentSubmission  = serverData
          .map<StudentSubmissoin>(
              (e) {
                StudentSubmissoin studentInfo=StudentSubmissoin.fromJson(e as Map<String, dynamic>);
                studentInfo.color = colorList[count % colorList.length];
                count++;
                return studentInfo;
              })
          .toList();
    }

    notifyListeners();
    return studentSubmission;
  }
}