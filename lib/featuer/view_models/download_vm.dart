import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DownloadVM with ChangeNotifier {
  double progress = 0;
  bool dowloading = false;
  bool fileExists = false;
  CancelToken? cancelToken;

  DownloadVM();



  startDownload(String path, String fileUrl) async {
    cancelToken = CancelToken();
    dowloading = true;
    progress = 0;
    notifyListeners();

    try {
      await Dio().download(fileUrl, path, onReceiveProgress: (count, total) {
        progress = (count / total);
        notifyListeners();
      }, cancelToken: cancelToken);

      dowloading = false;
      fileExists = true;
      notifyListeners();
    } catch (e) {
      print(e);

      dowloading = false;
      notifyListeners();
    }
  }

  cancelDownload(CancelToken cancelToken) {
    cancelToken.cancel();
    dowloading = false;
    notifyListeners();
  }
}
