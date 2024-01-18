// ignore_for_file: unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get_storage/get_storage.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/core/helpers/get_storge_helper.dart';
import 'package:remote_learing_app_frontend/core/helpers/ui_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_api.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_elevated_buttom.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_filed.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/auth_vm.dart';
import 'package:remote_learing_app_frontend/featuer/views/root_page.dart/root_page2.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/constints/image_paths.dart';
class LoginPage extends StatelessWidget {
  late AppLocalizations? locale;
  LoginPage({super.key});
  static const String ROUTE = "login page";
  final GlobalKey<FormState> FormKey = GlobalKey();
  AutovalidateMode _validate = AutovalidateMode.disabled;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isDipaly = true;
  AuthVM avm = AuthVM();
  bool isloaded = true;
  GetStorage getStInstance = GetStorageHelper.instance("user");
  @override
  Widget build(BuildContext context) {
    locale= AppLocalizations.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: FormKey,
            autovalidateMode: _validate,
            child: Column(
              children: [
                SizedBox(height: MIN_SPACER ,),
                Image.asset(
                  "${IMAHES}courses/login.png",
                  height: 200,
                ).animate(
                    autoPlay: true, effects: [FadeEffect(duration: 800.ms)]),
                Text(
                 locale!.fristPageTitle ,
                  style: TITLE,
                ),
                SizedBox(
                  height: SMALL_SPACER * .6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: SMALL_SPACER),
                  child: Text(
                    locale!.start,
                    style: SUB_TITLE,
                    textAlign: TextAlign.center,

                  ),
                ),
                CustomTextFiled(
                  title:  locale!.emailAddress,
                  lable:  locale!.enterEmile,
                  controller: email,
                  validate: validateEmail,
                ),
                StatefulBuilder(builder: (context, setState) {
                  return CustomTextFiled(
                    validate: validatepassword,
                    title:  locale!.password,
                    lable:  locale!.enterPassword,
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
                  height: MIN_SPACER,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      locale!.forgetPassword,
                      style: GRAY_TEXT,
                    ),
                    SizedBox(
                      width: SMALL_SPACER * .5,
                    ),
                  ],
                ),
                SizedBox(
                  height: SMALL_SPACER * .5,
                ),
                StatefulBuilder(
                  builder: (context, setstate) => CustomElevatedBottom(
                    child: AnimatedButoom(isloaded: isloaded),
                    lable:  locale!.save,
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
                              BaseScreen.ROUTE,
                            );
                          isloaded = true;
                          showSnackBar(context, resutle["message"],resutle["status"]);
                          setstate(
                            () {},
                          );
                        });
                        setstate(
                          () {},
                        );

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
