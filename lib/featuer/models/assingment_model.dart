class Assingment {
  int? id;
  String? title;
  String? description;
  int? grade;
  int? enrollmentId;
  String? deadline;

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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['grade'] = this.grade;
    data['enrollment_id'] = this.enrollmentId;
    data['deadline'] = this.deadline;
    return data;
  }
}