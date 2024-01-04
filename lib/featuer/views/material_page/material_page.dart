import 'dart:io';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as Path;
import 'package:provider/provider.dart';
import 'package:remote_learing_app_frontend/core/helpers/directoryP_path_hb.dart';
import 'package:remote_learing_app_frontend/core/helpers/peremition_hp.dart';
import 'package:remote_learing_app_frontend/featuer/models/lecturer_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/material_model.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/download_vm.dart';

class MaterialP extends StatefulWidget {
  MaterialP({super.key, required this.lecturer});
  static const String ROUTE = "material_page";
  Lecturer lecturer;

  @override
  State<MaterialP> createState() => _FileListState();
}

class _FileListState extends State<MaterialP> {
  bool isPermission = false;
  var checkAllPermissions = PermissionHL();

  checkPermission() async {
    var permission = await checkAllPermissions.isStoragePermission();
    if (permission) {
      setState(() {
        isPermission = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    List<Materiall> materials = widget.lecturer.materials!;
    return Scaffold(
        body: isPermission
            ? ListView.builder(
                itemCount: materials.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = materials[index];
                  return TileList(
                    fileUrl: data.path!,
                    title: data.title!,
                  );
                })
            : TextButton(
                onPressed: () {
                  checkPermission();
                },
                child: const Text("Permission issue")));
  }
}

class TileList extends StatefulWidget {
  TileList({super.key, required this.fileUrl, required this.title});
  final String fileUrl;
  final String title;

  @override
  State<TileList> createState() => _TileListState();
}

class _TileListState extends State<TileList> {
  bool dowloading = false;
  bool fileExists = false;
  // double progress = 0;
  String fileName = "";
  late String filePath;
  late CancelToken cancelToken;
  var getPathFile = DirectoryPathHP();

  startDownload() async {
    cancelToken = CancelToken();
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';
    setState(() {
      dowloading = true;
      // DVMprogress = 0;
    });

    try {
      await Dio().get(widget.fileUrl, onReceiveProgress: (count, total) {
        setState(() {
          // progress = (count / total);
        });
      }, cancelToken: cancelToken);
      setState(() {
        dowloading = false;
        fileExists = true;
      });
    } catch (e) {
      print(e);
      setState(() {
        dowloading = false;
      });
    }
  }

  cancelDownload() {
    cancelToken.cancel();
    setState(() {
      dowloading = false;
    });
  }

  checkFileExit() async {
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';
    bool fileExistCheck = await File(filePath).exists();
    setState(() {
      fileExists = fileExistCheck;
    });
  }

  openfile() {
    OpenFile.open(filePath);
    print("fff $filePath");
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      fileName = Path.basename(widget.fileUrl);
    });
    checkFileExit();
  }

  @override
  Widget build(BuildContext context) {
    final DVM = Provider.of<DownloadVM>(context);

    return Card(
      elevation: 10,
      shadowColor: Colors.grey.shade100,
      child: Column(
        children: [
          Image.network(
            widget.fileUrl,
          ),
          ListTile(
              title: Text(widget.fileUrl),
              leading: IconButton(
                  onPressed: () {
                    fileExists && dowloading == false
                        ? openfile()
                        : cancelDownload();
                  },
                  icon: fileExists && dowloading == false
                      ? const Icon(
                          Icons.window,
                          color: Colors.green,
                        )
                      : const Icon(Icons.close)),
              trailing: IconButton(
                  onPressed: () {
                    fileExists && dowloading == false
                        ? openfile()
                        : startDownload();
                  },
                  icon: fileExists
                      ? const Icon(
                          Icons.save,
                          color: Colors.green,
                        )
                      : dowloading
                          ? Stack(
                              alignment: Alignment.center,
                              children: [
                                CircularProgressIndicator(
                                  value: DVM.progress,
                                  strokeWidth: 3,
                                  backgroundColor: Colors.grey,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.blue),
                                ),
                                Text(
                                  "${(DVM.progress * 100).toStringAsFixed(2)}",
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            )
                          : const Icon(Icons.download))),
        ],
      ),
    );
  }
}
