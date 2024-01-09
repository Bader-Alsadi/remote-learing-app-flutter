import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/core/helpers/file_hp.dart';
import 'package:remote_learing_app_frontend/core/helpers/ui_helper.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_elevated_buttom.dart';
import 'package:remote_learing_app_frontend/featuer/models/material_model.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/material_vm.dart';

class CardListtile extends StatelessWidget {
  CardListtile({super.key, required this.material});
  Materiall material;
  late int index;
  FileHP instanceFile = FileHP.getInstanse();
  CancelToken cancelToken = CancelToken();
  @override
  Widget build(BuildContext context) {
    final SCVM = Provider.of<MaterialVM>(context);
    index = SCVM.materials.indexOf(material);
    if (material.fileExists == null)
      instanceFile.checkFileExit(material.path!).then((valu) {
        SCVM.fileExtis(SCVM.materials.indexOf(material), valu);
      });
    return Column(
      children: [
        Card(
          child: ListTile(
              onTap: () {
                if (!material.fileExists!) {
                  openMethod(context, SCVM);
                } else {
                  instanceFile.openfile(material.path!);
                }
              },
              title: Text(
                "Title : ${material.title!}",
                style: TEXT_NORMAL,
              ),
              subtitle: Text(
                "Type : ${material.type} | Size : ${material.size!.toStringAsFixed(2)} MP",
                style: TEXT_NORMAL,
              ),
              leading: material.dowloading
                  ? InkWell(
                      onTap: () {
                        instanceFile.cancelDownload(cancelToken);
                        SCVM.downloading(index, false);
                      },
                      child: Icon(Icons.cancel))
                  : Image.asset(
                      getFormatImage(material.madiaType!),
                      height: 70,
                      width: 60,
                      fit: BoxFit.fill,
                    ),
              trailing: IconButton(
                onPressed: () {
                  material.fileExists == null
                      ? null
                      : material.fileExists!
                          ? instanceFile
                              .deletafiel(material.path!)
                              .then((value) {
                              SCVM.deleteFromDivese(index, value);
                            })
                          : instanceFile.startDownload1(
                              CancelToken(), SCVM, material);
                },
                icon: material.fileExists == null
                    ? SpinKitWaveSpinner(
                        color: THIRD_COLOR,
                        size: 30,
                      )
                    : material.fileExists!
                        ? Icon(
                            Icons.delete,
                            color: Colors.red,
                          )
                        : material.dowloading
                            ? Text(
                                "${(material.progress * 100).toStringAsFixed(2)} %")
                            : Icon(Icons.download),
              )),
        ),
      ],
    );
  }

  Future<dynamic> openMethod(BuildContext context, MaterialVM SCVM) {
    return showDialog(
        context: context,
        builder: (context) => SizedBox(
              child: AlertDialog(
                title: Text("download"),
                content: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: CustomElevatedBottom(
                        lable: "download",
                        mairgn: 15,
                        backColor: PRIMARY_COLOR,
                        onPressedFun: () {
                          instanceFile.startDownload1(
                              cancelToken, SCVM, material);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Flexible(
                      child: CustomElevatedBottom(
                        lable: "cancle",
                        mairgn: 15,
                        backColor: WHITH_COLOR,
                        titleColor: BLACK_COLOR,
                        onPressedFun: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}

// class CardListtilee extends StatefulWidget {
//   CardListtilee({super.key, required this.material});
//   Materiall material;

//   @override
//   State<CardListtilee> createState() => _CardListtileState();
// }

// class _CardListtileState extends State<CardListtilee> {
//   // FileHP? instanceFile;
//   FileHP instanceFile = FileHP.getInstanse();

//   @override
//   Widget build(BuildContext context) {
//     if (widget.material.fileExists == null)
//       instanceFile.checkFileExit(widget.material.path!).then((valu) {
//         print("exict $valu");
//         widget.material.fileExists = valu;
//         setState(() {});
//       });
//     final SCVM = Provider.of<MaterialVM>(context);
//     return Card(
//       child: ListTile(
//           title: Text(
//             "Title : ${widget.material.title!}",
//             style: TEXT_NORMAL,
//           ),
//           subtitle: Text(
//             "Size : ${widget.material.size!.toStringAsFixed(2)} MP | Madia Type : ${widget.material.madiaType} ${widget.material.progress}",
//             style: TEXT_NORMAL,
//           ),
//           trailing: IconButton(
//             onPressed: () {
//               widget.material.fileExists == null
//                   ? null
//                   : widget.material.fileExists!
//                       ? instanceFile.openfile(widget.material.path!)
//                       : instanceFile.startDownload1(
//                           CancelToken(), SCVM, widget.material);
//             },
//             icon: widget.material.fileExists == null
//                 ? CircularProgressIndicator()
//                 : widget.material.fileExists!
//                     ? Icon(Icons.settings_display_rounded)
//                     : widget.material.dowloading
//                         ? Icon(Icons.circle)
//                         : Icon(Icons.download),
//           )),
//     );
//   }
// }
