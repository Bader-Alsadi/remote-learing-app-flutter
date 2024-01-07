import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as Path;
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:remote_learing_app_frontend/core/helpers/directoryP_path_hb.dart';
import 'package:remote_learing_app_frontend/featuer/models/submission_model.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/submission_vm.dart';

class FileHP {
  static FileHP? instance;
  static Future<FileHP> getInstanse() async {
    if (instance == null) instance = FileHP();
    DirectoryPath = await getPathFile.getPath();
    return instance!;
  }

  static var getPathFile = DirectoryPathHP();
  static late String DirectoryPath;

  openfile(String path) {
    print(" : $path");
    OpenFile.open(path);
  }

  checkFileExit(String path) async {
    bool fileExistCheck =
        await File("${Path.basename(path)}/$DirectoryPath").exists();
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

  startDownload(
      CancelToken cancelToken, SubmissionVM SVM, Submission submission) async {
    print("${submission.path!}");
    cancelToken = CancelToken();
    var filePath = "$DirectoryPath/${Path.basename(submission.path!)}";
    print(filePath);
    // filePath = '$storePath/$fileName';
    // setState(() {
    //   dowloading = true;
    //   // DVMprogress = 0;
    // });

    try {
      print("try");
      await Dio().download(submission.path!, filePath,
          onReceiveProgress: (count, total) {
        SVM.download(SVM.submissions!.indexOf(submission), (count / total));
      }, cancelToken: cancelToken);
      // setState(() {
      //   dowloading = false;
      //   fileExists = true;
      // });
    } catch (e) {
      print("cach$e");
      // print(e);
      // setState(() {
      //   dowloading = false;
      // });
    }
  }
}
