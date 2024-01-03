import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/core/helpers/ui_helper.dart';

class pickDateWidget extends StatelessWidget {
  pickDateWidget({
    super.key,
    required this.selectData,
  });

  DateTime? selectData;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setstate) {
      return Container(
        // width: double.infinity,
        alignment: Alignment.centerLeft,

        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              width: 2.0,
              color: GRAY_COLOR,
            )),
        child: TextButton(
            onPressed: () async {
              selectData = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2025));

              if (selectData == null) {
                showSnackBar(context, "selected date is null");
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
}