import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/helpers/ui_helper.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_api.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_elevated_buttom.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_filed.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_pickdate.dart';
import 'package:remote_learing_app_frontend/featuer/models/assingment_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/lecturer_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/subjects_model.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/Assingment_lecturer.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/lectuer_vm.dart';

import '../../../../core/constints/text_style.dart';

GlobalKey<FormState> FormKey = GlobalKey();
AutovalidateMode validation = AutovalidateMode.always;
List<TextEditingController> controllers =
    List.generate(3, (index) => TextEditingController());
bool isloaded = true;
DateTime? selectData = DateTime.now();
Future<dynamic> showDialogC(BuildContext context, ALVM LVM, Subject subject,
    {Lecturer? lecturer, Assingment? assingment}) {
  LVM is LecturerVM
      ? setLecturerValues(lecturer)
      : setAssingmentValues(assingment);
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) => SingleChildScrollView(
      child: Form(
        key: FormKey,
        autovalidateMode: validation,
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFiled(
                title: "",
                lable: "Title",
                controller: controllers[0],
                validate: validaterequired,
              ),
              CustomTextFiled(
                // maxLines: 5,
                title: "",
                lable: "Description",
                controller: controllers[1],
                validate: validaterequired,
              ),
              LVM is LecturerVM
                  ? CustomTextFiled(
                      title: "",
                      lable: "Note",
                      controller: controllers[2],
                    )
                  : CustomTextFiled(
                      title: "",
                      filedType: TextInputType.number,
                      lable: "grade",
                      controller: controllers[2],
                      validate: validaterequired,
                    ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 32.0,
                  horizontal: SMALL_SPACER / 2,
                ).copyWith(bottom: 0),
                child: showDatePickerC(),
                // pickDateWidget(selectData: selectData),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: SMALL_SPACER/2),
                child: StatefulBuilder(
                  builder: (context, setstate) => CustomElevatedBottom(
                    child: AnimatedButoom(isloaded: isloaded),
                    lable: "save",
                    backColor: PRIMARY_COLOR,
                    onPressedFun: () async {
                      if (FormKey.currentState!.validate()) {
                        isloaded = false;
                        if (LVM is LecturerVM) {
                          if (lecturer != null) {
                            lecturer.title = controllers[0].text;
                            lecturer.description = controllers[1].text;
                            lecturer.note = controllers[2].text;
                            lecturer.lecturerData = selectData.toString();
                            updateLecturer(
                                LVM, lecturer, subject.id!, context, setstate);
                            setstate(
                              () {},
                            );
                          } else {
                            Lecturer lecturer = Lecturer(
                                title: controllers[0].text,
                                description: controllers[1].text,
                                note: controllers[2].text,
                                subjectId: subject.id,
                                lecturerData: "$selectData".split(" ").first);
                            addLecturer(
                                LVM, subject.id!, lecturer, context, setstate);
                            setstate(
                              () {},
                            );
                          }
                        } else {
                          if (assingment != null) {
                            assingment.title = controllers[0].text;
                            assingment.description = controllers[1].text;
                            assingment.grade = int.parse(controllers[2].text);
                            assingment.deadline = selectData.toString();
                            updateAssingment(LVM, assingment, subject.id!,
                                context, setstate);
                            setstate(
                              () {},
                            );
                          } else {
                            print("$setstate");
                            Assingment assingment = Assingment(
                                title: controllers[0].text,
                                description: controllers[1].text,
                                grade: int.parse(controllers[2].text),
                                enrollmentId: subject.id,
                                deadline: "$selectData".split(" ").first);
                            Map resutle;
                            LVM
                                .storeLectuer(
                                    ReposteryAPI(), subject.id!, assingment)
                                .then((value) {
                              resutle = value;
                              if (resutle["status"]) Navigator.pop(context);
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
                        }
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );

}

Widget showDatePickerC() {
  return StatefulBuilder(builder: (context, setstate) {
    return Container(
      // width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(MIN_SPACER / 2),
      margin: EdgeInsets.only(top: SMALL_SPACER),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            width: 1.0,
            color: GRAY_COLOR,
          )),
      child: TextButton(
          onPressed: () async {
            selectData = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2025));
            print("$selectData");
            if (selectData == null) {
              showSnackBar(context, "selected date is null", false);
            }
            setstate(() {});
          },
          child: Text(
            "Date : ${selectData?.year}-${selectData?.month}-${selectData?.day}",
            style: TEXT_NORMAL.copyWith(color: BLACK_COLOR),
          )),
    );
  });
}

addLecturer(ALVM LVM, int subjectId, Lecturer lecturer, context,
    void Function(void Function()) setstate) {
  Map resutle;
  LVM.storeLectuer(ReposteryAPI(), subjectId, lecturer).then((value) {
    resutle = value;
    if (resutle["status"]) Navigator.pop(context);
    isloaded = true;
    showSnackBar(context, resutle["message"],resutle["status"]);
    setstate(
      () {},
    );
  });
}

updateLecturer(ALVM LVM, Lecturer lecturer, int subjectId, context,
    void Function(void Function()) setstate) {
  Map resutle;
  LVM
      .updateLectuer(ReposteryAPI(), subjectId, lecturer.id!, lecturer)
      .then((value) {
    resutle = value;
    if (resutle["status"]) Navigator.pop(context);
    isloaded = true;
    showSnackBar(context, resutle["message"],resutle["status"]);
    setstate(
      () {},
    );
  });
}

updateAssingment(ALVM LVM, Assingment assingment, int subjectId, context,
    void Function(void Function()) setstate) {
  Map resutle;
  LVM
      .updateLectuer(ReposteryAPI(), subjectId, assingment.id!, assingment)
      .then((value) {
    resutle = value;
    if (resutle["status"]) Navigator.pop(context);
    isloaded = true;
    showSnackBar(context, resutle["message"],resutle["status"]);
    setstate(
      () {},
    );
  });
}

setLecturerValues(Lecturer? lecturer) {
  if (lecturer != null) {
    controllers[0].text = lecturer.title!;
    controllers[1].text = lecturer.description!;
    controllers[2].text = lecturer.note ?? "";
    selectData = DateTime.parse(lecturer.lecturerData!);
  } else {
    controllers.forEach((element) {
      element.clear();
    });
  }
}

setAssingmentValues(Assingment? assingment) {
  if (assingment != null) {
    controllers[0].text = assingment.title!;
    controllers[1].text = assingment.description!;
    controllers[2].text = "${assingment.grade ?? ""}";
    selectData = DateTime.parse(assingment.deadline!);
  } else {
    controllers.forEach((element) {
      element.clear();
    });
  }
}

// assinment

addAssingment(ALVM LVM, int subjectId, Assingment assingment, context,
    void Function(void Function()) setstate) {
  Map resutle;
  LVM.storeLectuer(ReposteryAPI(), subjectId, assingment).then((value) {
    resutle = value;
    if (resutle["status"]) Navigator.pop(context);
    isloaded = true;
    showSnackBar(context, resutle["message"], resutle["status"]);
    setstate(
          () {},
    );
  });


}
