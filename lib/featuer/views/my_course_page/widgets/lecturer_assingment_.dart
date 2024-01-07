
import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/widgets/shmmier_box.dart';

class LecturerAssingmentPH extends StatelessWidget {
  const LecturerAssingmentPH({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      shmmierbox(
                        height: 60,
                        width: 60,
                        boardRadius: 30,
                      ),
                      shmmierbox(
                        height: 60,
                        width: 60,
                        boardRadius: 30,
                      ),
                    ],
                  ),
                  shmmierbox(
                    height: 60,
                    width: MediaQuery.sizeOf(context).width * .8,
                  ),
                  Row(
                    children: [
                      shmmierbox(
                        height: 50,
                        width: 50,
                        boardRadius: 25,
                      ),
                      shmmierbox(
                        height: 40,
                        width: MediaQuery.sizeOf(context).width * .3,
                        // boardRadius: 30,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: shmmierbox(
                      height: 70,
                      width: MediaQuery.sizeOf(context).width * .7,
                      boardRadius: 40,
                    ),
                  ),
                  SizedBox(
                    height: SMALL_SPACER,
                  ),
                  Column(
                    children: List.generate(
                        10,
                        (index) => Row(
                              children: [
                                shmmierbox(
                                  height: 40,
                                  width:
                                      MediaQuery.sizeOf(context).width * .3,
                                ),
                                shmmierbox(
                                  height: 40,
                                  width:
                                      MediaQuery.sizeOf(context).width * .3,
                                ),
                                Spacer(),
                                shmmierbox(
                                  height: 40,
                                  width: 40,
                                ),
                              ],
                            )),
                  )
                ],
              ),
            ),
          ),
        ),
      );
  }
}