class Report {
  int? finalMark;
  int? studentId;
  String? name;
  String? email;

  Report({this.finalMark, this.studentId, this.name, this.email});

  Report.fromJson(Map<String, dynamic> json) {
    finalMark = json['final_mark'];
    studentId = json['student_id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['final_mark'] = this.finalMark;
    data['student_id'] = this.studentId;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}
