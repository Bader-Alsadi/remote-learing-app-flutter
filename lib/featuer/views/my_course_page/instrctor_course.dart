import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_api.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_expancel_tile.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_icon.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_image_title.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/instructor_vm.dart';

class InstroctorSubject extends StatelessWidget {
  InstroctorSubject({super.key});
  static const String ROUTE = "instrictor_subject";
  @override
  Widget build(BuildContext context) {
    final IVM = Provider.of<InstroctorVM>(context);
    if (!IVM.isloaded)
      IVM.feachDate(ReposteryAPI(), 7).then(
        (value) {
          IVM.insturoctor = value;
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
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 8.0),
        //     child: Circalicon(
        //       iconData: Icons.arrow_back_ios_new_rounded,
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: IVM.insturoctor == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: EdgeInsets.symmetric(horizontal: SMALL_SPACER / 2),
                margin: EdgeInsets.symmetric(vertical: SMALL_SPACER),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      IVM.insturoctor!.name!,
                      style: TEXT_BIG,
                    ),
                    SizedBox(
                      height: MIN_SPACER,
                    ),
                    ImageAndTitle(
                      imagePath: "assets/images/courses/course1.jpeg",
                      title: "Bader Alsdy | moblie devloper",
                    ),
                    Column(
                      children: IVM.insturoctor!.subjects!
                          .map((e) => Container(
                                child: ExpansionTileC(
                                  title: e.name!,
                                  date: e.year!,
                                  vidoe: e.scientificMethod!,
                                  hours: "${e.houre!}",
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
