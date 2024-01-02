import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:remote_learing_app_frontend/core/constints/api_url.dart';
import 'package:remote_learing_app_frontend/core/helpers/get_storge_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_data.dart';

class AuthVM {
  GetStorage getStInstance = GetStorageHelper.instance("user");

  Future<Map> login(ReposteryData repo, Map<String, dynamic> data) async {
    Map resutle = await repo.login(APIurl.LOGIN, data);

    if (!resutle["status"]) {
      return resutle;
    }
    Map serverData = resutle["data"];
    _adduserDetails(serverData);

    return resutle;
  }

  _adduserDetails(Map serverData) {
    debugPrint(serverData.toString());
    getStInstance.write("id", serverData["id"]);
    getStInstance.write("name", serverData["name"]);
    getStInstance.write("email", serverData["email"]);
    getStInstance.write("token", serverData["token"]);
    getStInstance.write("role", serverData["role_type"]);
    if (serverData["role_type"] == "Student") {
      getStInstance.write("deparment_id", serverData["deparment_id"]);
      getStInstance.write("department", serverData["department"]);
      getStInstance.write("level", serverData["level"]);
      getStInstance.write("semester", serverData["semester"]);
    }
  }
}
