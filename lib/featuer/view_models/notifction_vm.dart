import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../core/constints/api_url.dart';
import '../../core/helpers/Dio_helper.dart';
import '../../core/repostery/repostery_data.dart';
import '../models/notifction_model.dart';

class NotifctionVM with ChangeNotifier {
  List<Notifction> notifction = [];

  Dio instanceDio = DioHL.instance();
  Future<List<Notifction>> feachDate(
      ReposteryData repo, int userId) async {
    print("${APIurl.GET_NOTIFCTION}$userId");
    Map result = await repo.fetcheData(
        "${APIurl.GET_NOTIFCTION}$userId");
    print(result);
    if (result["status"]) {
      dynamic serverData = result["data"];
      notifction = serverData
          .map<Notifction>((e) => Notifction.fromJson(e as Map<String, dynamic>))
          .toList();
    } else
      notifction = [];
    print(notifction);
    notifyListeners();
    return notifction;
  }
}