import 'package:dio/dio.dart';

abstract class ReposteryData {

  Future<Map<String, dynamic>> fetcheData (String source);
  Future<Map<String, dynamic>> stroeData (String source,FormData data);
  Future<Map<String, dynamic>> updateData (String source,FormData data);
  Future<Map<String, dynamic>> deleteData (String source);
  Future<Map<String, dynamic>>  login (String source,Map<String,dynamic> data);

}