import 'package:dio/dio.dart';

class Materiall {
  int? id;
  String? title;
  String? type;
  String? madiaType;
  double? size;
  int? lecturerId;
  String? path;

  Materiall(
      {this.id,
      this.title,
      this.type,
      this.madiaType,
      this.size,
      this.lecturerId,
      this.path});

  Materiall.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    madiaType = json['madia_type'];
    size = json['size'];
    lecturerId = json['lecturer_id'];
    path = json['path'];
  }

  FormData toJson() {
    final FormData data = FormData.fromMap({
      "title": this.title,
      "type": this.type,
      "file": MultipartFile.fromFileSync(this.path!),
      "lecturer_id": this.lecturerId
    });
    return data;
  }
}
