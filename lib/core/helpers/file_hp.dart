import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as Path;
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:remote_learing_app_frontend/core/helpers/directoryP_path_hb.dart';
import 'package:remote_learing_app_frontend/featuer/models/material_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/submission_model.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/material_vm.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/submission_vm.dart';

class FileHP {
  static FileHP? instance;
  static FileHP getInstanse() {
    if (instance == null) instance = FileHP();
    return instance!;
  }

  static var DirectoryPath = DirectoryPathHP.instance!.filePath;

  openfile(String path) {
    var filePath = "${DirectoryPath.path}/${Path.basename(path)}";
    print(" : $filePath");
    OpenFile.open(filePath);
  }

  Future<bool> checkFileExit(String path) async {
    bool fileExistCheck =
        await File("${DirectoryPath.path}/${Path.basename(path)}").exists();
    return fileExistCheck;
  }

  Future<File?> pickupFile() async {
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

  startDownload(
      CancelToken cancelToken, SubmissionVM SVM, Submission submission) async {
    int index = SVM.submissions.indexOf(submission);
    cancelToken = CancelToken();
    var filePath = "${DirectoryPath.path}/${Path.basename(submission.path!)}";
    print(filePath);

    try {
      await Dio().download(submission.path!, filePath,
          onReceiveProgress: (count, total) {
        SVM.download(SVM.submissions.indexOf(submission), (count / total));
        SVM.download(index, (count / total));
      }, cancelToken: cancelToken);
      SVM.downloading(index, false);
      SVM.fileExtis(index, true);
    } catch (e) {
      if (kDebugMode) print("cach$e");
    }
  }

  startDownload1(
      CancelToken cancelToken, MaterialVM MVM, Materiall material) async {
    int index = MVM.materials.indexOf(material);
    cancelToken = CancelToken();
    var filePath = "${DirectoryPath.path}/${Path.basename(material.path!)}";
    try {
      print("try");
      await Dio().download(material.path!, filePath,
          onReceiveProgress: (count, total) {
        MVM.download(index, (count / total));
      }, cancelToken: cancelToken);
      MVM.downloading(index, false);
      MVM.fileExtis(index, true);
    } catch (e) {
      if (kDebugMode) print("cach$e");
    }
  }

  cancelDownload(CancelToken cancelToken) {
    cancelToken.cancel();
  }

  Future<bool> deletafiel(String path) async {
    var filePath = "${DirectoryPath.path}/${Path.basename(path)}";
    bool fileExistCheck = await File(filePath).exists();
    if (fileExistCheck) await File(filePath).delete();
    fileExistCheck = await File(filePath).exists();
    return fileExistCheck;
  }
}
