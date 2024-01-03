import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_elevated_buttom.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_filed.dart';
import 'package:remote_learing_app_frontend/featuer/models/lecturer_model.dart';
import 'package:remote_learing_app_frontend/featuer/views/my_course_page/instrctor_lecturer.dart';

String? validateName(String? value) {
  // String pattern = r'(^[a-zA-Zا-ي]*$)';
  String pattern = '[a-zA-Zء-ي ]+';

  RegExp regExp = RegExp(pattern);
  if (value?.isEmpty ?? true) {
    return "حقل الاسم متطلب";
  } else if (!regExp.hasMatch(value ?? '')) {
    return "الاسم ينبغي ان يكون من ١-ي او من a-z";
  }
  return null;
}

String? validaterequired(String? value) {
  // String pattern = r'(^[a-zA-Zا-ي]*$)';
  String pattern = '[0-9a-zA-Zء-ي ]+';

  RegExp regExp = RegExp(pattern);
  if (value!.isEmpty) {
    return "filed required";
  } else if (!regExp.hasMatch(value )) {
    return "الاسم ينبغي ان يكون من ١-ي او من a-z";
  }
  return null;
}

String? validatepassword(String? value) {
  // String pattern = r'(^[a-zA-Zا-ي]*$)';
  String pattern = '[0-9a-zA-Zء-ي ]+';

  RegExp regExp = RegExp(pattern);
  if (value!.isEmpty) {
    return "password required";
  } else if (!regExp.hasMatch(value)) {
    return "الاسم ينبغي ان يكون من ١-ي او من a-z";
  }
  return null;
}

String? validateEmail(String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value!.trim() ?? '')) {
    return "Ebter valid Email";
  } else {
    return null;
  }
}

bool isDarkMode(BuildContext context) {
  if (Theme.of(context).brightness == Brightness.light) {
    return false;
  } else {
    return true;
  }
}

InputDecoration getInputDecoration(
    {required String hint,
    required bool darkMode,
    required Color errorColor,
    Widget? suffixIcon}) {
  return InputDecoration(
    suffixIconColor: GRAY_COLOR,
    suffixIcon: suffixIcon,
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    fillColor: darkMode ? Colors.black54 : WHITH_COLOR,
    hintText: hint,
    hintStyle: GRAY_TEXT,
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(color: PRIMARY_COLOR, width: 2.0)),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: errorColor),
      borderRadius: BorderRadius.circular(25.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: errorColor),
      borderRadius: BorderRadius.circular(25.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: GRAY_COLOR),
      borderRadius: BorderRadius.circular(25.0),
    ),
  );
}

InputDecoration getInputDecorationSB(
    {required String hint, required bool darkMode, Widget? suffixIcon}) {
  double borderRadius = 15;
  return InputDecoration(
    suffixIconColor: GRAY_COLOR,
    suffixIcon: suffixIcon,
    contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
    fillColor: darkMode ? Colors.black54 : WHITH_COLOR,
    hintText: hint,
    hintStyle: GRAY_TEXT,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: GRAY_COLOR),
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: GRAY_COLOR),
      borderRadius: BorderRadius.circular(borderRadius),
    ),
  );
}

showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        showCloseIcon: true,
        backgroundColor: PRIMARY_COLOR,
        content: Text(
          message,
          style: TextStyle(color: WHITH_COLOR),
        ),
      ),
    );
}

Widget? AnimatedButoom({required bool isloaded}) {
  return isloaded
      ? null
      : SpinKitFadingGrid(
          size: 25,
          color: WHITH_COLOR,
        );
}


// showBottomSheet (BuildContext context ){

//    showModalBottomSheet(
//                       enableDrag: true,
//                       context: context,
//                       builder: (context) {
//                         GlobalKey<FormState> FormKey = GlobalKey();
//                         AutovalidateMode validation = AutovalidateMode.always;
//                         List<TextEditingController> controllers = List.generate(
//                             3, (index) => TextEditingController());
//                         return SingleChildScrollView(
//                           child: Form(
//                             key: FormKey,
//                             autovalidateMode: validation,
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 CustomTextFiled(
//                                   title: "Title",
//                                   lable: "",
//                                   controller: controllers[0],
//                                   validate: validaterequired,
//                                 ),
//                                 CustomTextFiled(
//                                   title: "Description",
//                                   lable: "",
//                                   controller: controllers[1],
//                                   validate: validaterequired,
//                                 ),
//                                 CustomTextFiled(
//                                   title: "Note",
//                                   lable: "",
//                                   controller: controllers[2],
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                     vertical: 32.0,
//                                     horizontal: SMALL_SPACER / 2,
//                                   ).copyWith(bottom: 0),
//                                   child: pickDateWidget(selectData: selectData),
//                                 ),
//                                 StatefulBuilder(
//                                   builder: (context, setstate) =>
//                                       CustomElevatedBottom(
//                                     child: AnimatedButoom(isloaded: isloaded),
//                                     lable: "save",
//                                     backColor: PRIMARY_COLOR,
//                                     onPressedFun: () async {
//                                       if (FormKey.currentState!.validate()) {
//                                         Lecturer lecturer = Lecturer(
//                                             title: controllers[0].text,
//                                             description: controllers[1].text,
//                                             note: controllers[2].text,
//                                             subjectId: subject.id,
//                                             lecturerData:
//                                                 "$selectData".split(" ").first);
//                                         isloaded = false;
//                                         Map resutle;
//                                         LVM
//                                             .storeLectuer(ReposteryAPI(),
//                                                 subject.id!, lecturer)
//                                             .then((value) {
//                                           resutle = value;
//                                           if (resutle["status"])
//                                             Navigator.pop(context);
//                                           isloaded = true;
//                                           showSnackBar(
//                                               context, resutle["message"]);
//                                           setstate(
//                                             () {},
//                                           );
//                                         });
//                                         setstate(
//                                           () {},
//                                         );
//                                       }
//                                     },
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         );
//                       });
// }
