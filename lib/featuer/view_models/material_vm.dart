import 'package:dio/dio.dart';
import 'package:remote_learing_app_frontend/core/constints/api_url.dart';
import 'package:remote_learing_app_frontend/core/helpers/Dio_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_data.dart';
import 'package:remote_learing_app_frontend/featuer/models/lecturer_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/material_model.dart';

class MaterialVM {
  List<Materiall> materials = [];
  Dio instanceDio = DioHL.instance();
  feachDate(ReposteryData repo, Lecturer lecturer) async {
    print("${APIurl.ROOT}${APIurl.LECTURER}/${lecturer.id}${APIurl.MATERIAL}");
    Map result = await repo.fetcheData(
        "${APIurl.ROOT}${APIurl.LECTURER}/${lecturer.id}${APIurl.MATERIAL}");
    print(result);
    if (result["status"]) {
      dynamic serverData = result["data"]["matirels"];
      materials = lecturer.materials = serverData
          .map<Materiall>((e) => Materiall.fromJson(e as Map<String, dynamic>))
          .toList();
      lecturer.materials = materials;
    } else
      materials = [];
    print(materials);
    return result;
  }
}
