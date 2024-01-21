import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_api.dart';
import 'package:remote_learing_app_frontend/featuer/models/report_model.dart';
import 'package:remote_learing_app_frontend/featuer/models/subjects_model.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/report_vm.dart';
import 'package:remote_learing_app_frontend/featuer/views/student_details/student_detials.dart';

class RepoutPage extends StatefulWidget {
  const RepoutPage({super.key, required this.subject});
  static const String ROUTE = "report_page";
  final Subject subject;

  @override
  State<RepoutPage> createState() => _RepoutPageState();
}

class _RepoutPageState extends State<RepoutPage> {
  List<Report> reports = [];
  @override
  void initState() {
    Provider.of<ReportVM>(context, listen: false)
        .feachDate(ReposteryAPI(), widget.subject.id!)
        .then((value) {
      reports = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final repoartVM = Provider.of<ReportVM>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          foregroundColor: WHITH_COLOR,
          title: Text("subject : ${widget.subject.name}"),
        ),
        body: Container(
          margin: EdgeInsets.all(MIN_SPACER),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (repoartVM.reports.length >= 5) ...[
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .4,
                    child: BarChart(BarChartData(
                      maxY: 100,
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: true,
                            getTitlesWidget: (value,mate){
                            return  Text(repoartVM.reports.firstWhere((element) => element.studentId==value).name!);
                            }
                          )
                        )
                      ),
                        barGroups: List.generate(
                      repoartVM.reports.sublist(0, 5).length,
                      (index) {
                        Report report =  repoartVM.reports[index];
                        return BarChartGroupData(x: report.studentId!, barRods: [
                        BarChartRodData(
                            color: index.isEven
                                ? PRIMARY_COLOR
                                : FOURTH_COLOR.withOpacity(.4),
                            toY: (report.finalMark ?? 0.0)
                                .toDouble()),
                      ]);
                      },
                    ).toList())),
                  ),
                ],
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: MIN_SPACER),
                  child: Text(
                    "subject : ${widget.subject.name}",
                    style: TEXT_NORMAL,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: DataTable(
                      sortAscending: true,
                      dataTextStyle: TEXT_NORMAL,
                      headingRowColor: MaterialStatePropertyAll(
                          PRIMARY_COLOR.withOpacity(.6)),
                      sortColumnIndex: 0,
                      columns: [
                        DataColumn(
                            label: Text("NO",
                                style:
                                    TEXT_NORMAL.copyWith(color: WHITH_COLOR))),
                        DataColumn(
                            label: Text("Name",
                                style:
                                    TEXT_NORMAL.copyWith(color: WHITH_COLOR))),
                        DataColumn(
                            numeric: true,
                            label: Text("Mark",
                                style:
                                    TEXT_NORMAL.copyWith(color: WHITH_COLOR)))
                      ],
                      rows: List.generate(
                          repoartVM.reports.length,
                          (index) => DataRow(
                                  onSelectChanged: (value) {
                                    Navigator.pushNamed(
                                        context, StudentDetails.ROUTE,arguments: [repoartVM.reports[index].studentId,widget.subject.id]);
                                  },
                                  color: MaterialStatePropertyAll(index.isOdd
                                      ? WHITH_COLOR
                                      : PRIMARY_COLOR.withOpacity(.2)),
                                  cells: [
                                    DataCell(Text("${index + 1}")),
                                    DataCell(Text(
                                      repoartVM.reports[index].name!,
                                    )),
                                    DataCell(
                                      Text(
                                        "${repoartVM.reports[index].finalMark ?? 0}",
                                        style: TEXT_NORMAL.copyWith(
                                            color: (repoartVM.reports[index]
                                                            .finalMark ??
                                                        0) <
                                                    50
                                                ? Colors.red
                                                : BLACK_COLOR),
                                      ),
                                    )
                                  ])).toList()),
                ),
              ],
            ),
          ),
        ).animate().fadeIn());
  }
}
