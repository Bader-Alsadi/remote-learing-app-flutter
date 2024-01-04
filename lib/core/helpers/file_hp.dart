import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:remote_learing_app_frontend/core/helpers/directoryP_path_hb.dart';

class FileHP {
  static FileHP? instance;

  static Future<FileHP> getInstanse() async {
    if (instance == null) instance = FileHP();
    DirectoryPath = await getpath();
    return instance!;
  }

  static var getPathFile = DirectoryPathHP();
  static late String DirectoryPath;

  static Future<String> getpath() async {
    return await getPathFile.getPath();
  }

  openfile(String path) {
    print(" : $path");
    OpenFile.open(path);
  }

  checkFileExit(String path) async {
    bool fileExistCheck = await File(path).exists();
    return fileExistCheck;
  }
}
