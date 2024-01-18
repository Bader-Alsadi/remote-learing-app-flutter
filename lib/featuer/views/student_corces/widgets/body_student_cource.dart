import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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
import 'package:remote_learing_app_frontend/core/widgets/loading_page.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/course_vm.dart';
import 'package:remote_learing_app_frontend/featuer/views/student_corces/widgets/student_course_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  GetStorage instance = GetStorageHelper.instance("user");
  late bool isloaded;
  void relodePage() {
    final IVM = Provider.of<CoucesVM>(context, listen: false);
    isloaded = IVM.subjects.isNotEmpty;
    InternetConnectionChecker().hasConnection.then((internetState) {
      if (internetState) {
        if (IVM.subjects.isEmpty)
          IVM.feachDate(ReposteryAPI(), instance.read("id")).then(
            (value) {
              IVM.subjects = value;
              isloaded = internetState;
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
    return  !isloaded
        ? LoadingPage()
        : IVM.subjects.isEmpty
            ? reloadMathod(context)
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      CarouselSlider.builder(
                          itemCount: 3,
                          itemBuilder: (context, index, _) => Container(
                                width: double.infinity,
                                margin: EdgeInsets.all(MIN_SPACER),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(RADIUS),
                                    color: PRIMARY_COLOR.withOpacity(0.4)),
                                child: Center(child: Text("$index")),
                              ),
                          options: CarouselOptions(
                              height: MediaQuery.sizeOf(context).height * .2)),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: MIN_SPACER,
                            left: APP_PADDING,
                            right: APP_PADDING),
                        child: HeadLine(
                          head: "Explore Your Courses ",
                        ),
                      ),
                      if (IVM.subjects.isNotEmpty) ...[
                        Wrap(
                            spacing: SMALL_SPACER * .5,
                            runSpacing: MIN_SPACER,
                            children: IVM.subjects
                                .map((e) => SizedBox(
                                      width:
                                          MediaQuery.sizeOf(context).width * .4,
                                      child: CourseCard(
                                        subject: e,
                                        //       subject: IVM.subjects[index],
                                        //     );),
                                      ),
                                    ))
                                .toList())
                      ] else ...[
                        SizedBox(
                          height: SMALL_SPACER,
                        ),
                        Text("no date")
                      ]
                    ],
                  ),
                ),
              );
  }

  Center reloadMathod(BuildContext context) {
    return Center(
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
          TextButton(
              onPressed: () {
                isloaded = false;
                setState(() {});
                relodePage();
              },
              child: Text("relodae")),
        ],
      ),
    );
  }
}
