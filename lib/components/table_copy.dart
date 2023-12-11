// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import '../controller/controller.dart';

// class TableData extends StatefulWidget {
//   var decodd;
//   int index;
//   String keyVal;
//   double popuWidth;
//   int level;
//   TableData(
//       {required this.decodd,
//       required this.index,
//       required this.keyVal,
//       required this.popuWidth,
//       required this.level});

//   @override
//   State<TableData> createState() => _TableDataState();
// }

// class _TableDataState extends State<TableData> {
//   TextEditingController seacrh = TextEditingController();
//   String? key;
//   int _currentSortColumn = 0;
//   bool _isSortAsc = true;
//   // DetailedInfoSheet info = DetailedInfoSheet();
//   List<dynamic> mapTabledata = [];
//   List<String> tableColumn = [];
//   Map<String, dynamic> valueMap = {};
//   List<Map<dynamic, dynamic>> newMp = [];
//   List<Map<dynamic, dynamic>> filteredList = [];
//   List<dynamic> rowMap = [];
//   double? datatbleWidth;
//   final ScrollController _scrollController = ScrollController();
//   @override
//   void initState() {
//     print("shrinked   mapTabledata---${widget.decodd}");

//     super.initState();
//     if (widget.decodd != null) {
//       mapTabledata = json.decode(widget.decodd);
//     } else {
//       print("null");
//     }
//     rowMap = mapTabledata;
//     mapTabledata[0].forEach((key, value) {
//       tableColumn.add(key);
//     });

//     print("tablecolumn-----$tableColumn");
//     newMp.clear();
//     filteredList.clear();
//     calculateSum(mapTabledata, tableColumn);
//     rowMap.forEach((element) {
//       print("element-----$element");
//       newMp.add(element);
//       filteredList.add(element);
//     });
//     print("newMp---${newMp}");
//     // key = newMp[0].keys.toList().first;
//     // if (widget.keyVal != "0") {
//     //   int ele = int.parse(widget.keyVal) - 1;
//     //   key = newMp[0].keys.elementAt(ele);
//     // }
//   }

// //////////////////////////////////////////////////////////////////////////////
//   Widget build(BuildContext context) {
//     // FocusScope.of(context).requestFocus(FocusNode());

//     Size size = MediaQuery.of(context).size;
//     datatbleWidth = widget.popuWidth - 30;
//     print(
//         "screen width-----${size.width}------datatble width-----$datatbleWidth");
//     return SingleChildScrollView(
//       // controller: _scrollController,
//       child: Container(
//         // height: size.height*0.6,
//         width: datatbleWidth,
//         child: DataTable(
          
//           showCheckboxColumn: false,
//           columnSpacing: 7,
//           headingRowHeight: 45,
//           dataRowHeight: 38,
//           horizontalMargin: 5,
        
//           headingRowColor: MaterialStateProperty.all(Colors.yellow),
//           columns: getColumns(
//             tableColumn,
//           ),
//           rows: getRowss(filteredList, seacrh),
//         ),
//       ),
//     );
//   }

//   ///////////////////////////////////////////////////
//   List<DataColumn> getColumns(
//     List<String> columns,
//   ) {
//     double colwidth = 0.0;
//     List<String> columnSplit = [];
//     List<DataColumn> datacolumnList = [];
//     print("columns --------${columns}");

//     for (int i = 0; i < columns.length; i++) {
//       columnSplit = columns[i].split('_');
//       String wid = columns[i].substring(3, 5);
//       print("columnsplit-------${wid}");
//       if (columns.length == 0) {
//         colwidth = (datatbleWidth! / columns.length);
//       } else {
//         colwidth = (datatbleWidth! * double.parse(wid) / 100);
//       }
//       colwidth = colwidth * 0.94;
//       datacolumnList.add(DataColumn(
//         label: ConstrainedBox(
//           constraints: BoxConstraints(minWidth: colwidth, maxWidth: colwidth),
//           child: Padding(
//             padding: EdgeInsets.all(0.0),
//             child: Text(columnSplit[1].toString(),
//                 style: TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black),
//                 textAlign: columnSplit[0][1] == "L"
//                     ? TextAlign.left
//                     : columnSplit[0][1] == "C"
//                         ? TextAlign.center
//                         : TextAlign.right),
//           ),
//         ),
//       ));
//     }
//     return datacolumnList;
//     // return columns.map((String column) {
//     //   return DataColumn(
//     //     label: ConstrainedBox(
//     //       constraints: BoxConstraints(minWidth: 90, maxWidth: 90),
//     //       child: Padding(
//     //         padding: EdgeInsets.all(0.0),
//     //         child: Text(column.toUpperCase(),
//     //             style: TextStyle(fontSize: 12), textAlign: TextAlign.right),
//     //       ),
//     //     ),
//     //   );
//     // }).toList();
//   }

//   ////////////////////////////////////////////////////////////////
//   List<DataRow> getRowss(
//       List<Map<dynamic, dynamic>> row, TextEditingController controller) {
//     print("rowjsjfkd-----$row");
//     List<DataRow> items = [];

