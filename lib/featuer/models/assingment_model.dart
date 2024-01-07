import 'package:dio/dio.dart';
import 'package:remote_learing_app_frontend/featuer/models/lescutrer_sub.dart';
import 'package:remote_learing_app_frontend/featuer/models/submission_model.dart';

class Assingment extends LeacturerSub {
  int? id;
  String? title;
  String? description;
  int? grade;
  int? enrollmentId;
  String? deadline;
  List<Submission>? submissions;

  Assingment(
      {this.id,
      this.title,
      this.description,
      this.grade,
      this.enrollmentId,
      this.deadline});

  Assingment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    grade = json['grade'];
    enrollmentId = json['enrollment_id'];
    deadline = json['deadline'];
  }

  FormData toJson() {
    print(this.deadline);
    final FormData data = new FormData.fromMap({
      "title": this.title,
      "description": this.description,
      "grade": this.grade,
      "deadline": this.deadline,
      "enrollment_id": this.enrollmentId,
    });
    return data;
  }
}
