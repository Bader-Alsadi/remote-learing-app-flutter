import 'dart:io';

import 'package:path_provider/path_provider.dart';

class DirectoryPathHP {
   static DirectoryPathHP? instance;
   late Directory filePath;

   DirectoryPathHP._instanc();
  static Future<DirectoryPathHP> getInstanse() async {
    if (instance == null){
      instance =  DirectoryPathHP._instanc();
     instance!.getPath();
    } 
    return instance!;
  }


  getPath() async {
    final Directory? tempDir = await getExternalStorageDirectory();
     filePath = Directory("${tempDir!.path}/files");
    if (await filePath.exists()) {
      return filePath.path;
    } else {
      await filePath.create(recursive: true);
      return filePath.path;
    }
  }
}
