import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/core/helpers/get_storge_helper.dart';
import 'package:remote_learing_app_frontend/core/helpers/ui_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_api.dart';
import 'package:remote_learing_app_frontend/core/widgets/costom_head_line.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_elevated_buttom.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/course_vm.dart';
import 'package:remote_learing_app_frontend/featuer/views/student_corces/widgets/student_course_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  GetStorage instance = GetStorageHelper.instance("user");
  bool isloaded = false;
  void relodePage() {
    final IVM = Provider.of<CoucesVM>(context, listen: false);
    InternetConnectionChecker().hasConnection.then((internetState) {
      if (!internetState) {
        if (IVM.subjects.isEmpty)
          IVM.feachDate(ReposteryAPI(), instance.read("id")).then(
            (value) {
              IVM.subjects = value;
              isloaded = !internetState;
            },
          );
      } else {
        showSnackBar(context, "no internet", false);
      }
    });
  }

  @override
  void initState() {
    relodePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final IVM = Provider.of<CoucesVM>(context);
    return !isloaded
        ? Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitFadingCube(
                  color: PRIMARY_COLOR,
                ),
                SizedBox(
                  height: SMALL_SPACER,
                ),
                Text(
                  "Loading...",
                  style: TEXT_NORMAL,
                )
              ],
            ),
          )
        : IVM.subjects.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/images/no_data.svg",
                      height: MediaQuery.sizeOf(context).height * .3,
                    ),
                    Text(
                      "NO data",
                      style: TEXT_NORMAL,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * .6,
                      child: CustomElevatedBottom(
                        lable: "Reload Page",
                        onPressedFun: () {
                          isloaded = false;
                          setState(() {});
                          relodePage();
                        },
                      ),
                    )
                  ],
                ),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: MIN_SPACER, left: APP_PADDING, right: APP_PADDING),
                    child: HeadLine(
                      head: "Explore Your Courses ",
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
