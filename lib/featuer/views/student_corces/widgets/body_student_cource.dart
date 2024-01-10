import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/helpers/get_storge_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_api.dart';
import 'package:remote_learing_app_frontend/core/widgets/costom_head_line.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/course_vm.dart';
import 'package:remote_learing_app_frontend/featuer/views/student_corces/widgets/student_course_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  GetStorage instance = GetStorageHelper.instance("user");
  bool? isconected;
  @override
  void initState() {
    final IVM = Provider.of<CoucesVM>(context, listen: false);
    InternetConnectionChecker().hasConnection.then((value) {
      if (!value) {
        isconected = !value;
        if (IVM.subjects.isEmpty)
          IVM.feachDate(ReposteryAPI(), instance.read("id")).then(
            (value) {
              IVM.subjects = value;
            },
          );
      } else {
        isconected = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final IVM = Provider.of<CoucesVM>(context);
    return isconected == null
        ? Center(
            child: SpinKitCubeGrid(
            color: PRIMARY_COLOR,
          ))
        : IVM.subjects.isEmpty
            ? Center(
                child: Text("no data"),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: MIN_SPACER, left: APP_PADDING, right: APP_PADDING),
                    child: HeadLine(
                      head:
                          "Explore Your Courses ",
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: SMALL_SPACER,
                      vertical: MIN_SPACER,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: APP_PADDING,
                      mainAxisSpacing: APP_PADDING,
                    ),
                    itemBuilder: (context, index) {
                      return CourseCard(
                        subject: IVM.subjects[index],
                      );
                    },
                    itemCount: IVM.subjects.length,
                  ),
                ],
              );
  }
}