//     var itemList = filteredList;
//     for (var r = 0; r < itemList.length; r++) {
//       items.add(DataRow(
//           onSelectChanged: (selected) {
//             // String val=
//             if (selected!) {
//               print("selected------${itemList[r]}");
//               String val = itemList[r].values.toList().first.toString();
//               print("val----$val");
//               Provider.of<Controller>(context, listen: false)
//                   .findLevelCriteria(context, widget.level, r, val);
//               // LevelReportDetails popup = LevelReportDetails();
//               // popup.viewData(context, itemList[r], r);
//             }
//           },
//           color: r == itemList.length - 1
//               ? controller.text == ""
//                   ? MaterialStateProperty.all(Colors.pink)
//                   : MaterialStateProperty.all(Colors.black)
//               : MaterialStateProperty.all(Colors.black),

//           //  r % 2 == 0
//           //     ? MaterialStateProperty.all(
//           //         Color.fromARGB(255, 194, 229, 238))
//           //     : MaterialStateProperty.all(
//           //         Color.fromARGB(255, 240, 173, 229)),
//           cells: getCelle(itemList[r])));
//     }
//     return items;

//     // return newMp.map((row) {
//     //   return DataRow(
//     //     cells: getCelle(row),
//     //   );
//     // }).toList();
//   }

//   //////////////////////////////////////////////////////////////
//   List<DataCell> getCelle(
//     Map<dynamic, dynamic> data,
//   ) {
//     String behv;
//     String colsName;

//     String? dval;
//     double colwidth = 0.0;
//     print("data--$data");
//     List<DataCell> datacell = [];
//     List<String> columnSplit = [];

//     print("data-------$data");
//     // String text = data.values.elementAt(0);
//     for (var i = 0; i < tableColumn.length; i++) {
//       data.forEach((key, value) {
//         if (tableColumn[i] == key) {
//           columnSplit = tableColumn[i].split('_');
//           String wid = tableColumn[i].substring(3, 5);
//           if (tableColumn.length == 0) {
//             colwidth = (datatbleWidth! / tableColumn.length);
//           } else {
//             colwidth = (datatbleWidth! * double.parse(wid) / 100);
//           }
//           colwidth = colwidth * 0.94;
//           print("key from datacell----$key");
//           String text = "";

//           // if (columnSplit[0][2] == "Y") {
//           //   if (columnSplit[0][0] == "I") {

//           //     dval = value.toString();

//           //     print("sjkhfjdf------$dval");
//           //   } else if (columnSplit[0][0] == "C") {
//           //     double d = double.parse(value);
//           //     dval = d.toStringAsFixed(2);
//           //   }else{
//           //     dval=value.toString();
//           //   }

//           //   print("dunduu----$dval");
//           // }

//           //  else {
//           //   if (value == null || value.isEmpty || value == " ") {
//           //     dval = value;
//           //   } else {
//           //     RegExp _numeric = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
//           //     bool isnum = _numeric.hasMatch(value);
//           //     print("isnum ----$isnum-----$_numeric");
//           //     if (isnum) {
//           //       double d = double.parse(value);
//           //       dval = d.toStringAsFixed(2);
//           //     } else {
//           //       dval = value;
//           //     }
//           //   }
//           // }

//           if (columnSplit[0][0] == "C") {
//             text = value.toStringAsFixed(2);
//           } else if (columnSplit[0][0] == "I") {
//             // text = "$value";
//             text = value.toString();
//           } else if (columnSplit[0][0] == "T") {
//             text = value.toString();
//             print("testtt----${text.runtimeType}");
//           } else if (columnSplit[0][0] == "D") {
//             text = value.toString();
//           }
//           datacell.add(
//             DataCell(
//               Container(
//                 constraints:
//                     BoxConstraints(minWidth: colwidth, maxWidth: colwidth),
//                 alignment: columnSplit[0][1] == "L"
//                     ? Alignment.centerLeft
//                     : columnSplit[0][1] == "C"
//                         ? Alignment.center
//                         : Alignment.centerRight,
//                 child: Padding(
//                   padding: EdgeInsets.all(0.0),
//                   child: Text(
//                     text.toString(),
//                     style: TextStyle(fontSize: 14, color: Colors.white),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         }
//       });
//     }
//     print(datacell.length);
//     return datacell;
//   }

//   /////////////////////////////////////////////////////////////////////
//   calculateSum(List<dynamic> element, List tableColumn) {
//     Map map = {};
//     final oCcy = new NumberFormat("#,##0.00", "en_US");

//     List columnSplit = [];
//     print("dynamic elemnt------$tableColumn");
//     double sum = 0.0;
//     int intsum = 0;

//     for (int i = 0; i < element.length; i++) {
//       element[i].forEach((k, value) {
//         List key = k.split("_");
//         print("element[i]---${key[0][2]}");

//         if (key[0][2] == "Y") {
//           if (key[0][0] == "C") {
//             sum = sum + value;
//             map[k] = sum;
//           } else if (key[0][0] == "I") {
//             print("value runtyme-${value.runtimeType}");
//             int d = value;
//             intsum = intsum + d;
//             // String d2 = intsum.toStringAsFixed(2);
//             map[k] = intsum;
//           }
//         } else {
//           print("map-ggg----${key}");
//           map[k] = " ";
//         }
//       });
//     }

//     element.add(map);

//     print("final clculate map------$map");
//   }

// ////////////////////////////////////////////////////////////////
// }
