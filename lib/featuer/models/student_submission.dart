import 'dart:math';
import 'dart:ui';

import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/featuer/models/assingment_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/submission_model.dart';

class StudentSubmissoin {
  Assingment? assingment;
  Submission? submission;
  Color? color;
  StudentSubmissoin(this.submission,this.assingment){
    color= colorList[Random().nextInt(colorList.length)];
    print(color!.value);
  }

  StudentSubmissoin.fromJson(Map<String,dynamic> josn){
    assingment = Assingment.fromJson(
        {
          "id":josn["id"],
          "title": josn["title"] ,
          "description": josn["description"],
          "grade": josn["grade"],
          "deadline": josn["deadline"],
          "enrollment_id": josn["enrollmentId"]
        }
    );
    submission = Submission.fromJson({
      "id": josn["submission_id"],
      'student_id': josn["student_id"],
      'assingment_id': josn["id"],
      'submissions_date':josn["submissions_date"],
      'grade': josn["submission_grade"],
      'path': josn["path"],
      'state': josn["state"],
    });
    // color= colorList[Random().nextInt(colorList.length)];

  }
}

List<Color> colorList=[
  // PRIMARY_COLOR,
  // FOURTH_COLOR,
  PRIMARY_COLOR.withOpacity(.8),
  SECONDRY_COLOR.withOpacity(.8),
  THIRD_COLOR.withOpacity(.8),
  FOURTH_COLOR.withOpacity(.8),
  PRIMARY_COLOR.withOpacity(.6),
  SECONDRY_COLOR.withOpacity(.6),
  THIRD_COLOR.withOpacity(.6),
  FOURTH_COLOR.withOpacity(.6),
];