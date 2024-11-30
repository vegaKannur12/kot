import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_kot/Screen/home.dart';
import 'package:restaurent_kot/controller/controller.dart';

class AddressAddBottomSheet {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String finalText = "";
  showaddressAddMoadlBottomsheet(
    BuildContext context,
    Size size,
  ) async {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Consumer<Controller>(
            builder: (context, value, child) {
              return Container(
                // height: size.height * 0.96,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize:MainAxisSize.min ,
                      // spacing: 5,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {
                                  nameController.clear();
                                  phoneController.clear();
                                  addressController.clear();
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.close, color: Colors.black)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "ADD ADDRESS",
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
                              left: 20, right: 20, bottom: 20),
                          child: Divider(
                            thickness: 2,
                          ),
                        ),
                        StatefulBuilder(
                          builder: (BuildContext context,
                                  void Function(void Function()) setState) =>
                              Autocomplete<Map<String, dynamic>>(
                            optionsBuilder:
                                (TextEditingValue textEditingValue) async {

                                  print("valueeeeee${textEditingValue.text}");
                              // if (value.length >= 4) {

                              // if (textEditingValue.text.isNotEmpty) {
                                //   return value
                                //       .listShopper; // Return all items if input is empty
                                // }
                                // else{
                                await Provider.of<Controller>(context,
                                        listen: false)
                                    .getShopperList(context,
                                        textEditingValue.text.toString());
                                return value.listShopper.where((item) =>
                                    item['MOBILE']
                                        .toString()
                                        .startsWith(textEditingValue.text));
                              // }
                            },
                            displayStringForOption: (item) =>
                                item['MOBILE'].toString(),
                            optionsViewBuilder: (context, onSelected, options) {
                              return Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10),),                             
                                  child: ListView.builder(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8),
                                    shrinkWrap: true,
                                    itemCount: options.length,
                                    itemBuilder: (context, index) {
                                      final Map<String, dynamic> option =
                                          options.elementAt(index);
                                      return ListTile(
                                        onTap: () => onSelected(option),
                                        title: Text(option['SHOPER_NAME']),
                                        subtitle:
                                            Text(option['MOBILE'].toString()),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                            onSelected: (suggestion) {
                              setState(() {
                                phoneController.text =
                                    suggestion['MOBILE'].toString();
                                finalText = suggestion['MOBILE'].toString();
                                nameController.text= suggestion['SHOPER_NAME'].toString();
                                addressController.text= suggestion['SHOPER_ADDRESS'].toString();
                              });
                            },
                            fieldViewBuilder: (context, phoneController,
                                focusNode, onEditingComplete) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 15.0, right: 15),
                                child: TextField(
                                  controller: phoneController,
                                  focusNode: focusNode,
                                  onChanged: (text) {
                                    setState(() {
                                      finalText = text;
                                      print("final text---$finalText");
                                    });
                                  },
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.cancel),
                                      onPressed: () {
                                        phoneController.clear();
                                        setState(() {
                                          finalText = "";
                                        });
                                      },
                                    ),
                                    hintText: "Type here...",
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        // Stack(
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.only(
                        //           left: 15.0, right: 15, top: 20),
                        //       child: TextFormField(
                        //         keyboardType: TextInputType.phone,
                        //         controller: phoneController,
                        //         onChanged: (value) async {
                        //           if (value.length >= 4) {
                        //             await Provider.of<Controller>(context,
                        //                     listen: false)
                        //                 .getShopperList(context, value);
                        //             await Provider.of<Controller>(context,
                        //                     listen: false)
                        //                 .filterListShopper(value);
                        //           }
                        //         },
                        //         decoration: InputDecoration(
                        //           prefixIcon:
                        //               Icon(Icons.phone_android_outlined),
                        //           labelText: "Phone",
                        //           border: OutlineInputBorder(
                        //             borderRadius: BorderRadius.circular(20.0),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     Consumer<Controller>(
                        //       builder: (context, value, child) {
                        //         if (value.filteredListShopper.isEmpty) {
                        //           return SizedBox
                        //               .shrink(); // No suggestions to display
                        //         }
                        //         return Positioned(
                        //           top:
                        //               75, // Position the dropdown below the TextFormField
                        //           left: 15,
                        //           right: 15,
                        //           child: Material(
                        //             elevation: 5,
                        //             borderRadius: BorderRadius.circular(10),
                        //             child: ConstrainedBox(
                        //               constraints: BoxConstraints(
                        //                 maxHeight:
                        //                     MediaQuery.of(context).size.height *
                        //                         0.3,
                        //               ),
                        //               child: ListView.builder(
                        //                 shrinkWrap: true,
                        //                 itemCount:
                        //                     value.filteredListShopper.length,
                        //                 itemBuilder: (context, index) {
                        //                   final item =
                        //                       value.filteredListShopper[index];
                        //                   return ListTile(
                        //                     title:
                        //                         Text(item['MOBILE'].toString()),
                        //                     onTap: () {
                        //                       phoneController.text =
                        //                           item['MOBILE'].toString();
                        //                       value.filteredListShopper = [];
                        //                     },
                        //                   );
                        //                 },
                        //               ),
                        //             ),
                        //           ),
                        //         );
                        //       },
                        //     ),
                        //   ],
                        // ),

                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 15),
                          child: TextFormField(
                            controller: nameController,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Enter Name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              labelText: "Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15, bottom: 18),
                          child: TextFormField(
                            maxLines: 3,
                            controller: addressController,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Enter Address';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.location_on_outlined),
                              // hintText: "Address",
                              labelText: "Address",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
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
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) {
                                              Size size =
                                                  MediaQuery.of(context).size;
                                              return AlertDialog(
                                                  content: Container(
                                                height: 100,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                        "Do you want to save ?"),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.03,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            gradient:
                                                                LinearGradient(
                                                              colors: [
                                                                Color.fromARGB(
                                                                    255,
                                                                    67,
                                                                    83,
                                                                    155),
                                                                Color.fromARGB(
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
                                                          child: ElevatedButton(
                                                            onPressed:
                                                                () async {
                                                              bool isSuccess = await Provider.of<
                                                                          Controller>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .finalSave(
                                                                      context,
                                                                      phoneController
                                                                          .text,
                                                                      nameController
                                                                          .text,
                                                                      addressController
                                                                          .text);

                                                              if (isSuccess) {
                                                                nameController
                                                                    .clear();
                                                                phoneController
                                                                    .clear();
                                                                addressController
                                                                    .clear();
                                                                showDialog(
                                                                  barrierDismissible:
                                                                      false,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    Size size =
                                                                        MediaQuery.of(context)
                                                                            .size;
                                                                    return AlertDialog(
                                                                      content:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            'KOT Saved..Want Print ?',
                                                                            style:
                                                                                TextStyle(color: Colors.green),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      actions: [
                                                                        Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            gradient:
                                                                                LinearGradient(
                                                                              colors: [
                                                                                Color.fromARGB(255, 67, 83, 155),
                                                                                Color.fromARGB(255, 50, 71, 190),
                                                                              ],
                                                                              begin: Alignment.centerLeft,
                                                                              end: Alignment.centerRight,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(30),
                                                                          ),
                                                                          child:
                                                                              ElevatedButton(
                                                                            style: ElevatedButton.styleFrom(
                                                                                backgroundColor: Colors.transparent,
                                                                                // backgroundColor:
                                                                                // ,
                                                                                textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                                                            child:
                                                                                const Text(
                                                                              'Yes',
                                                                              style: TextStyle(color: Colors.white),
                                                                            ),
                                                                            onPressed:
                                                                                () async {
                                                                              print("pirnt call");
                                                                              await Provider.of<Controller>(context, listen: false).finalPrint(context);
                                                                              await Provider.of<Controller>(context, listen: false).clearAllData(context);

                                                                              Navigator.of(context).push(
                                                                                PageRouteBuilder(
                                                                                  opaque: false,
                                                                                  pageBuilder: (_, __, ___) => HomePage(),
                                                                                ),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            gradient:
                                                                                LinearGradient(
                                                                              colors: [
                                                                                Color.fromARGB(255, 67, 83, 155),
                                                                                Color.fromARGB(255, 50, 71, 190),
                                                                              ],
                                                                              begin: Alignment.centerLeft,
                                                                              end: Alignment.centerRight,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(30),
                                                                          ),
                                                                          child:
                                                                              ElevatedButton(
                                                                            style: ElevatedButton.styleFrom(
                                                                                backgroundColor: Colors.transparent,
                                                                                // backgroundColor:
                                                                                // ,
                                                                                textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                                                            child:
                                                                                const Text(
                                                                              'No',
                                                                              style: TextStyle(color: Colors.white),
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.of(context).pop(true);
                                                                              Provider.of<Controller>(context, listen: false).clearAllData(context);

                                                                              Navigator.of(context).push(
                                                                                PageRouteBuilder(
                                                                                  opaque: false,
                                                                                  pageBuilder: (_, __, ___) => HomePage(),
                                                                                ),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                );
                                                              } else {
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                      title: Text(
                                                                          'Save Failed'),
                                                                      content: Text(
                                                                          'An error occurred while saving the KOT. Please try again.'),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child:
                                                                              Text('OK'),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                );
                                                              }
                                                            },
                                                            child: Text(
                                                              "Yes",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    // backgroundColor:
                                                                    // ,
                                                                    textStyle: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              size.width * 0.03,
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            gradient:
                                                                LinearGradient(
                                                              colors: [
                                                                Color.fromARGB(
                                                                    255,
                                                                    67,
                                                                    83,
                                                                    155),
                                                                Color.fromARGB(
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
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(
                                                              "No",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    // backgroundColor:
                                                                    //     P_Settings.salewaveColor,
                                                                    textStyle: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    // Text(
                                                    //   '$type  Placed!!!!',
                                                    //   style:
                                                    //       TextStyle(color: P_Settings.extracolor),
                                                    // ),
                                                    // Icon(
                                                    //   Icons.done,
                                                    //   color: Colors.green,
                                                    // )
                                                  ],
                                                ),
                                              ));
                                            });
                                      }
                                    },
                                    label: Text(
                                      'SAVE KOT',
                                      style: TextStyle(color: Colors.white),
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
}
