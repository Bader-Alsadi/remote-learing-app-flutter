import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/image_paths.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/core/helpers/get_storge_helper.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/chat_vm.dart';

import '../../models/chat_model.dart';
import '../../models/message_models.dart';

class ChatTelegramRoute extends StatefulWidget {
  ChatTelegramRoute({
    required this.subjectChat
});
 late Chat subjectChat ;

  @override
  ChatTelegramRouteState createState() => new ChatTelegramRouteState();
}

class ChatTelegramRouteState extends State<ChatTelegramRoute> {
  bool showSend = false;
  final TextEditingController inputController = new TextEditingController();
  List<Message> items = [];
  late ChatTelegramAdapter adapter;
  ChatVM? chatVm;
  ScrollController scrollController = new ScrollController();

  @override
  void initState() {
   Provider.of<ChatVM>(context,listen: false).loadMessages(widget.subjectChat);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD0DBE2),
      appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.light,
              statusBarColor: PRIMARY_COLOR),
          title: Row(
            children: <Widget>[
              CircleImage(
                imageProvider: AssetImage(PLACE_HOLDER),
                size: 40,
              ),
              Container(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.subjectChat.subjectName!,
                      style:
                          MyText.body1(context)!.copyWith(color: Colors.white)),
                  Container(height: 2),
                ],
              )
            ],
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,color: WHITH_COLOR,),
            onPressed: () {
              Navigator.pop(context);
              chatVm!.messages.clear();
            },
          ),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (String value) {},
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: "Settings",
                  child: Text("Settings"),
                ),
              ],
            )
          ]),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child:getView(),

            ),
            Container(
              color: Colors.white,
              alignment: Alignment.centerLeft,
              child: Row(
                children: <Widget>[
                  IconButton(
                      icon: const Icon(Icons.sentiment_satisfied,
                          color: GRAY_COLOR),
                      onPressed: () {}),
                  Expanded(
                    child: TextField(
                      controller: inputController,
                      maxLines: 1,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                      decoration:
                          new InputDecoration.collapsed(hintText: 'Message'),
                      onChanged: (term) {
                        showSend = true;
                        setState(() {

                        });
                      },
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.attach_file, color: GRAY_COLOR),
                      onPressed: () {}),
                  Consumer<ChatVM>(
                    builder: (context,cvm,w) {
                      return IconButton(
                          icon: Icon(showSend ? Icons.send : Icons.mic,
                              color: Colors.blue),
                          onPressed: () {

                            String message = inputController.text;
                            inputController.clear();
                            showSend = false;
                            GetStorage instance = GetStorageHelper.instance("user");
                            Message messageObjsct = Message(
                              senderId: instance.read("id"),
                              senderName: instance.read("name"),
                              message: message,
                              sendDate: DateTime.now() ,
                            );
                            print("befor send");
                            cvm.sendMessage(messageObjsct,widget.subjectChat.docId!);


                            //sendMessage();

                          });
                    }
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onItemClick(int index, String obj) {}

  void sendMessage() {
    String message = inputController.text;
    inputController.clear();
    showSend = false;
    GetStorage instance = GetStorageHelper.instance("user");
    Message messageObjsct = Message(
      senderId: instance.read("id"),
      senderName: instance.read("name"),
      message: message,
      sendDate: DateTime.timestamp()
        // DateTime.now() ,
    );
    print("befor send");
    chatVm!.sendMessage(messageObjsct,widget.subjectChat.docId!);
    // setState(() {
    //
    //   // insertSingleItem(Message.time(
    //   //     3,//getItemCount(),
    //   //     "hello",
    //   //     true,
    //   //     chatVm!.messages.length % 5 == 0,
    //   //     Tools.getFormattedTimeEvent(DateTime.now().millisecondsSinceEpoch)));
    // });

  }



  Widget getView() {
    return Consumer<ChatVM>(builder: (ctx,cvm,w)=>ListView.builder(
      itemCount:  cvm.messages.length,
      padding: EdgeInsets.symmetric(vertical: 10),
      controller: scrollController,
      itemBuilder: (context, index) {
        Message item = cvm.messages[index];
        print("the item is ${item.senderName}");
        return buildListItemView(index, item);
      },
    ));
  }

  Widget buildListItemView(int index, Message item) {
    bool isMe =GetStorageHelper.instance("user").read("id") == item.senderId!;
    return Wrap(
      alignment: isMe ? WrapAlignment.end : WrapAlignment.start,
      children: <Widget>[
        Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            margin: EdgeInsets.fromLTRB(isMe ? 20 : 10, 5, isMe ? 10 : 20, 5),
            color: isMe ? Color(0xffEFFFDE) : Colors.white,
            elevation: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(minWidth: 150),
                    child: Column(
                      crossAxisAlignment: isMe? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Text(

                         GetStorageHelper.instance("user").read("role") == "Student"?  "${item.senderName!}" : " ${item.senderName!}"


                        ,
                          style: TEXT_NORMAL,
                          textAlign: TextAlign.start,
                        ),
                        Text(item.message!,
                            style: MyText.body1(context)!
                                .copyWith(color: Colors.black)),
                      ],
                    ),
                  ),
                  Container(height: 3, width: 0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("${item.sendDate!.second}!",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 12,
                              color: isMe ? Color(0xff58B346) : GRAY_COLOR)),
                      Container(width: 3),
                      isMe
                          ? Icon(Icons.done_all,
                          size: 12, color: Color(0xff58B346))
                          : Container(width: 0, height: 0)
                    ],
                  )
                ],
              ),
            ))
      ],
    );
  }

  void insertSingleItem(Message msg) {
    int insertIndex = items.length;
    items.insert(insertIndex, msg);
    scrollController.animateTo(scrollController.position.maxScrollExtent + 100,
        duration: Duration(milliseconds: 100), curve: Curves.easeOut);
  }
}

class ChatTelegramAdapter {
  List items = <Message>[];
  BuildContext context;
  Function onItemClick;

  ChatTelegramAdapter(this.context, this.items, this.onItemClick);

  int getItemCount() => items.length;
}

class CircleImage extends StatelessWidget {
  final double? size;
  final Color? backgroundColor;
  final ImageProvider imageProvider;

  const CircleImage({
    Key? key,
    required this.imageProvider,
    this.size,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    return Container(
        width: size != null ? size : 20,
        height: size != null ? size : 20,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            color:
                backgroundColor != null ? backgroundColor : Colors.transparent,
            image:
                new DecorationImage(fit: BoxFit.fill, image: imageProvider)));
  }
}

class MyText {
  static TextStyle? body1(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium;
  }
}


