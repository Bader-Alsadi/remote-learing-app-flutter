// ignore_for_file: file_names

import 'package:dio/dio.dart';

class DioHL {
  static Dio? object;

  DioHL._conest();

  static Dio instance() {
    object ??= Dio();
    return object!;
  }
}
