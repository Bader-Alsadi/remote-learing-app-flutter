// import 'package:flutter/material.dart';

// DynamicTable(
//   header: const Text("Person Table"),
//   rowsPerPage: 5,
//   showFirstLastButtons: true,
//   availableRowsPerPage: const [
//     5,
//     10,
//     15,
//     20,
//   ],// rowsPerPage should be in availableRowsPerPage
//   columnSpacing: 60,
//   showCheckboxColumn: true,
//   onRowsPerPageChanged: (value) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text("Rows Per Page Changed to $value"),
//       ),
//     );
//   },
//   rows: [DynamicTableDataRow(
//       index: index,
//       onSelectChanged: (value) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: value ?? false
//                 ? Text("Row Selected index:$index")
//                 : Text("Row Unselected index:$index"),
//           ),
//         );
//       },
//       cells:[
//         DynamicTableDataCell(value: "Name"),
//         DynamicTableDataCell(value: "101"),
//         DynamicTableDataCell(value: DateTime(2000, 2, 11)),
//         DynamicTableDataCell(value: "Male"),
//         DynamicTableDataCell(value:"Some other info about Aakash"),
//       ],
//     ),
//   ],
//   columns: [
//     DynamicTableDataColumn(
//         label: const Text("Name"),
//         onSort: (columnIndex, ascending) {},
//         dynamicTableInputType: DynamicTableTextInput()),
//     // dynamicTableInputType: DynamicTableInputType.text()),
//     DynamicTableDataColumn(
//         label: const Text("Unique ID"),
//         onSort: (columnIndex, ascending) {},
//         isEditable: false,
//         dynamicTableInputType: DynamicTableTextInput()),
//     // dynamicTableInputType: DynamicTableInputType.text()),
//     DynamicTableDataColumn(
//       label: const Text("Birth Date"),
//       onSort: (columnIndex, ascending) {},
//       // dynamicTableInputType: DynamicTableDateInput()
//       dynamicTableInputType: DynamicTableInputType.date(
//         context: context,
//         decoration: const InputDecoration(
//             hintText: "Select Birth Date",
//             suffixIcon: Icon(Icons.date_range),
//             border: OutlineInputBorder()),
//         initialDate: DateTime(1900),
//         lastDate: DateTime.now().add(
//           const Duration(days: 365),
//         ),
//       ),
//     ),
//     DynamicTableDataColumn(
//       label: const Text("Gender"),
//       // dynamicTableInputType: DynamicTableDropDownInput<String>()
//       dynamicTableInputType: DynamicTableInputType.dropDown<String>(
//         items: genderDropdown,
//         selectedItemBuilder: (context) {
//           return genderDropdown
//               .map((e) => Text(e))
//               .toList(growable: false);
//         },
//         decoration: const InputDecoration(
//             hintText: "Select Gender", border: OutlineInputBorder()),
//         displayBuilder: (value) =>
//             value ??
//             "", // How the string will be displayed in non editing mode
//         itemBuilder: (value) {
//           return DropdownMenuItem(
//             value: value,
//             child: Text(value),
//           );
//         },
//       ),
//     ),
//     DynamicTableDataColumn(
//         label: const Text("Other Info"),
//         onSort: (columnIndex, ascending) {},
//         dynamicTableInputType: DynamicTableInputType.text(
//           decoration: const InputDecoration(
//             hintText: "Enter Other Info",
//             border: OutlineInputBorder(),
//           ),
//           maxLines: 100,
//         )),
//   ],
// )