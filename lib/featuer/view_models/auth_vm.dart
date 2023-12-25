import 'package:get_storage/get_storage.dart';
import 'package:remote_learing_app_frontend/core/constints/api_url.dart';
import 'package:remote_learing_app_frontend/core/helpers/get_storge_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_data.dart';

class AuthVM {
  GetStorage getStInstance = GetStorageHelper.instance("user");

  Future<Map> login(ReposteryData repo, Map<String, dynamic> data) async {
    Map resutle = await repo.login(APIurl.LOGIN, data);
    Map serverData = resutle["data"];

    if (!resutle["status"]) {
      return resutle;
    }
    getStInstance.write("name", serverData["name"]);
    getStInstance.write("email", serverData["email"]);
    getStInstance.write("token", serverData["token"]);
    return resutle;
  }
}
