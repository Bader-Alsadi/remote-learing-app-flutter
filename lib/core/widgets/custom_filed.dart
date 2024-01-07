import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/core/helpers/ui_helper.dart';

class CustomTextFiled extends StatelessWidget {
  CustomTextFiled(
      {super.key,
      required this.title,
      this.lable,
      this.validate,
      this.maxLines = 1,
      this.readOnly = false,
      this.filedType,
      this.ontop,
      this.filterPattern = '[]',
      this.onchange,
      this.enable = true,
      this.obscureText = false,
      this.controller,
      this.suffixIcon});

  bool enable;
  String title;
  String? lable;
  TextEditingController? controller;
  String? Function(String?)? validate;
  int? maxLines;
  bool? readOnly;
  bool? obscureText;
  void Function()? ontop;
  void Function(String)? onchange;
  String? filterPattern;
  TextInputType? filedType;
  Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 32.0,
        horizontal: SMALL_SPACER / 2,
      ).copyWith(bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: FEILD_TITLE,
          ),
          SizedBox(
            height: MIN_SPACER,
          ),
          TextFormField(
            
              obscureText: obscureText!,
              enabled: enable,
              onChanged: onchange,
              onTap: ontop,
              readOnly: readOnly!,
              controller: controller,
              maxLines: maxLines,
              textAlignVertical: TextAlignVertical.center,
              textInputAction: TextInputAction.next,
              validator: validate,
              style: const TextStyle(fontSize: 18.0),
              keyboardType: filedType ?? TextInputType.name,
              cursorColor: PRIMARY_COLOR,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(filterPattern!))
              ],
              decoration: getInputDecoration(
                  hint: lable!,
                  suffixIcon: suffixIcon,
                  darkMode: isDarkMode(context),
                  errorColor: Theme.of(context).colorScheme.error)),
        ],
      ),
    );
  }
}
