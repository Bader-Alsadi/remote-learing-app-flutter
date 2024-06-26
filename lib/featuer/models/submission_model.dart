import 'package:dio/dio.dart';

class Submission {
  int? id;
  int? studentId;
  int? assingmentId;
  String? submissionsDate;
  String? path;
  int? grade;
  bool? state;
  String? studentName;
  double progress = 0;
  bool dowloading = false;
  bool? fileExists;

  Submission(
      {this.id,
      this.studentId,
      this.assingmentId,
      this.submissionsDate,
      this.path,
      this.grade,
      this.state,
      this.studentName});

  Submission.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    assingmentId = json['assingment_id'];
    submissionsDate = json['submissions_date'];
    path = json['path'];
    grade = json['grade'];
    state = json['state'] == 1;
    studentName = json['student_name'];
  }

FormData toJsonG() {
    final data = FormData.fromMap({
      "id": this.id,
      'student_id': this.studentId,
      'assingment_id': this.assingmentId,
      'submissions_date': this.submissionsDate,
      'grade': this.grade,
    });
    return data;
  }  

  FormData toJson() {
    final data = FormData.fromMap({
      "id": this.id,
      'student_id': this.studentId,
      'assingment_id': this.assingmentId,
      'submissions_date': this.submissionsDate,
      'file': MultipartFile.fromFileSync(this.path!),
      'grade': this.grade,
      'state': this.state,
      'student_name': this.studentName
    });
    return data;
  }
}
