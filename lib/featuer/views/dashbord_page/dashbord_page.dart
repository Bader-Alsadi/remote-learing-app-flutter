import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_card_cource.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_icon.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_serash_bar.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key, required this.role});
  static const String ROUTE = "dashbord";
  late String role;
  TextEditingController seashCo = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            role,
            style: TextStyle(color: BLACK_COLOR),
          ),
        ),
        body: Center(child: Text(role)));
  }
}
