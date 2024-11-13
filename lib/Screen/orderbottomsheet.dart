import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_kot/controller/controller.dart';

class OrderBottomSheet {
  // String? selected;
  ValueNotifier<bool> visible = ValueNotifier(false);
  String desss = "";
  String completeText = '';
  String finalText = "";
  TextEditingController searchController = TextEditingController();
  showorderMoadlBottomsheet(
    List<Map<String, dynamic>> list,
    BuildContext context,
    Size size,
    int index,
    // TextEditingController dec_ctrl,
    String? date,
  ) async {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          print("param---$index--");

          return Consumer<Controller>(
            builder: (context, value, child) {
              return SingleChildScrollView(
                child: Container(
                  // height: size.height * 0.96,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: value.isLoading
                        ? SpinKitFadingCircle(color: Colors.black)
                        : Column(
                            // mainAxisSize:MainAxisSize.min ,
                            // spacing: 5,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.close,
                                          color: Colors.black)),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        list[index]["Product"]
                                            .toString()
                                            .trimLeft()
                                            .toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Divider(
                                      thickness: 2,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15, bottom: 18),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "\u{20B9} ${list[index]["SRATE"].toStringAsFixed(2)}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              value.response[index] = 0;

                                              Provider.of<Controller>(context,
                                                      listen: false)
                                                  .setQty(1.0, index, "dec");
                                            },
                                            child: Icon(
                                              Icons.remove,
                                              color: Colors.red,
                                            )),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 5,
                                              right: 5,
                                              top: 5,
                                              bottom: 5),
                                          width: size.width * 0.14,
                                          // height: size.height * 0.05,
                                          child: TextField(
                                            onTap: () {
                                              value.qty[index].selection =
                                                  TextSelection(
                                                      baseOffset: 0,
                                                      extentOffset: value
                                                          .qty[index]
                                                          .value
                                                          .text
                                                          .length);
                                            },
                                            onSubmitted: (val) {
                                              value.response[index] = 0;
                                              // Provider.of<Controller>(context,
                                              //         listen: false)
                                              // .updateCart(
                                              //         context,
                                              //         widget.list[index],
                                              //         date!,
                                              //         value.customerId.toString(),
                                              //         double.parse(val),
                                              //         index,
                                              //         "from itempage",
                                              //         0,
                                              //         widget.catId);
                                            },
                                            onChanged: (val) {
                                              value.response[index] = 0;
                                            },
                                            controller: value.qty[index],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600),
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.all(3),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: Colors
                                                        .grey), //<-- SEE HERE
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: Colors
                                                        .grey), //<-- SEE HERE
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                            onTap: () {
                                              value.response[index] = 0;
                                              Provider.of<Controller>(context,
                                                      listen: false)
                                                  .setQty(1.0, index, "inc");
                                            },
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.green,
                                            )),
                                      ],
                                    )
                                    // Spacer(),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15, bottom: 18),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Container(
                                    //     decoration: BoxDecoration(
                                    //         color: Colors.yellow,
                                    //         borderRadius:
                                    //             BorderRadius.circular(8)),
                                    //     width: size.width * 1 / 1.7,
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.all(8),
                                    //       child: Text(finalText,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,overflow: TextOverflow.ellipsis),),
                                    //     )),
                                    InkWell(
                                        onTap: () async {
                                          desss = "";
//                                           await showDialog(
//   barrierDismissible: false,
//   context: context,
//   builder: (context) {
//     return AlertDialog(
//       content: Container(
//         width: size.width * 0.8,
//         height: size.height * 0.8, // Set height to 80% of screen height
//         child: StatefulBuilder(
//           builder: (BuildContext context, void Function(void Function()) setState) {
//             return Column(
//               children: [
//                 TextField(
//                   controller: searchController,
//                   onChanged: (text) {
//                     setState(() {
//                       // Filter suggestions based on text input
//                       value.filteredSuggestions = value.suggestions
//                           .where((suggst) => suggst.toLowerCase().contains(text.toLowerCase()))
//                           .toList();
//                     });
//                   },
//                   decoration: InputDecoration(
//                     hintText: "Type Here...",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                     suffixIcon: IconButton(
//                       icon: Icon(Icons.cancel),
//                       onPressed: () {
//                         searchController.clear();
//                         setState(() {
//                           value.filteredSuggestions = value.suggestions; // Reset suggestions
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: value.suggestions.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       final suggestion = value.suggestions[index];
//                       return ListTile(
//                         title: Text(suggestion),
//                         onTap: () {
//                           setState(() {
//                             finalText = suggestion;
//                           });
//                           print("Selected text: $finalText");
//                           Navigator.of(context, rootNavigator: true).pop(); // Close dialog on selection
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//       actions: <Widget>[
//         ElevatedButton(
//           onPressed: () {
//             Navigator.of(context, rootNavigator: true).pop();
//           },
//           child: Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             // Handle OK action here
//             Navigator.of(context, rootNavigator: true).pop();
//           },
//           child: Text("Ok"),
//         ),
//       ],
//     );
//   },
// );
                                          await showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) {
                                              Size size =
                                                  MediaQuery.of(context).size;

                                              return Dialog(
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Container(
                                                  constraints: BoxConstraints(
                                                    maxHeight: size.height *
                                                        0.8, // Sets maximum height
                                                    maxWidth: size.width *
                                                        0.8, // Adjusts dialog width
                                                  ),
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  decoration: BoxDecoration(
                                                    // gradient: LinearGradient(
                                                    //   colors: [
                                                    //     Colors.blueAccent,
                                                    //     Colors.deepPurple
                                                    //   ],
                                                    //   begin: Alignment.topLeft,
                                                    //   end:
                                                    //       Alignment.bottomRight,
                                                    // ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Select Option",
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          IconButton(
                                                            icon: Icon(
                                                                Icons.close,
                                                                color: Colors
                                                                    .black),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context,
                                                                      rootNavigator:
                                                                          true)
                                                                  .pop();
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      Divider(
                                                          color:
                                                              Colors.black45),
                                                      SizedBox(height: 10),
                                                      SingleChildScrollView(
                                                        child: StatefulBuilder(
                                                          builder: (BuildContext
                                                                      context,
                                                                  void Function(
                                                                          void
                                                                              Function())
                                                                      setState) =>
                                                              Autocomplete<
                                                                  String>(
                                                            optionsBuilder:
                                                                (TextEditingValue
                                                                    textEditingValue) {
                                                              if (textEditingValue
                                                                  .text
                                                                  .isEmpty) {
                                                                return value
                                                                    .suggestions;
                                                              }
                                                              return value
                                                                  .suggestions
                                                                  .where((suggst) => suggst
                                                                      .toLowerCase()
                                                                      .contains(textEditingValue
                                                                          .text
                                                                          .toLowerCase()));
                                                            },
                                                            optionsViewBuilder:
                                                                (context,
                                                                    onSelected,
                                                                    options) {
                                                              return Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Material(
                                                                  elevation:
                                                                      4.0,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        size.width *
                                                                            0.5,
                                                                    child: ListView
                                                                        .builder(
                                                                      padding: EdgeInsets.symmetric(
                                                                          vertical:
                                                                              8),
                                                                      shrinkWrap:
                                                                          true,
                                                                      itemCount:
                                                                          options
                                                                              .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        final String
                                                                            option =
                                                                            options.elementAt(index);
                                                                        return Container(
                                                                          color:
                                                                              Colors.white,
                                                                          child:
                                                                              ListTile(
                                                                            onTap: () =>
                                                                                onSelected(option),
                                                                            title:
                                                                                Text(option),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            onSelected:
                                                                (suggestion) {
                                                              setState(() {
                                                                searchController
                                                                    .clear();
                                                                searchController
                                                                        .text =
                                                                    suggestion;
                                                                searchController
                                                                        .selection =
                                                                    TextSelection
                                                                        .fromPosition(
                                                                  TextPosition(
                                                                      offset: suggestion
                                                                          .length),
                                                                );
                                                                finalText =
                                                                    suggestion;
                                                              });
                                                            },
                                                            fieldViewBuilder: (context,
                                                                searchController,
                                                                focusNode,
                                                                onEditingComplete) {
                                                              return TextField(
                                                                controller:
                                                                    searchController,
                                                                focusNode:
                                                                    focusNode,
                                                                onChanged:
                                                                    (text) {
                                                                  setState(() {
                                                                    completeText =
                                                                        text;
                                                                    finalText =
                                                                        text;
                                                                  });
                                                                },
                                                                decoration:
                                                                    InputDecoration(
                                                                  suffixIcon:
                                                                      IconButton(
                                                                    icon: Icon(Icons
                                                                        .cancel),
                                                                    onPressed:
                                                                        () {
                                                                      searchController
                                                                          .clear();
                                                                      completeText =
                                                                          "";
                                                                      finalText =
                                                                          "";
                                                                    },
                                                                  ),
                                                                  hintText:
                                                                      "Type Here...",
                                                                  filled: true,
                                                                  fillColor:
                                                                      Colors
                                                                          .white,
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15.0),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 20),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              gradient:
                                                                  LinearGradient(
                                                                colors: [
                                                                  // Color.fromARGB(255, 253, 192, 123),
                                                                  // Color.fromARGB(255, 50, 71, 190),
                                                                  // Color.fromARGB(255, 48, 54, 90),
                                                                  // Colors.indigo,
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          67,
                                                                          83,
                                                                          155),
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          50,
                                                                          71,
                                                                          190),
                                                                ],
                                                                begin: Alignment
                                                                    .centerLeft,
                                                                end: Alignment
                                                                    .centerRight,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                            ),
                                                            child:
                                                                ElevatedButton(
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent, // Make button background transparent
                                                                shadowColor: Colors
                                                                    .transparent,
                                                              ),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context,
                                                                        rootNavigator:
                                                                            true)
                                                                    .pop();
                                                              },
                                                              child: Text(
                                                                'Cancel',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        18,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              gradient:
                                                                  LinearGradient(
                                                                colors: [
                                                                  // Color.fromARGB(255, 253, 192, 123),
                                                                  // Color.fromARGB(255, 50, 71, 190),
                                                                  // Color.fromARGB(255, 48, 54, 90),
                                                                  // Colors.indigo,
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          67,
                                                                          83,
                                                                          155),
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          50,
                                                                          71,
                                                                          190),
                                                                ],
                                                                begin: Alignment
                                                                    .centerLeft,
                                                                end: Alignment
                                                                    .centerRight,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                            ),
                                                            child:
                                                                ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context,
                                                                        rootNavigator:
                                                                            true)
                                                                    .pop();
                                                              },
                                                              child: Text(
                                                                "Ok",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        18,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent, // Make button background transparent
                                                                shadowColor: Colors
                                                                    .transparent,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );

                                          // await showDialog(
                                          //     barrierDismissible: false,
                                          //     context: context,
                                          //     builder: (context) {
                                          //       return AlertDialog(
                                          //         content: Container(
                                          //           width: size.width * 1 / 2,
                                          //           child: SizedBox(
                                          //             width: size.width * 1 / 2,
                                          //             child: StatefulBuilder(
                                          //               builder: (BuildContext
                                          //                           context,
                                          //                       void Function(
                                          //                               void
                                          //                                   Function())
                                          //                           setState) =>
                                          //                   Autocomplete<String>(optionsBuilder:
                                          //                       (TextEditingValue
                                          //                           textEditingValue) {
                                          //                 if (textEditingValue
                                          //                     .text.isEmpty) {
                                          //                   return value
                                          //                       .suggestions;
                                          //                 }
                                          //                 return value
                                          //                     .suggestions
                                          //                     .where((suggst) => suggst
                                          //                         .toLowerCase()
                                          //                         .contains(
                                          //                             textEditingValue
                                          //                                 .text
                                          //                                 .toLowerCase()));
                                          //               }, optionsViewBuilder:
                                          //                       (context,
                                          //                           onSelected,
                                          //                           options) {
                                          //                 return Align(
                                          //                   alignment: Alignment
                                          //                       .topLeft,
                                          //                   child: Material(
                                          //                     elevation: 4.0,
                                          //                     child: Container(
                                          //                       width:
                                          //                           300, // Set the width of the options here
                                          //                       child: ListView
                                          //                           .builder(
                                          //                         shrinkWrap:
                                          //                             true,
                                          //                         padding:
                                          //                             EdgeInsets
                                          //                                 .all(
                                          //                                     8.0),
                                          //                         itemCount:
                                          //                             options
                                          //                                 .length,
                                          //                         itemBuilder:
                                          //                             (BuildContext
                                          //                                     context,
                                          //                                 int index) {
                                          //                           final String
                                          //                               option =
                                          //                               options.elementAt(
                                          //                                   index);

                                          //                           return GestureDetector(
                                          //                             onTap:
                                          //                                 () {
                                          //                               onSelected(
                                          //                                   option);
                                          //                             },
                                          //                             child:
                                          //                                 ListTile(
                                          //                               title: Text(
                                          //                                   option),
                                          //                             ),
                                          //                           );
                                          //                         },
                                          //                       ),
                                          //                     ),
                                          //                   ),
                                          //                 );
                                          //               }, onSelected:
                                          //                       (suggestion) {
                                          //                 // desss = suggestion;
                                          //                 // print(
                                          //                 //     "auto-----------$desss");
                                          //                 // // handle user selection of a country
                                          //                 setState(() {
                                          //                   searchController
                                          //                       .clear();
                                          //                   searchController
                                          //                           .text =
                                          //                       suggestion;
                                          //                   searchController
                                          //                           .selection =
                                          //                       TextSelection
                                          //                           .fromPosition(
                                          //                     TextPosition(
                                          //                         offset:
                                          //                             suggestion
                                          //                                 .length),
                                          //                   );

                                          //                   finalText =
                                          //                       suggestion;
                                          //                   print(
                                          //                       "Complete text: $finalText");
                                          //                   print(
                                          //                       "Saving text: $finalText");
                                          //                 });
                                          //                 // print(
                                          //                 //     "Complete text: $newText");
                                          //                 // print(
                                          //                 //     "saving text----$finalText");
                                          //               }, fieldViewBuilder: (context,
                                          //                       searchController,
                                          //                       focusNode,
                                          //                       onEditingComplete) {
                                          //                 return TextField(
                                          //                   controller:
                                          //                       searchController,
                                          //                   focusNode:
                                          //                       focusNode,
                                          //                   onChanged: (text) {
                                          //                     setState(() {
                                          //                       completeText =
                                          //                           text;
                                          //                       finalText =
                                          //                           text;
                                          //                     });
                                          //                     print(
                                          //                         "Text in the field: $completeText");
                                          //                     print(
                                          //                         "Text in finalText: $finalText");
                                          //                   },
                                          //                   decoration:
                                          //                       InputDecoration(
                                          //                     // prefixIcon: Icon(
                                          //                     //   Icons.search,
                                          //                     //   color: Colors.black,
                                          //                     // ),
                                          //                     suffixIcon:
                                          //                         IconButton(
                                          //                       icon: Icon(Icons
                                          //                           .cancel),
                                          //                       onPressed: () {
                                          //                         searchController
                                          //                             .clear();
                                          //                         completeText =
                                          //                             "";
                                          //                         finalText =
                                          //                             "";
                                          //                       },
                                          //                     ),
                                          //                     hintText:
                                          //                         "Type Here...",
                                          //                     border:
                                          //                         OutlineInputBorder(
                                          //                       borderRadius:
                                          //                           BorderRadius
                                          //                               .circular(
                                          //                                   20.0),
                                          //                     ),
                                          //                   ),
                                          //                 );
                                          //               }),
                                          //             ),
                                          //           ),
                                          //         ),
                                          //         actions: <Widget>[
                                          //           ElevatedButton(
                                          //               onPressed: () {
                                          //                 Navigator.of(context,
                                          //                         rootNavigator:
                                          //                             true)
                                          //                     .pop(false);
                                          //               },
                                          //               child: Text('Cancel')),
                                          //           ElevatedButton(
                                          //               onPressed: () {
                                          //                 //          Provider.of<Controller>(context,
                                          //                 //     listen: false)
                                          //                 // .setDescr(value.descr[index].text.toString(),index);
                                          //                 Navigator.of(context,
                                          //                         rootNavigator:
                                          //                             true)
                                          //                     .pop(false);
                                          //               },
                                          //               child: Text("Ok"))
                                          //         ],
                                          //       );
                                          //     });
                                        },
                                        child: Row(
                                          children: [
                                            SizedBox(
                                                height: 25,
                                                width: 18,
                                                child: Icon(Icons.add)
                                                // Image.asset(
                                                //   "assets/instructions.png",
                                                //   fit: BoxFit.contain,
                                                //   width: 300,
                                                //   height: 300,
                                                // ),
                                                ),
                                            Text(
                                              " Instructions",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15, bottom: 18),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: size.width * 0.4,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color.fromARGB(255, 67, 83, 155),
                                            Color.fromARGB(255, 50, 71, 190),
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                          ),
                                          onPressed: value.response[index] > 0
                                              ? null
                                              : () {
                                                  Provider.of<Controller>(
                                                          context,
                                                          listen: false)
                                                      .updateCart(
                                                    context,
                                                    list[index],
                                                    date!,
                                                    double.parse(
                                                        value.qty[index].text),
                                                    finalText,
                                                    // completeText,
                                                    // desss,
                                                    // dec_ctrl.text,
                                                    // value.descr[index].text,
                                                    index,
                                                    "from itempage",
                                                    0,
                                                  );
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop(false);
                                                },
                                          // icon: value.response[index] > 0
                                          //     ? Icon(Icons.done)
                                          //     : Icon(Icons.shopping_cart),
                                          label: value.isAdded[index]
                                              ? SpinKitThreeInOut(
                                                  color: Colors.white,
                                                  size: 12,
                                                )
                                              : value.response[index] > 0
                                                  ? Text(
                                                      "Added",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )
                                                  : Text(
                                                      "ADD",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              );
            },
          );
        });
  }

  //////////////////
  // dropDownUnit(
  //   Size size,
  //   int index,
  // ) {
  //   double qty;
  //   return Consumer<Controller>(
  //     builder: (context, value, child) {
  //       // value.selectedunit_X001 = null;
  //       // selected=null;
  //       print(
  //           "value.prUnitSaleListData2----${value.prUnitSaleListData2}----$index--${value.selectedItem}");
  //       return Padding(
  //         padding: const EdgeInsets.only(left: 0, right: 0),
  //         child: Container(
  //           width: size.height * 0.2,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(10.0),
  //             border: Border.all(
  //                 color: P_Settings.blue1,
  //                 style: BorderStyle.solid,
  //                 width: 0.4),
  //           ),
  //           child: DropdownButton<String>(
  //             isExpanded: true,
  //             value: value.selectedItem,
  //             // isDense: true,
  //             hint: Padding(
  //               padding: const EdgeInsets.all(10.0),
  //               child: Text(value.frstDropDown.toString()),
  //               // child: Text(value.selectedunit_X001 == null
  //               //     ? "Select Unit"
  //               //     : value.selectedunit_X001.toString()),
  //             ),
  //             autofocus: true,
  //             underline: SizedBox(),
  //             elevation: 0,

  //             items: value.prUnitSaleListData2
  //                 .map((item) => DropdownMenuItem<String>(
  //                     value: item.toString(),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             item.toString(),
  //                             style: TextStyle(fontSize: 14),
  //                           ),
  //                         ),
  //                       ],
  //                     )))
  //                 .toList(),
  //             onChanged: (item) {
  //               print("clicked");
  //               if (item != null) {
  //                 Provider.of<Controller>(context, listen: false).fromDb =
  //                     false;
  //                 value.selectedItem = item;

  //                 value.setUnitOrder_X001(value.selectedItem!, index);
  //                 print("ratjhd------${value.calculatedRate}");
  //                 if (value.qty[index].text == null ||
  //                     value.qty[index].text.isEmpty) {
  //                   qty = 1;
  //                 } else {
  //                   qty = double.parse(value.qty[index].text);
  //                   // Provider.of<Controller>(context, listen: false)
  //                   //     .calculateOrderNetAmount(
  //                   //   index,
  //                   //   value.calculatedRate!,
  //                   //   double.parse(value.qty[index].text),
  //                   // );
  //                 }
  //               }
  //             },
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
