import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/core/repostery/repostery_api.dart';
import 'package:remote_learing_app_frontend/featuer/models/student_submission.dart';
import 'package:remote_learing_app_frontend/featuer/models/subjects_model.dart';
import '../../view_models/student_submission_vm.dart';

class StudentDetails extends StatefulWidget {
  const StudentDetails({super.key,required this.student_id, required this.subject_id});
  final int student_id;
  final int subject_id;
  static const String ROUTE = "student_details_page";

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}
class _StudentDetailsState extends State<StudentDetails> {
  @override
  void initState() {
Provider.of<StudentSubmissionVM>(context,listen: false).feachDate(ReposteryAPI(), {
  "student_id":widget.student_id,
  "enrollment_id":widget.subject_id
});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final studentSubmissionVN = Provider.of<StudentSubmissionVM>(context);
    return  Scaffold(
      appBar: AppBar(
         backgroundColor: PRIMARY_COLOR,
          foregroundColor: WHITH_COLOR,
        // title: Text("${widget.student_id ?? 0} | ${widget.subject_id ?? 0}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .4,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(MIN_SPACER),
                  child: Column(
                    children: [
                      Flexible(
                        child: PieChart(
                            swapAnimationDuration: Duration(seconds: 1),
                            swapAnimationCurve:Curves.easeIn,
                            PieChartData(
                              centerSpaceRadius: 80,
                              // centerSpaceColor: PRIMARY_COLOR,PRIMARY_COLOR
                              sectionsSpace: 3,
                          startDegreeOffset: 10,
                          sections: List.generate(studentSubmissionVN.studentSubmission.length, (index) {
                            StudentSubmissoin student= studentSubmissionVN.studentSubmission[index];
                            return PieChartSectionData(
                              color: student.color,
                              title: "${student.submission!.grade ?? 0}.0 %",
                              showTitle: true,
                              value: (student.submission!.grade ?? 0).toDouble()
                          );
                          },)
                        )),
                      ),
                      RichText(text: TextSpan(
                        children:  List.generate(studentSubmissionVN.studentSubmission.length,(index){
                          StudentSubmissoin student= studentSubmissionVN.studentSubmission[index];
                          return TextSpan(
                            children: [
                              TextSpan(text: "     "),
                              WidgetSpan(child: Container(
                                  height: 15,
                                  width: 15,
                                  color: student.color,
                                )),
                              WidgetSpan(child: SizedBox(width: MIN_SPACER,)),
                              TextSpan(text:  student.assingment!.title,style: TEXT_NORMAL.copyWith(color: BLACK_COLOR)),
                              TextSpan(text: "  ${student.submission!.grade} / ${student.assingment!.grade}",style: TEXT_NORMAL.copyWith(color: BLACK_COLOR)),
                            ]
                          );
                        })
                      )
                      )
                    ],
                  ),
                ),
              ),
            ),

            Card(child:
              Column(
                children: List.generate(studentSubmissionVN.studentSubmission.length,(index) {
                  StudentSubmissoin student = studentSubmissionVN.studentSubmission[index];
                  return Padding(
                    padding: const EdgeInsets.all(MIN_SPACER),
                    child: ListTile(
                      title:Text("assingment_title : ${student.assingment!.title!}") ,
                      subtitle:Text("assingment_title : ${student.assingment!.description!}") ,
                      trailing: Text("state : ${student.submission!.state! ? "accpetd" : "reveos"}"),
                                    ),
                  );
                },
              ),)
            )],
        ),
      ),
    );
  }
}