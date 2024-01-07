import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:remote_learing_app_frontend/core/constints/api_url.dart';
import 'package:remote_learing_app_frontend/core/helpers/Dio_helper.dart';
import 'package:remote_learing_app_frontend/core/helpers/get_storge_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_data.dart';

class ReposteryAPI extends ReposteryData {
  Dio dioInstance = DioHL.instance();
  GetStorage instance = GetStorageHelper.instance("user");

  @override
  Future<Map<String, dynamic>> fetcheData(String source) async {
    Response? response;
    try {
      response = await dioInstance.get(source, options: getOptionshedar());
      return response.data;
    } on DioException catch (e) {
      return responseDioException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> stroeData(String source, FormData data) async {
    Response? response;
    try {
      response = await dioInstance.post(source,
          data: data, options: getOptionshedar());
      return response.data;
    } on DioException catch (e) {
      return responseDioException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> updateData(String source, FormData data) async {
    print("insaid repo : ${data.fields}");
    Response? response;
    try {
      response =
          await dioInstance.post(source, data: data, options: getOptionshedar());
      return response.data;
    } on DioException catch (e) {
      return responseDioException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> deleteData(String source) async {
    Response? response;
    try {
      response = await dioInstance.delete(source, options: getOptionshedar());
      return response.data;
    } on DioException catch (e) {
      return responseDioException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> login(
      String source, Map<String, dynamic> data) async {
    Response? response;
    try {
      response = await dioInstance.post(source, data: data);
      return response.data;
    } on DioException catch (e) {
      return responseDioException(e);
    }
  }

  Future<Map> logout() async {
    try {
      final result =
          await dioInstance.get(APIurl.LOGOUT, options: getOptionshedar());
      if (result.data["status"]) {
        instance.erase();
        return result.data;
      } else {
        return {"status": false, "message": "The opretion is faild"};
      }
    } on DioException catch (e) {
      return responseDioException(e);
    }
  }

  Map<String, dynamic> responseDioException(DioException e) {
    if (e.response == null) {
      return {"status": false, "message": "The opretion is faild"};
    } else {
      print("state code : ${e.response!.statusCode}");
      if (e.response!.statusCode == 500) {
        return {"status": false, "message": e.response!.statusMessage};
      }
      if (e.response!.statusCode == 429) {
        return {
          "status": false,
          "message": "data not vaild",
          "data": e.response!.data
        };
      }
      return e.response!.data as Map<String, dynamic>;
    }
  }

  Options getOptionshedar() {
    return Options(headers: {"Authorization": DioHL.getToken()});
  }
}
