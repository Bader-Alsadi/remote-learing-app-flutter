// import 'package:flutter/material.dart';

// class InternetConnection extends StatelessWidget {
//   const InternetConnection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return   StreamBuilder(
//           stream: Connectivity().onConnectivityChanged,
//           builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
//             // sometimes the stream builder doesn't work with simulator so you can check this on real devices to get the right result
//             print(snapshot.toString());
//             if (snapshot.hasData) {
//               ConnectivityResult? result = snapshot.data;
//               if (result == ConnectivityResult.mobile) {
//                 return connected('Mobile');
//               } else if (result == ConnectivityResult.wifi) {
//                 return connected('WIFI');
//               } else {
//                 return noInternet();
//               }
//             } else {
//               return loading();
//             }
//           },
//         ),;
//   }
// }