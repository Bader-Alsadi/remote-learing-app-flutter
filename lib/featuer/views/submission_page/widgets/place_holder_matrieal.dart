import 'package:flutter/material.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/widgets/shmmier_box.dart';

class PlaceHolderMaterial extends StatelessWidget {
  const PlaceHolderMaterial({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: List.generate(
              10,
              (index) => Column(
                    children: [
                      Row(children: [
                        shmmierbox(
                          height: 60,
                          width: 50,
                          boardRadius: 10.5,
                        ),
                        shmmierbox(
                          height: 25,
                          width: 25,
                          boardRadius: 22.5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            shmmierbox(
                              height: 25,
                              width: MediaQuery.sizeOf(context).width * .2,
                            ),
                            shmmierbox(
                              height: 25,
                              width: MediaQuery.sizeOf(context).width * .3,
                            ),
                          ],
                        ),
                        Spacer(),
                        shmmierbox(
                          height: 25,
                          width: 25,
                          boardRadius: 22.5,
                        ),
                      ]),
                      SizedBox(
                        height: MIN_SPACER,
                      )
                    ],
                  ))),
    );
  }
}
