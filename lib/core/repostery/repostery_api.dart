import 'package:dio/dio.dart';
import 'package:remote_learing_app_frontend/core/helpers/Dio_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_data.dart';

class ReposteryAPI extends ReposteryData {
  Dio dioInstance = DioHL.instance();

  @override
  Future<Map<String, dynamic>> fetcheData(String source) async {
    Response? response;
    try {
      response = await dioInstance.get(source);
      return response.data;
    } on DioException catch (e) {
      if (e.response == null) {
        return {"status": false, "message": "The opretion is faild"};
      } else {
        return {"message": e.response!.data};
      }
    }
  }

  @override
  Future<Map<String, dynamic>> stroeData(
      String source, Map<String, dynamic> data) async {
    final response = await dioInstance.post(source, data: data);
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> login(
      String source, Map<String, dynamic> data) async {
    Response? response;
    try {
      response = await dioInstance.post(source, data: data);
      return response!.data;
    } on DioException catch (e) {
      if (e.response == null) {
        return {"status": false, "message": "The opretion is faild"};
      } else {
        return e.response!.data;
      }
    }
  }
}
