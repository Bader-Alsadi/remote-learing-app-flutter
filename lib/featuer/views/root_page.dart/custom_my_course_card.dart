// import 'package:flutter/material.dart';
// import 'package:remote_learing_app_frontend/core/constints/colors.dart';
// import 'package:remote_learing_app_frontend/core/constints/padding.dart';
// import 'package:remote_learing_app_frontend/core/widgets/costom_heading.dart';
// import 'package:remote_learing_app_frontend/featuer/views/root_page.dart/code.dart';

// class MyCoursesPage extends StatefulWidget {
//   const MyCoursesPage({Key? key}) : super(key: key);

//   @override
//   _MyCoursesPageState createState() => _MyCoursesPageState();
// }

// class _MyCoursesPageState extends State<MyCoursesPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: background,
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         elevation: 0.0,
//         // brightness: Brightness.light,
//         backgroundColor: Colors.transparent,
//       ),
//       body: getBody(),
//     );
//   }

//   Widget getBody() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(SMALL_SPACER),
//       child: Column(
//         children: [
//           SizedBox(height: SPACER - 1.0),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               CustomHeading(
//                 title: 'My Courses',
//                 subTitle: 'Let\'s continue, shall we?',
//                 color: SECONDRY_COLOR,
//               ),
//               Text(
//                 MyCoursesJson.length.toString() + ' Courses',
//                 style: TextStyle(color: SECONDRY_COLOR, fontSize: 15.0),
//               ),
//             ],
//           ),
//           SizedBox(height: SPACER),
//           Column(
//             children: List.generate(MyCoursesJson.length, (index) {
//               var data = MyCoursesJson[index];
//               List lecturer = Code['popular_lecturer'] as List;
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: 20.0),
//                 child: GestureDetector(
//                   onTap: () {},
//                   child: CustomMyCoursesCard(
//                     image: data['image'],
//                     title: data['title'],
//                     instructor: data['user_name'],
//                     videoAmount: data['video'],
//                     percentage: data['percentage'],
//                   ),
//                 ),
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // const Color PRIMARY_COLOR = Color(0xFF2EA5FF);
// // const Color SECONDRY_COLOR = Color(0xFF132342);
// const Color background = Color(0xFFF5F5F5);
// // const Color _COLOR = Color(0xFFFFFFFF);
// // const Color textBlack = Color(0xFF000000);
// const Color grey = Color(0xFF707070);

// const List MyCoursesJson = [
//   {
//     'image':
//         'https://images.unsplash.com/photo-1575089976121-8ed7b2a54265?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=987&q=80',
//     'video': '20',
//     'title': 'Web Apps with React and Firebase Introduction',
//     'user_profile':
//         'https://images.unsplash.com/photo-1601582589907-f92af5ed9db8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80',
//     'user_name': 'Jonathan',
//     'price': '30.00',
//     'percentage': 30.0,
//   },
//   {
//     'image':
//         'https://images.unsplash.com/photo-1618788372246-79faff0c3742?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=927&q=80',
//     'video': '15',
//     'title': 'Getting start with UX Flow design',
//     'user_profile':
//         'https://images.unsplash.com/photo-1558507652-2d9626c4e67a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=987&q=80',
//     'user_name': 'Ormid',
//     'price': '22.00',
//     'percentage': 70.0,
//   },
// ];

// class CustomMyCoursesCard extends StatefulWidget {
//   const CustomMyCoursesCard({
//     Key? key,
//     required this.image,
//     required this.title,
//     required this.instructor,
//     required this.videoAmount,
//     this.percentage = 0,
//   }) : super(key: key);

//   final String image;
//   final String title;
//   final String instructor;
//   final String videoAmount;
//   final double percentage;

//   @override
//   _CustomMyCoursesCardState createState() => _CustomMyCoursesCardState();
// }

// class _CustomMyCoursesCardState extends State<CustomMyCoursesCard> {
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;

//     return Container(
//       width: size.width,
//       height: size.width * .3,
//       padding: const EdgeInsets.all(15.0),
//       decoration: BoxDecoration(
//         color: WHITH_COLOR,
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Container(
//             height: size.width * .13,
//             child: Row(
//               children: [
//                 Container(
//                   height: size.width * .13,
//                   width: size.width * .13,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(10.0),
//                     child: Image.network(
//                       widget.image,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: MIN_SPACER),
//                 Flexible(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.title,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           color: SECONDRY_COLOR,
//                           fontSize: 13.0,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Intructor: ' + widget.instructor,
//                             style: TextStyle(
//                               fontSize: 11.0,
//                               color: grey,
//                             ),
//                           ),
//                           Text(
//                             '6/' + widget.videoAmount,
//                             style: TextStyle(
//                               fontSize: 11.0,
//                               color: grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Flexible(
//                 child: Stack(
//                   alignment: Alignment.centerLeft,
//                   clipBehavior: Clip.none,
//                   children: [
//                     Container(
//                       width: size.width,
//                       height: 5.0,
//                       decoration: BoxDecoration(
//                         color: SECONDRY_COLOR.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(100.0),
//                       ),
//                     ),
//                     Container(
//                       width: widget.percentage * 2.8,
//                       height: 7.0,
//                       decoration: BoxDecoration(
//                         color: PRIMARY_COLOR,
//                         borderRadius: BorderRadius.circular(100.0),
//                         boxShadow: [
//                           BoxShadow(
//                             color: PRIMARY_COLOR.withOpacity(0.5),
//                             blurRadius: 6.0,
//                             offset: Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(width: MIN_SPACER * 2),
//               Container(
//                 width: 50,
//                 alignment: Alignment.centerRight,
//                 child: Text(
//                   widget.percentage.toString() + '%',
//                   style: TextStyle(
//                       fontSize: 13.0,
//                       color: PRIMARY_COLOR,
//                       fontWeight: FontWeight.w700),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }


