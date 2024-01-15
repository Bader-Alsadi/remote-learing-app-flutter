import 'package:remote_learing_app_frontend/featuer/models/assingment_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/department_modle.dart';
import 'package:remote_learing_app_frontend/featuer/models/lecturer_model.dart';

class Subject {
  int? id;
  String? name;
  String? description;
  String? image;
  int? houre;
  int? grade;
  String? year;
  String? scientificMethod;
  Department? department;
  List<Lecturer> Lecturers = [];
  List<Assingment> assingments = [];
  bool isloaded = false;

  Subject(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.houre,
      this.grade,
      this.year,
      this.scientificMethod,
      this.department});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    houre = json['houre'];
    grade = json['grade'];
    year = json['year'];
    scientificMethod = json['scientific_method'];
    department = json['department'] != null
        ? new Department.fromJson(json['department'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['houre'] = this.houre;
    data['grade'] = this.grade;
    data['year'] = this.year;
    data['scientific_method'] = this.scientificMethod;
    if (this.department != null) {
      data['department'] = this.department!.toJson();
    }
    return data;
  }
}
