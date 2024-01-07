import 'package:dio/dio.dart';
import 'package:remote_learing_app_frontend/featuer/models/lescutrer_sub.dart';
import 'package:remote_learing_app_frontend/featuer/models/material_model.dart';

class Lecturer extends LeacturerSub{
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

  FormData toJson() {
    final FormData data = new FormData.fromMap({
      "title": this.title,
      "description": this.description,
      "note": this.note,
      "lecturer_data": this.lecturerData,
      "enrollment_id": this.subjectId,
    });
    return data;
  }
}
