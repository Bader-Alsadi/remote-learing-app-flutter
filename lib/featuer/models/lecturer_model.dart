class Lecturer {
  int? id;
  String? title;
  String? description;
  Null? note;
  String? lecturerData;
  int? subjectId;

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
    subjectId = json['subject_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['note'] = this.note;
    data['lecturer_data'] = this.lecturerData;
    data['subject_id'] = this.subjectId;
    return data;
  }
}