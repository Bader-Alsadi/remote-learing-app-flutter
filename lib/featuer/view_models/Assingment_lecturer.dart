import 'package:remote_learing_app_frontend/core/repostery/repostery_data.dart';
import 'package:remote_learing_app_frontend/featuer/models/lescutrer_sub.dart';
import 'package:remote_learing_app_frontend/featuer/models/subjects_model.dart';

abstract class ALVM {
  //abstruct class for AssinmentVM and lecturerVM classs
  feachDate(ReposteryData repo, Subject subject);
  storeLectuer(ReposteryData repo, int id, LeacturerSub LeacturerSub);
  updateLectuer(
      ReposteryData repo, int subjectID, int lectuerID, LeacturerSub LeacturerSub);
  deleteLectuer(ReposteryData repo, int subjectID, int lectuerID);
}
