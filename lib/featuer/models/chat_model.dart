class Chat {
  String? docId ;
  String? subjectName ;
  String? lastMessage;

  Chat.fromJSON(Map<String,dynamic> row,{String? docId}){
    subjectName=row['subject_name'];
    lastMessage=row['last_message'];
    this.docId=docId;
  }

}