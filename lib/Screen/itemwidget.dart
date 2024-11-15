// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:intl/intl.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import 'package:restaurent_kot/Screen/cartpage.dart';
// import 'package:restaurent_kot/Screen/orderbottomsheet.dart';
// import 'package:restaurent_kot/components/custom_snackbar.dart';
// import 'package:restaurent_kot/components/sizeScaling.dart';
// import 'package:restaurent_kot/controller/controller.dart';
// import 'package:restaurent_kot/db_helper.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:responsive_grid_list/responsive_grid_list.dart';

// class ItemWidget extends StatefulWidget {
//   List<Map<String, dynamic>> list;
//   String catId;
//   ItemWidget({required this.list, required this.catId});

//   @override
//   State<ItemWidget> createState() => _ItemWidgetState();
// }

// class _ItemWidgetState extends State<ItemWidget> {
//   TextEditingController decriptn_cntrlr = TextEditingController();
//   String? date;
//   OrderBottomSheet cocosheet = OrderBottomSheet();
//   @override
//   void initState() {
//     // TODO: implement initState

//     super.initState();

//     date = DateFormat('dd-MMM-yyyy').format(DateTime.now());
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     print(widget.list);
//     return Consumer<Controller>(
//       builder: (context, value, child) => Expanded(
//           child: widget.list.length == 0
//               ? Container(
//                   height: size.height * 0.7,
//                   child: Center(
//                       child: Lottie.asset("assets/noitem.json",
//                           height: size.height * 0.3)))
//               : ResponsiveGridList(
//                   horizontalGridSpacing: 0,
//                   minItemWidth: size.width / 1.2, //300
//                   minItemsPerRow: 1,
//                   // maxItemsPerRow: 2,
//                   children: List.generate(widget.list.length, (index) {
//                     return Padding(
//                         padding: const EdgeInsets.only(left: 8, right: 8,),
//                         child: Container(
//               //             decoration: BoxDecoration(
//               // border: Border.symmetric(
//               //     horizontal: BorderSide(color: Colors.black38))),
//                           // color:
//                           //     // value.response[index] > 0
//                           //     //     ? Colors.lightGreen
//                           //     //     :
//                           //     Colors.white,
//                           child: Column(mainAxisSize: MainAxisSize.min,
//                             children: [
//                               ListTile(
//                                 onTap: () {
//                                   cocosheet.showorderMoadlBottomsheet(widget.list,
//                                       context, size, index, date);
//                                   // await showDialog(
//                                   //     context: context,
//                                   //     builder: (context) {
//                                   //       return AlertDialog(
//                                   //         content: Container(
//                                   //           height: 200,
//                                   //           decoration: BoxDecoration(
//                                   //               color: Colors.green[20],
//                                   //               borderRadius:
//                                   //                   BorderRadius.circular(13)),
//                                   //           padding: EdgeInsets.all(5),
//                                   //           child: Column(
//                                   //             children: [
//                                   //               Row(
//                                   //                 children: [
//                                   //                   Text(
//                                   //                     widget.list[index]["Product"]
//                                   //                         .toString()
//                                   //                         .toUpperCase(),
//                                   //                     maxLines: 2,
//                                   //                     textScaleFactor:
//                                   //                         ScaleSize.textScaleFactor(
//                                   //                             context),
//                                   //                     style: TextStyle(
//                                   //                         fontWeight:
//                                   //                             FontWeight.bold,
//                                   //                         fontSize: 18,
//                                   //                         color: Color.fromARGB(
//                                   //                             255, 104, 40, 35)
//                                   //                         // color: Theme.of(context).primaryColor
//                                   //                         ),
//                                   //                   ),
//                                   //                 ],
//                                   //               ),
//                                   //               SizedBox(
//                                   //                 height: 15,
//                                   //               ),
//                                   //               Row(
//                                   //                 mainAxisAlignment:
//                                   //                     MainAxisAlignment
//                                   //                         .spaceBetween,
//                                   //                 children: [
//                                   //                   // Text("Rs : "),
//                                   //                   Container(
//                                   //                     decoration: BoxDecoration(
//                                   //                       borderRadius:
//                                   //                           BorderRadius.circular(
//                                   //                               10),
//                                   //                       color: Colors.yellow,
//                                   //                     ),
//                                   //                     child: Padding(
//                                   //                       padding:
//                                   //                           const EdgeInsets.only(
//                                   //                               left: 8.0,
//                                   //                               right: 8,
//                                   //                               bottom: 4,
//                                   //                               top: 4),
//                                   //                       child: Text(
//                                   //                         "\u{20B9}${widget.list[index]["SRATE"].toStringAsFixed(2)}",
//                                   //                         style: TextStyle(
//                                   //                             fontWeight:
//                                   //                                 FontWeight.bold,
//                                   //                             fontSize: 16),
//                                   //                       ),
//                                   //                     ),
//                                   //                   ),
//                                   //                   Row(
//                                   //                     children: [
//                                   //                       InkWell(
//                                   //                           onTap: () {
//                                   //                             value.response[
//                                   //                                 index] = 0;
                              
