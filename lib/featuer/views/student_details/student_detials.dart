import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';

class StudentDetails extends StatelessWidget {
  const StudentDetails({super.key});
  static const String ROUTE = "student_details_page";

  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
      appBar: AppBar(
         backgroundColor: PRIMARY_COLOR,
          foregroundColor: WHITH_COLOR,
      ),
    );
  }
}