import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/helpers/peremition_hp.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_api.dart';
import 'package:remote_learing_app_frontend/core/widgets/costom_icon_bottom.dart';
import 'package:remote_learing_app_frontend/core/widgets/costom_tap_view.dart';
import 'package:remote_learing_app_frontend/core/widgets/costom_video_image.dart';
import 'package:remote_learing_app_frontend/featuer/models/lecturer_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/material_model.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/material_vm.dart';
import 'package:remote_learing_app_frontend/featuer/views/student_materil_page.dart/widgets/description_page.dart';
import 'package:remote_learing_app_frontend/featuer/views/student_materil_page.dart/widgets/student_matrial_page.dart';

class StudentMatrialPadge extends StatefulWidget {
  final String title;
  Lecturer lecturer;

  StudentMatrialPadge({Key? key, required this.title, required this.lecturer})
      : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<StudentMatrialPadge> {
  int _selectedTag = 0;
  bool isPermission = false;
  var checkAllPermissions = PermissionHL();
  bool? isConnect;
  bool isloaded = false;
  List<Materiall> materials = [];

  checkPermission() async {
    var permission = await checkAllPermissions.isStoragePermission();
    if (permission) {
      setState(() {
        isPermission = true;
      });
    }
  }

  @override
  void initState() {
    checkPermission();
    InternetConnectionChecker().hasConnection.then((value) {
      if (!value) {
        isConnect = !value;
        Provider.of<MaterialVM>(context, listen: false)
            .feachDate(ReposteryAPI(), widget.lecturer)
            .then((value) {
          materials = value;
          isloaded = true;
          setState(() {});
        });
      } else {
        isConnect = !value;
      }
      setState(() {});
    });
    super.initState();
  }

  void changeTab(int index) {
    setState(() {
      _selectedTag = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: WHITH_COLOR,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntrinsicHeight(
                  child: Stack(
                    children: [
                      Align(
                        child: Text(
                          "Course",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      Positioned(
                        left: 0,
                        child: CustomIconButton(
                          child: const Icon(Icons.arrow_back),
                          height: 35,
                          width: 35,
                          onTap: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomVideoPlayer(),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Futter Novice to Ninja",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                const Text(
                  "Created by DevWheels",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.timer,
                      color: Colors.grey,
                    ),
                    const Text(
                      " 72 Hours",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTabView(
                  tags: ["vidoe", "description"],
                  index: _selectedTag,
                  changeTab: changeTab,
                ),
                _selectedTag == 0 ? const PlayList() : const Description(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
