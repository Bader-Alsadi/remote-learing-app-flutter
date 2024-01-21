class Notifction {
  int? id;
  String? title;
  String? body;
  int? userId;

  Notifction({this.id, this.title, this.body, this.userId});

  Notifction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['user_id'] = this.userId;
    return data;
  }
}