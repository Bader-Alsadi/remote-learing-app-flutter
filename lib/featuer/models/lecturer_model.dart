
import 'package:remote_learing_app_frontend/featuer/models/material_model.dart';

class Lecturer {
  int? id;
  String? title;
  String? description;
  String? note;
  String? lecturerData;
  int? subjectId;
List<Materiall>? materials;
  Lecturer(
      {this.id,
      this.title,
      this.description,
      this.note,
      this.lecturerData,
      this.subjectId});

  Lecturer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    note = json['note'];
    lecturerData = json['lecturer_data'];
    subjectId = json['enrollment_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['note'] = this.note;
    data['lecturer_data'] = this.lecturerData;
    data['enrollment_id'] = this.subjectId;
    return data;
  }
}
