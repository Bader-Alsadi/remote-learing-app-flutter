import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:remote_learing_app_frontend/core/constints/api_url.dart';
import 'package:remote_learing_app_frontend/core/helpers/Dio_helper.dart';
import 'package:remote_learing_app_frontend/core/helpers/get_storge_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_data.dart';
import 'package:remote_learing_app_frontend/featuer/models/subjects_model.dart';

class CoucesVM with ChangeNotifier {
  List<Subject> subjects = [];
  bool isloaded = false;
  Dio instanceDio = DioHL.instance();
  GetStorage instance = GetStorageHelper.instance("user");

  Future<List<Subject>> feachDate(ReposteryData repo, int id) async {
    print("url ${APIurl.INSTROUCTOR_INFO}/$id");
    String sourseurl = instance.read("role") == "Student"
        ? "${APIurl.ROOT}${APIurl.DEPARTMENT}/$id${APIurl.STUDENT}"
        : "${APIurl.INSTROUCTOR_INFO}/$id";
    print(instance.read("role_type"));
    Map result = await repo.fetcheData(sourseurl);
    print("instructor: $result");
    if (result["status"]) {
      List data = result["data"];
      subjects =
          data.map((e) => Subject.fromJson(e as Map<String, dynamic>)).toList();
    }
    notifyListeners();
    return subjects;
  }

  List<int?> enrolmentIds (){
    return subjects.map((e) => e.id).toList();
  }

}
