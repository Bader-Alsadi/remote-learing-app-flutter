// ignore_for_file: unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/helpers/ui_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_api.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_elevated_buttom.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_filed.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/auth_vm.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  static const String ROUTE = "login page";
  final GlobalKey<FormState> FormKey = GlobalKey();
  AutovalidateMode _validate = AutovalidateMode.disabled;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  AuthVM avm = AuthVM();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: FormKey,
            autovalidateMode: _validate,
            child: Column(children: [
              CustomTextFiled(
                lable: "Email",
                controller: email,
                validate: validateEmail,
              ),
              CustomTextFiled(
                controller: password,
                lable: "password",
              ),
              CustomElevatedBottom(
                lable: "save",
                backColor: PRIMARY_COLOR,
                onPressedFun: () async {
                  Map<String, dynamic> data = {
                    "email": email.text,
                    "password": password.text
                  };
                  Map resutle = await avm.login(ReposteryAPI(), data);
                  showSnackBar(context, resutle["message"]);
                  if (FormKey.currentState!.validate()) {}
                },
              )
            ]),
          ),
        ),
      ),
    );
  }
}
