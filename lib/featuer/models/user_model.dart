import 'package:remote_learing_app_frontend/featuer/models/subjects_model.dart';

class User {
  int? id;
  String? name;
  String? email;
  List<Subject>? subjects;

  User({this.id, this.name, this.email, this.subjects});

  User.fromJson(Map<String, dynamic> json) {
    try {
      // id = json['id'];
      name = json['name'];
      email = json['email'];
      if (json['subjects'] != null) {
        subjects = <Subject>[];
        json['subjects'].forEach((v) {
          subjects!.add(new Subject.fromJson(v));
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    if (this.subjects != null) {
      data['subjects'] = this.subjects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
