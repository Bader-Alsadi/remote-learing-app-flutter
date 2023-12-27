import 'package:dio/dio.dart';
import 'package:remote_learing_app_frontend/core/helpers/Dio_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_data.dart';

class ReposteryAPI extends ReposteryData {
  Dio dioInstance = DioHL.instance();

  @override
  Future<Map<String, dynamic>> fetcheData(String source) async {
    final response = await dioInstance.post(source);
    return response.data;
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
    String message = "";
    Response? response;
    try {
      response = await dioInstance.post(source, data: data);
      return response!.data;
    } on DioException catch (e) {
      if (e.response == null) {
        return {
          "status": false,
          "message": "There is not net work connection or wrong url"
        };
      } else {
        return e.response!.data;
      }
    }
  }
}
