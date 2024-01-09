import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/image_paths.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/core/helpers/get_storge_helper.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_image_title.dart';

class Dashboard extends StatefulWidget {
  Dashboard({
    super.key,
  });
  static const String ROUTE = "dashbord";

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController seashCo = TextEditingController();

  GetStorage instance = GetStorageHelper.instance("user");

  late int showingTooltip;
  @override
  void initState() {
    showingTooltip = -1;
    super.initState();
  }

  BarChartGroupData generateGroupData(int x, int y) {
    return BarChartGroupData(
      x: x,
      showingTooltipIndicators: showingTooltip == x ? [0] : [],
      barRods: [
        BarChartRodData(toY: y.toDouble()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ImageAndTitle(
          textColor: BLACK_COLOR,
          imagePath: "assets/images/courses/course1.jpeg",
          title: "welcome, ${instance.read("name")} ",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(MIN_SPACER),
            child: Column(children: [
              Container(
                padding: EdgeInsets.all(SMALL_SPACER / 2),
                // height: MediaQuery.sizeOf(context).height * 0.2,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      PRIMARY_COLOR.withOpacity(0.6),
                      PRIMARY_COLOR.withOpacity(0.8),
                      PRIMARY_COLOR.withOpacity(0.9),
                      PRIMARY_COLOR,
                    ]),
                    borderRadius: BorderRadius.circular(25)),
                child: ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading: CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage(PLACE_HOLDER),
                  ),
                  title: NotmalWhitText(value: instance.read("name")),
                  subtitle: NotmalGrayText(value: instance.read("email")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: AspectRatio(
                  aspectRatio: 2,
                  child: BarChart(
                    BarChartData(
                      barGroups: [
                        generateGroupData(1, 10),
                        generateGroupData(2, 18),
                        generateGroupData(3, 4),
                        generateGroupData(4, 11),
                      ],
                      barTouchData: BarTouchData(
                          enabled: true,
                          handleBuiltInTouches: false,
                          touchCallback: (event, response) {
                            if (response != null &&
                                response.spot != null &&
                                event is FlTapUpEvent) {
                              setState(() {
                                final x = response.spot!.touchedBarGroup.x;
                                final isShowing = showingTooltip == x;
                                if (isShowing) {
                                  showingTooltip = -1;
                                } else {
                                  showingTooltip = x;
                                }
                              });
                            }
                          },
                          mouseCursorResolver: (event, response) {
                            return response == null || response.spot == null
                                ? MouseCursor.defer
                                : SystemMouseCursors.click;
                          }),
                    ),
                  ),
                ),
              ),
            ])),
      ),
    );
  }
}

class NotmalWhitText extends StatelessWidget {
  const NotmalWhitText({
    super.key,
    required this.value,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: TEXT_NORMAL.copyWith(color: WHITH_COLOR),
    );
  }
}

class NotmalGrayText extends StatelessWidget {
  const NotmalGrayText({
    super.key,
    required this.value,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: GRAY_TEXT,
    );
  }
}
