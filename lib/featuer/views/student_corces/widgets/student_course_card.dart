import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/helpers/ui_helper.dart';
import 'package:remote_learing_app_frontend/featuer/models/subjects_model.dart';
import 'package:remote_learing_app_frontend/featuer/views/my_course_page/instrctor_lecturer.dart';
import 'package:remote_learing_app_frontend/featuer/views/root_page.dart/root_page2.dart';

class CourseCard extends StatelessWidget {
  final Subject subject;
  const CourseCard({
    Key? key,
    required this.subject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, InstroctorSubject.ROUTE,
          arguments: subject),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: WHITH_COLOR,
          borderRadius: BorderRadius.circular(RADIUS),
          boxShadow: [
            boxShadow2, //BoxShadow
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Image.network(
                subject.image!,
                height: CourseImagesize,
              ),
            ),
            const SizedBox(
              height: MIN_SPACER,
            ),
            Text(subject.name!),
            Text(
              " lecturers",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
