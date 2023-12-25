import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_elevated_buttom.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_filed.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static const String ROUTE = "login page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: [
            CustomTextFiled(
              lable: "Email",
            ),
            CustomTextFiled(
              lable: "password",
            ),
            CustomElevatedBottom(
              lable: "save",
            )
          ]),
        ),
      ),
    );
  }
}