//                                   //                             Provider.of<Controller>(
//                                   //                                     context,
//                                   //                                     listen: false)
//                                   //                                 .setQty(1.0,
//                                   //                                     index, "dec");
//                                   //                           },
//                                   //                           child: Icon(
//                                   //                             Icons.remove,
//                                   //                             color: Colors.red,
//                                   //                           )),
//                                   //                       Container(
//                                   //                         margin: EdgeInsets.only(
//                                   //                             left: 7, right: 7),
//                                   //                         width: size.width * 0.14,
//                                   //                         height:
//                                   //                             size.height * 0.05,
//                                   //                         child: TextField(
//                                   //                           onTap: () {
//                                   //                             value.qty[index]
//                                   //                                     .selection =
//                                   //                                 TextSelection(
//                                   //                                     baseOffset: 0,
//                                   //                                     extentOffset: value
//                                   //                                         .qty[
//                                   //                                             index]
//                                   //                                         .value
//                                   //                                         .text
//                                   //                                         .length);
//                                   //                           },
//                                   //                           onSubmitted: (val) {
//                                   //                             value.response[
//                                   //                                 index] = 0;
//                                   //                             // Provider.of<Controller>(context,
//                                   //                             //         listen: false)
//                                   //                             // .updateCart(
//                                   //                             //         context,
//                                   //                             //         widget.list[index],
//                                   //                             //         date!,
//                                   //                             //         value.customerId.toString(),
//                                   //                             //         double.parse(val),
//                                   //                             //         index,
//                                   //                             //         "from itempage",
//                                   //                             //         0,
//                                   //                             //         widget.catId);
//                                   //                           },
//                                   //                           onChanged: (val) {
//                                   //                             value.response[
//                                   //                                 index] = 0;
//                                   //                           },
//                                   //                           controller:
//                                   //                               value.qty[index],
//                                   //                           textAlign:
//                                   //                               TextAlign.center,
//                                   //                           style: TextStyle(
//                                   //                               color: Colors.black,
//                                   //                               fontSize: 17,
//                                   //                               fontWeight:
//                                   //                                   FontWeight
//                                   //                                       .w600),
//                                   //                           decoration:
//                                   //                               InputDecoration(
//                                   //                             contentPadding:
//                                   //                                 EdgeInsets.all(3),
//                                   //                             enabledBorder:
//                                   //                                 OutlineInputBorder(
//                                   //                               borderSide: BorderSide(
//                                   //                                   width: 1,
//                                   //                                   color: Colors
//                                   //                                       .grey), //<-- SEE HERE
//                                   //                             ),
//                                   //                             focusedBorder:
//                                   //                                 OutlineInputBorder(
//                                   //                               borderSide: BorderSide(
//                                   //                                   width: 1,
//                                   //                                   color: Colors
//                                   //                                       .grey), //<-- SEE HERE
//                                   //                             ),
//                                   //                           ),
//                                   //                         ),
//                                   //                       ),
//                                   //                       InkWell(
//                                   //                           onTap: () {
//                                   //                             value.response[
//                                   //                                 index] = 0;
//                                   //                             Provider.of<Controller>(
//                                   //                                     context,
//                                   //                                     listen: false)
//                                   //                                 .setQty(1.0,
//                                   //                                     index, "inc");
//                                   //                           },
//                                   //                           child: Icon(
//                                   //                             Icons.add,
//                                   //                             color: Colors.green,
//                                   //                           )),
//                                   //                     ],
//                                   //                   )
//                                   //                 ],
//                                   //               ),
//                                   //               SizedBox(
//                                   //                 height: 10,
//                                   //               ),
//                                   //               Row(
//                                   //                 mainAxisAlignment:
//                                   //                     MainAxisAlignment
//                                   //                         .spaceBetween,
//                                   //                 children: [
//                                   //                   InkWell(
//                                   //                       onTap: () async {
//                                   //                         await showDialog(
//                                   //                             context: context,
//                                   //                             builder: (context) {
//                                   //                               return AlertDialog(
//                                   //                                 content:
//                                   //                                     TextField(
//                                   //                                   controller:
//                                   //                                       decriptn_cntrlr,
//                                   //                                   maxLines: 3,
//                                   //                                   style: TextStyle(
//                                   //                                       fontWeight:
//                                   //                                           FontWeight
//                                   //                                               .bold,
//                                   //                                       fontSize:
//                                   //                                           16),
//                                   //                                 ),
//                                   //                                 actions: <Widget>[
//                                   //                                   ElevatedButton(
//                                   //                                       onPressed:
//                                   //                                           () {
//                                   //                                         Navigator.of(
//                                   //                                                 context,
//                                   //                                                 rootNavigator: true)
//                                   //                                             .pop(false);
//                                   //                                       },
//                                   //                                       child: Text(
//                                   //                                           'Cancel')),
//                                   //                                   ElevatedButton(
//                                   //                                       onPressed:
//                                   //                                           () {},
//                                   //                                       child: Text(
//                                   //                                           "Save"))
//                                   //                                 ],
//                                   //                               );
//                                   //                             });
//                                   //                       },
//                                   //                       child: Row(
//                                   //                         children: [
//                                   //                           SizedBox(
//                                   //                             height: 25,
//                                   //                             width: 18,
//                                   //                             child: Image.asset(
//                                   //                               "assets/instructions.png",
//                                   //                               fit: BoxFit.contain,
//                                   //                               width: 300,
//                                   //                               height: 300,
//                                   //                             ),
//                                   //                           ),
//                                   //                           Text(
//                                   //                             "Add Instructions",
//                                   //                             style: TextStyle(
//                                   //                                 color:
//                                   //                                     Colors.red),
//                                   //                           ),
//                                   //                         ],
//                                   //                       )),
//                                   //                   // widget.list[index]["Pkg"] == null ||
//                                   //                   //       widget.list[index]["Pkg"] == ""
//                                   //                   //   ? Container()
//                                   //                   //   : Container(
//                                   //                   //       decoration: BoxDecoration(
//                                   //                   //         color: Color.fromARGB(
//                                   //                   //             255, 235, 234, 234),
//                                   //                   //         borderRadius:
//                                   //                   //             BorderRadius.circular(10),
//                                   //                   //         // border: Border.all(
//                                   //                   //         //     color: Colors.red)
//                                   //                   //       ),
//                                   //                   //       child: Padding(
//                                   //                   //         padding: const EdgeInsets.only(
//                                   //                   //             left: 8.0,
//                                   //                   //             right: 8,
//                                   //                   //             bottom: 4,
//                                   //                   //             top: 4),
//                                   //                   //         child: Text(
//                                   //                   //           "Pkg :${widget.list[index]["Pkg"]}",
//                                   //                   //           style: TextStyle(
//                                   //                   //               fontWeight: FontWeight.bold,
//                                   //                   //               color: Colors.black),
//                                   //                   //         ),
//                                   //                   //       ),
//                                   //                   //     ),
//                                   //                 ],
//                                   //               ),
//                                   //               SizedBox(
//                                   //                 height: 10,
//                                   //               ),
//                                   //               Row(
//                                   //                 children: [
//                                   //                   ElevatedButton.icon(
//                                   //                       style: ElevatedButton
//                                   //                           .styleFrom(
//                                   //                               backgroundColor:
//                                   //                                   Colors.white),
//                                   //                       onPressed: value.response[
//                                   //                                   index] >
//                                   //                               0
//                                   //                           ? null
//                                   //                           : () {
//                                   //                               Provider.of<Controller>(
//                                   //                                       context,
//                                   //                                       listen:
//                                   //                                           false)
//                                   //                                   .updateCart(
//                                   //                                 context,
//                                   //                                 widget
//                                   //                                     .list[index],
//                                   //                                 date!,
//                                   //                                 double.parse(value
//                                   //                                     .qty[index]
//                                   //                                     .text),
//                                   //                                 decriptn_cntrlr
//                                   //                                     .text,
//                                   //                                 index,
//                                   //                                 "from itempage",
//                                   //                                 0,
//                                   //                               );
//                                   //                               Navigator.of(
//                                   //                                       context,
//                                   //                                       rootNavigator:
//                                   //                                           true)
//                                   //                                   .pop(false);
//                                   //                             },
//                                   //                       icon: value.response[
//                                   //                                   index] >
//                                   //                               0
//                                   //                           ? Icon(Icons.done)
//                                   //                           : Icon(Icons
//                                   //                               .shopping_cart),
//                                   //                       label: value.isAdded[index]
//                                   //                           ? SpinKitThreeInOut(
//                                   //                               color: Colors.black,
//                                   //                               size: 12,
//                                   //                             )
//                                   //                           : value.response[
//                                   //                                       index] >
//                                   //                                   0
//                                   //                               ? Text("Added")
//                                   //                               : Text(
//                                   //                                   "Add to Bag")),
//                                   //                 ],
//                                   //               ),
//                                   //             ],
//                                   //           ),
//                                   //         ),
//                                   //         // actions: <Widget>[
//                                   //         //   ElevatedButton(
//                                   //         //       onPressed: () {
//                                   //         //         Navigator.of(context,
//                                   //         //                 rootNavigator: true)
//                                   //         //             .pop(false);
//                                   //         //       },
//                                   //         //       child: Text('Cancel')),
//                                   //         //   ElevatedButton(
//                                   //         //       onPressed: () {},
//                                   //         //       child: Text("Save"))
//                                   //         // ],
//                                   //       );
//                                   //     });
//                                 },
//                                 contentPadding:
//                                     EdgeInsets.only(left: 8.0, right: 0),
//                                 title: Text(
//                                   // "fgfhgfhgfjgfj hfghfgjhgfjgfjfgj gffyrytuyukj,j,j,n,n,,",
//                                   widget.list[index]["Product"]
//                                       .toString()
//                                       .trimLeft()
//                                       .toUpperCase(),
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 17,
//                                       color:
//                                           const Color.fromARGB(255, 3, 100, 180)),
//                                           overflow: TextOverflow.ellipsis,
//                                 ),
//                                 subtitle: Text(
//                                   "\u{20B9}${widget.list[index]["SRATE"].toStringAsFixed(2)}",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold, fontSize: 16),
//                                 ),
//                               ),Divider()
//                             ],
//                           ),
//                         ));
//                   })

