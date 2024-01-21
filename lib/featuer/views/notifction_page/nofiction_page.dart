import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/featuer/models/notifction_model.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/notifction_vm.dart';

import '../../../core/constints/colors.dart';
class NotifctionPage extends StatelessWidget {
  const NotifctionPage({super.key});
  static const  String ROUTE= "notifction_page";

  @override
  Widget build(BuildContext context) {
   List<Notifction> notifactions=  Provider.of<NotifctionVM>(context).notifction;
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        foregroundColor: WHITH_COLOR,
        title: Text("notifctions"),
      ),
      body:ListView.builder(itemBuilder: (context,index)=>Card(
        child: ListTile(
          title: Text("Title: ${notifactions[index].title!}",style: TEXT_NORMAL,),
          subtitle: Text("body: ${notifactions[index].body!}",style: TEXT_NORMAL,),
        ),
      ),
      itemCount: notifactions.length,
      )

      );
  }
}
