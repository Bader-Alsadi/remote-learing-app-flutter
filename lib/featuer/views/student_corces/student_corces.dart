import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remote_learing_app_frontend/featuer/views/student_corces/widgets/body_student_cource.dart';
import 'package:remote_learing_app_frontend/featuer/views/student_corces/widgets/student_course_appbar.dart';

class StudentCorcesPage extends StatefulWidget {
  const StudentCorcesPage({Key? key}) : super(key: key);

  @override
  _StudentCorcesPageState createState() => _StudentCorcesPageState();
}

class _StudentCorcesPageState extends State<StudentCorcesPage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Column(
          children: [
            StudentCouresAppBar(),
            Body(),
          ],
        ),
      ),
    );
  }
}

class Category {
  String thumbnail;
  String name;
  int noOfCourses;

  Category({
    required this.name,
    required this.noOfCourses,
    required this.thumbnail,
  });
}

List<Category> categoryList = [
  Category(
    name: 'Development',
    noOfCourses: 55,
    thumbnail: 'assets/icons/laptop.jpg',
  ),
  Category(
    name: 'Accounting',
    noOfCourses: 20,
    thumbnail: 'assets/icons/accounting.jpg',
  ),
  Category(
    name: 'Photography',
    noOfCourses: 16,
    thumbnail: 'assets/icons/photography.jpg',
  ),
  Category(
    name: 'Product Design',
    noOfCourses: 25,
    thumbnail: 'assets/icons/design.jpg',
  ),
];
