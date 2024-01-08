import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/core/helpers/file_hp.dart';
import 'package:remote_learing_app_frontend/core/helpers/peremition_hp.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_api.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_icon.dart';
import 'package:remote_learing_app_frontend/featuer/models/lecturer_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/material_model.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/material_vm.dart';
import 'package:remote_learing_app_frontend/featuer/views/material_page/widgets/place_holder_matrieal.dart';

class Material2 extends StatefulWidget {
  Material2({super.key, required this.lecturer});
  static const String ROUTE = "material_page";
  Lecturer lecturer;

  @override
  State<Material2> createState() => _Material2State();
}

class _Material2State extends State<Material2> {
  bool isPermission = false;
  var checkAllPermissions = PermissionHL();
  bool? isConnect;
  bool isloaded = false;
  List<Materiall> materials = [];

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
    InternetConnectionChecker().hasConnection.then((value) {
      if (!value) {
        isConnect = !value;
        Provider.of<MaterialVM>(context, listen: false)
            .feachDate(ReposteryAPI(), widget.lecturer)
            .then((value) {
          materials = value;
          isloaded = true;
          setState(() {});
        });
      } else {
        isConnect = !value;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final SCVM = Provider.of<MaterialVM>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Circalicon(
            iconData: Icons.arrow_back_ios_new_rounded,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(widget.lecturer.title!),
      ),
      body: isConnect != null
          ? isConnect!
              ? Column(
                  children: SCVM.materials
                      .map((e) => CardListtile(
                            material: e,
                          ))
                      .toList(),
                )
              : Center(
                  child: Text("no internet"),
                )
          : PlaceHolderMaterial(),
    );
  }
}

class CardListtile extends StatefulWidget {
  CardListtile({super.key, required this.material});
  Materiall material;

  @override
  State<CardListtile> createState() => _CardListtileState();
}

class _CardListtileState extends State<CardListtile> {
  FileHP? instanceFile;
  @override
  void initState() {
    FileHP.getInstanse().then((value) {
      instanceFile = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    instanceFile!.checkFileExit(widget.material.path!).then((valu) {
      print("exict $valu");
      widget.material.fileExists = valu;
      setState(() {});
    });
    final SCVM = Provider.of<MaterialVM>(context);
    return Card(
      child: ListTile(
          title: Text(
            "Title : ${widget.material.title!}",
            style: TEXT_NORMAL,
          ),
          subtitle: Text(
            "Size : ${widget.material.size!.toStringAsFixed(2)} MP | Madia Type : ${widget.material.madiaType} ${widget.material.progress}",
            style: TEXT_NORMAL,
          ),
          trailing: IconButton(
            onPressed: () {
              widget.material.fileExists == null
                  ? null
                  : widget.material.fileExists!
                      ? instanceFile!.openfile(widget.material.path!)
                      : instanceFile!
                          .startDownload1(CancelToken(), SCVM, widget.material);
            },
            icon: widget.material.fileExists == null
                ? CircularProgressIndicator()
                : widget.material.fileExists!
                    ? Icon(Icons.settings_display_rounded)
                    : widget.material.dowloading
                        ? Icon(Icons.circle)
                        : Icon(Icons.download),
          )),
    );
  }
}
