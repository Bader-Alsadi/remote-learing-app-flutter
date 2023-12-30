import 'package:remote_learing_app_frontend/featuer/models/semaster_model.dart';

class Department {
  int? id;
  String? name;
  String? level;
  Semaster? semaster;

  Department({this.id, this.name, this.level, this.semaster});

  Department.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    level = json['level'];
    semaster = json['semaster'] != null
        ? new Semaster.fromJson(json['semaster'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['level'] = this.level;
    if (this.semaster != null) {
      data['semaster'] = this.semaster!.toJson();
    }
    return data;
  }
}