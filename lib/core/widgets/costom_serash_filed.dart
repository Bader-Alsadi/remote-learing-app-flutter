import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/helpers/ui_helper.dart';
class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: textfiledDecortion(),
    );
  }
}
