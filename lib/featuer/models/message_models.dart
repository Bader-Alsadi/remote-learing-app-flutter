import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  int? senderId;
  String? senderName;
  String? message;
  DateTime? sendDate;

  Message({this.senderId, this.senderName, this.message, this.sendDate});


  Message.fromJson (Map josn){
    senderId = josn["sender_id"];
    senderName = josn["sender_name"];
    message = josn["message"];
    Timestamp timesSamp=josn['send_date'];
    sendDate = timesSamp.toDate() ;
  }

  Map<String,dynamic> toJson ( ){
    Map<String,dynamic> data = {};
    data["sender_id"]= senderId;
    data["sender_name"]= senderName;
    data["message"]= message;
    data["send_date"]=  sendDate;

    return data;

  }

}