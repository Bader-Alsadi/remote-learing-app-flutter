import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';

class NavRouteImage extends StatelessWidget {
  const NavRouteImage({super.key, required this.path});
  final String path;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      colorFilter: ColorFilter.mode(PRIMARY_COLOR, BlendMode.srcIn),
      height: 30,
    )
        ;
  }
}
