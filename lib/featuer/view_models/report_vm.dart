import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/api_url.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_data.dart';
import 'package:remote_learing_app_frontend/featuer/models/report_model.dart';

class ReportVM with ChangeNotifier {
  List<Report> reports = [];

  Future<List<Report>> feachDate(ReposteryData repo, int id) async {
    print("${APIurl.REPORT}/$id");
    Map result = await repo.fetcheData("${APIurl.REPORT}/$id");
    print("instructor: $result");
    if (result["status"]) {
      List data = result["data"];
      reports =
          data.map((e) => Report.fromJson(e as Map<String, dynamic>)).toList();
    }
    notifyListeners();
    return reports;
  }
}