//                   // ListView.builder(
//                   //     shrinkWrap: true,
//                   //     itemCount: widget.list.length,
//                   //     physics: ScrollPhysics(),
//                   //     itemBuilder: (context, index) {
//                   //       return Container(
//                   //         height: 60,
//                   //         decoration: BoxDecoration(
//                   //             color: Colors.green[20],
//                   //             borderRadius: BorderRadius.circular(13)),
//                   //         padding: EdgeInsets.all(15),
//                   //         child: Column(
//                   //           children: [
//                   //             Row(
//                   //               children: [
//                   //                 Text(
//                   //                   widget.list[index]["Product"]
//                   //                       .toString()
//                   //                       .toUpperCase(),overflow: TextOverflow.ellipsis,

//                   //                   textScaleFactor:
//                   //                       ScaleSize.textScaleFactor(context),
//                   //                   style: TextStyle(
//                   //                       fontWeight: FontWeight.bold,
//                   //                       fontSize: 18,
//                   //                       color: Color.fromARGB(255, 104, 40, 35)
//                   //                       // color: Theme.of(context).primaryColor
//                   //                       ),
//                   //                 ),
//                   //               ],
//                   //             ),
//                   //              SizedBox(width: size.width*0.2,
//                   //                child: Row(
//                   //                 children: [
//                   //                   Container(
//                   //                     decoration: BoxDecoration(
//                   //                       borderRadius: BorderRadius.circular(10),
//                   //                       color: Colors.yellow,
//                   //                     ),
//                   //                     child: Padding(
//                   //                       padding: const EdgeInsets.only(
//                   //                           left: 8.0, right: 8, bottom: 4, top: 4),
//                   //                       child: Text(
//                   //                         "\u{20B9}${widget.list[index]["SRATE"].toStringAsFixed(2)}",
//                   //                         style: TextStyle(
//                   //                             fontWeight: FontWeight.bold,
//                   //                             fontSize: 16),
//                   //                       ),
//                   //                     ),
//                   //                   )
//                   //                 ],
//                   //                                          ),
//                   //              ),

//                   //           ],
//                   //         ),
//                   //       );
//                   //     }
//                   )),
//     );
//   }

//   void onTextChanged(String value) {
//     // Your custom logic goes here
//     print('TextField value changed: $value');
//   }
//   // textfldchange(int index, Map<String, dynamic> list, String tablID,
//   //     String catId, String s, int i) {
//   //   Provider.of<Controller>(context, listen: false).addToBag(
//   //       context,
//   //       list,
//   //       date!,
//   //       tablID,
//   //       catId,
//   //       double.parse(val),
//   //       index,
//   //       s,
//   //       i);
//   // }
// }

// class MyBottomSheet extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Add Item to Cart',
//             style: TextStyle(
//               fontSize: 20.0,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 16.0),
//           // Add your item selection widgets here
//           ListTile(
//             title: Text('Item 1'),
//             onTap: () {
//               // Handle item selection
//               Navigator.pop(context); // Close the bottom sheet
//             },
//           ),
//           ListTile(
//             title: Text('Item 2'),
//             onTap: () {
//               // Handle item selection
//               Navigator.pop(context); // Close the bottom sheet
//             },
//           ),
//           // Add more items as needed
//         ],
//       ),
//     );
//   }
// }
