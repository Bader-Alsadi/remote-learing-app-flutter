class Materiall {
  int? id;
  String? title;
  String? type;
  String? madiaType;
  String? size;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['madia_type'] = this.madiaType;
    data['size'] = this.size;
    data['lecturer_id'] = this.lecturerId;
    data['path'] = this.path;
    return data;
  }
}
