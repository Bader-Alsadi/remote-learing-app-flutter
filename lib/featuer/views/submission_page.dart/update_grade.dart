// import 'package:flutter/material.dart';
// import 'package:remote_learing_app_frontend/core/constints/colors.dart';
// import 'package:remote_learing_app_frontend/core/helpers/ui_helper.dart';
// import 'package:remote_learing_app_frontend/core/repostery/repostery_api.dart';
// import 'package:remote_learing_app_frontend/core/widgets/custom_elevated_buttom.dart';
// import 'package:remote_learing_app_frontend/core/widgets/custom_filed.dart';
// import 'package:remote_learing_app_frontend/featuer/models/assingment_model.dart';
// import 'package:remote_learing_app_frontend/featuer/models/submission_model.dart';
// import 'package:remote_learing_app_frontend/featuer/view_models/submission_vm.dart';
// Future<dynamic> updateGrade(BuildContext context, SubmissionVM SVM,Submission submission,Assingment assingment) {
//      TextEditingController gradeC = TextEditingController();
//   AutovalidateMode validtion = AutovalidateMode.always;
//   GlobalKey<FormState> FormKey = GlobalKey();
//     return showDialog(
//               context: context,
//               builder: (context) => AlertDialog(
//                     title: Text("Add grade"),
//                     content: Form(
//                       key: FormKey,
//                       autovalidateMode: validtion,
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           CustomTextFiled(
//                             title: "grade",
//                             filedType: TextInputType.number,
//                             lable: "",
//                             controller: gradeC,
//                             validate: validaterequired,
//                           ),
//                           StatefulBuilder(
//                             builder: (context, setstate) {
//                               bool isloaded = true;
//                               return CustomElevatedBottom(
//                                 child: AnimatedButoom(isloaded: isloaded),
//                                 lable: "save",
//                                 backColor: PRIMARY_COLOR,
//                                 onPressedFun: () async {
//                                   if (FormKey.currentState!.validate()) {
//                                     print(
//                                         "studID:${widget.submission.studentId}");
//                                     Submission submission = Submission(
//                                       grade: int.parse(gradeC.text),
//                                       studentId: submission.studentId,
//                                       assingmentId: widget.assingment.id,
//                                     );

//                                     isloaded = false;
//                                     Map resutle;
//                                     SVM
//                                         .updateLectuer(
//                                             ReposteryAPI(),
//                                             widget.assingment.id!,
//                                             widget.submission.id!,
//                                             submission)
//                                         .then((value) {
//                                       resutle = value;
//                                       if (resutle["status"])
//                                         Navigator.pop(context);

//                                       isloaded = true;
//                                       showSnackBar(
//                                           context, resutle["message"]);
//                                       setstate(
//                                         () {},
//                                       );
//                                     });
//                                     setstate(
//                                       () {},
//                                     );
//                                   }
//                                 },
//                               );
//                             },
//                           )
//                         ],
//                       ),
//                     ),
//                   ));
//   }