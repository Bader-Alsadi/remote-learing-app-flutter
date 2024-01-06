import 'package:remote_learing_app_frontend/core/repostery/repostery_data.dart';
import 'package:remote_learing_app_frontend/featuer/models/lecturer_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/subjects_model.dart';

abstract class ALVM {
  //abstruct class for AssinmentVM and lecturerVM classs
  feachDate(ReposteryData repo, Subject subject);
  storeLectuer(ReposteryData repo, int id, Lecturer lecturer);
  updateLectuer(
      ReposteryData repo, int subjectID, int lectuerID, Lecturer lecturer);
  deleteLectuer(ReposteryData repo, int subjectID, int lectuerID);
}
