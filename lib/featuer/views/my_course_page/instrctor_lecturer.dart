import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_api.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_expancel_tile.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_icon.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_image_title.dart';
import 'package:remote_learing_app_frontend/featuer/models/lecturer_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/subjects_model.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/lectuer_vm.dart';

class InstroctorSubject extends StatelessWidget {
  InstroctorSubject({super.key, required this.subject});
  static const String ROUTE = "instrictor_subject";
  Subject subject;
  @override
  Widget build(BuildContext context) {
    print("${subject.id}");
    final LVM = Provider.of<LecturerVM>(context);
    if (!subject.isloaded)
      LVM.feachDate(ReposteryAPI(), subject.id!).then(
        (value) {
          LVM.lectrers = value;
        },
      );
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Circalicon(
            iconData: Icons.arrow_back_ios_new_rounded,
          ),
        ),
      ),
      body: LVM.lectrers.isEmpty
          ? Center(
              child: SpinKitFadingCircle(
                color: PRIMARY_COLOR,
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: SMALL_SPACER / 2),
                margin: EdgeInsets.symmetric(vertical: SMALL_SPACER),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   LVM.insturoctor!.name!,
                    //   style: TEXT_BIG,
                    // ),
                    SizedBox(
                      height: MIN_SPACER,
                    ),
                    ImageAndTitle(
                      imagePath: "assets/images/courses/course1.jpeg",
                      title: "Bader Alsdy | moblie devloper",
                    ),
                    Column(
                      children: LVM.lectrers
                          .map((e) => Container(
                                child: ExpansionTileC(
                                  title: e.title!,
                                  date: e.lecturerData!.split(" ").first,
                                  vidoe: "",
                                  hours: "s",
                                  note: e.description!,
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
