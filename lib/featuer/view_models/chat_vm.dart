import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/chat_model.dart';
import '../models/message_models.dart';

class ChatVM with ChangeNotifier {
List<Chat> chats = [];
List<Message> messages = [];
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;


loadChat ( List<int?> ids)async{
  final result = await firebaseFirestore.collection("chats").where("enrollment",whereIn: ids).get();
  chats=result.docs.map((e) => Chat.fromJSON(e.data(),docId:e.id)).toList();
  notifyListeners();
}


loadMessages(Chat subjectChat)async{

  final result = await firebaseFirestore.collection("chats")
  .doc(subjectChat.docId!)
  .collection("messages")
  .orderBy("send_date",descending: false)
  .snapshots().listen((messages) {
    this.messages= messages.docs.map((e) =>Message.fromJson(e.data())).toList();
    // messages.docs.forEach((element) {
    //
    //   this.messages.add(Message.fromJson(element.data()));
    //   print(element.data());
    //   notifyListeners();
    // });

  });
}
sendMessage(Message message,String docId){
  print("document id $docId");
  print("message is ${message.toJson()}");
  firebaseFirestore.collection("chats").doc(docId).collection("messages").add(message.toJson());
}

}