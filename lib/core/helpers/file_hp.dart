import 'dart:io';

import 'package:file_picker/file_picker.dart';
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

  Future<File?> pickupFile() async {
    // final Directory appDocumentsDir = await getApplicationDocumentsDirectory();

    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: [
      "jpg",
      "jpeg",
      "png",
      "pdf",
      "xls",
      "mp4",
      "doc",
      "docm",
      "docx",
      "dot",
      "pptx",
      "rar",
      "zip",
      "txt",
      "mp4",
      "webm"
    ]);

    if (result != null) {
      File file = File(result.files.single.path!);
      print("${file.path}");
      return file;
    } else {
      print("filed");
      return null;
    }
  }
}
