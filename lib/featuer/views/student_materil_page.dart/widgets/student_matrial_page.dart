
import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/featuer/views/student_materil_page.dart/widgets/student_material_page.dart';

class PlayList extends StatelessWidget {
  const PlayList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (_, __) {
          return const SizedBox(
            height: 20,
          );
        },
        padding: const EdgeInsets.only(top: 20, bottom: 40),
        shrinkWrap: true,
        itemCount: lessonList.length,
        itemBuilder: (_, index) {
          return MatrialCard(lesson: lessonList[index]);
        },
      ),
    );
  }
}