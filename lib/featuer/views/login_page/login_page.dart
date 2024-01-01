// ignore_for_file: unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/core/helpers/ui_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_api.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_elevated_buttom.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_filed.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/auth_vm.dart';
import 'package:remote_learing_app_frontend/featuer/views/root_page.dart/root_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  static const String ROUTE = "login page";
  final GlobalKey<FormState> FormKey = GlobalKey();
  AutovalidateMode _validate = AutovalidateMode.disabled;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isDipaly = true;
  AuthVM avm = AuthVM();
  bool isloaded = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: FormKey,
            autovalidateMode: _validate,
            child: Column(
              children: [
                Image.asset(
                  "assets/images/courses/login.png",
                  height: 200,
                ).animate(
                    autoPlay: true, effects: [FadeEffect(duration: 800.ms)]),
                Text(
                  "Welcom Back",
                  style: TITLE,
                ),
                SizedBox(
                  height: SMALL_SPACER * .6,
                ),
                Text(
                  "Please login first before you start your intesrted trip",
                  style: SUB_TITLE,
                ),
                CustomTextFiled(
                  title: "Email Address",
                  lable: "enter your email ",
                  controller: email,
                  validate: validateEmail,
                ),
                StatefulBuilder(builder: (context, setState) {
                  return CustomTextFiled(
                    title: "Password",
                    lable: "Enter your password",
                    obscureText: isDipaly,
                    suffixIcon: InkWell(
                        onTap: () {
                          isDipaly = !isDipaly;
                          setState(() {});
                        },
                        child: Icon(isDipaly
                            ? Icons.visibility_off
                            : Icons.visibility)),
                    controller: password,
                  );
                }),
                SizedBox(
                  height: SMALL_SPACER,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forget Passsword",
                      style: GRAY_TEXT,
                    ),
                    SizedBox(
                      width: SMALL_SPACER / 2,
                    ),
                  ],
                ),
                StatefulBuilder(
                  builder: (context, setstate) => CustomElevatedBottom(
                    child: AnimatedButoom(isloaded: isloaded),
                    lable: "save",
                    backColor: PRIMARY_COLOR,
                    onPressedFun: () async {
                      if (FormKey.currentState!.validate()) {
                        Map<String, dynamic> data = {
                          "email": email.text.trim(),
                          "password": password.text
                        };
                        isloaded = false;
                        Map resutle;
                        avm.login(ReposteryAPI(), data).then((value) {
                          resutle = value;
                          if (resutle["status"])
                            Navigator.pushReplacementNamed(
                              context,
                              RootPage.ROUTE,
                            );
                          isloaded = true;
                          showSnackBar(context, resutle["message"]);
                          setstate(
                            () {},
                          );
                        });
                        setstate(
                          () {},
                        );
                        // Map resutle = await avm.login(ReposteryAPI(), data);
                        // if (resutle["status"]) {
                        //   Navigator.pushReplacementNamed(
                        //     context,
                        //     RootPage.ROUTE,
                        //   );
                        //   print("cdc");
                        // }
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
