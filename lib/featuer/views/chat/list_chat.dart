
// import 'package:flutter/material.dart';
// import 'package:remote_learing_app_frontend/core/constints/text_style.dart';

// class ListBasicRoute extends StatefulWidget {

//   ListBasicRoute();

//   @override
//   ListBasicRouteState createState() => new ListBasicRouteState();
// }

// class ListBasicRouteState extends State<ListBasicRoute> {
//   late BuildContext context;
//   // void onItemClick(int index, People obj) {
//   //   MyToast.show(obj.name!, context, duration: MyToast.LENGTH_SHORT);
//   // }

//   @override
//   Widget build(BuildContext context) {
//     this.context = context;
//     // List<People> items = Dummy.getPeopleData();
//     // items.addAll(Dummy.getPeopleData());
//     // items.addAll(Dummy.getPeopleData());

//     return new Scaffold(
//       // appBar: CommonAppBar.getPrimarySettingAppbar(context, "Basic") as PreferredSizeWidget?,
//       body: ListBasicAdapter(items, onItemClick).getView(),
//     );
//   }
// }


// class ListBasicAdapter {
//   List? items = <People>[];
//   List itemsTile = <ItemTile>[];

//   ListBasicAdapter(this.items, onItemClick) {
//     for (var i = 0; i < items!.length; i++) {
//       itemsTile.add(ItemTile(index: i, object: items![i], onClick: onItemClick));
//     }
//   }

//   Widget getView() {
//     return Container(
//       child: ListView.builder(
//         itemBuilder: (BuildContext context, int index) => itemsTile[index],
//         itemCount: itemsTile.length,
//         padding: EdgeInsets.symmetric(vertical: 10),
//       ),
//     );
//   }
// }

// // ignore: must_be_immutable
// class ItemTile extends StatelessWidget {
//   final People object;
//   final int index;
//   final Function onClick;

//   const ItemTile({
//     Key? key,
//     required this.index,
//     required this.object,
//     required this.onClick,
//   })  : super(key: key);

//   void onItemClick(People obj) {
//     onClick(index, obj);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: (){
//         onItemClick(object);
//       },
//       child: Padding(
//         padding: EdgeInsets.symmetric(vertical: 5),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.max,
//           children: <Widget>[
//             Container(width: 20),
//             Container(
//                 child: CircleAvatar(
//                   backgroundImage: AssetImage(object.image),
//                 ),
//                 width: 50,
//                 height: 50
//             ),
//             Container(width: 20),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     object.name!,
//                     style:TEXT_NORMAL
//                   ),
//                   Container(height: 5),
//                   Text(
//                     "bader",
//                     maxLines: 2,
//                     style:TEXT_NORMAL
//                   ),
//                   Container(height: 15),
//                   Divider(color: Colors.grey[300], height: 0),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// class People {

//   late String image;
//   String? name;
//   String? email;
//   bool section = false;


//   People();

//   People.section(this.name, this.section);

// }
