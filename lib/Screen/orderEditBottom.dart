import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_kot/controller/controller.dart';

class OrderEditBottomSheet {
  // String? selected;
  ValueNotifier<bool> visible = ValueNotifier(false);
  // TextEditingController dect = TextEditingController();
  String dess = "";
  String completeText = '';
  String finalText = "";
  TextEditingController searchController = TextEditingController();
  showorderEditMoadlBottomsheet(
    Map map,
    BuildContext context,
    Size size,
    int index,
    // TextEditingController dec_ctrl,
    String? date,
  ) async {
    // dect.text = map["Cart_Description"].toString().trimLeft();
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
                                        map["Prod_Name"]
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
                                      "\u{20B9}${map["Cart_Rate"].toStringAsFixed(2)}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                            onTap: () async {
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback(
                                                      (_) async {
                                                await Provider.of<Controller>(
                                                        context,
                                                        listen: false)
                                                    .setQty(1.0, index, "dec");

                                                // await Provider.of<Controller>(context,
                                                //         listen: false)
                                                //     .updateCart2(
                                                //   context,
                                                //   map,
                                                //   0,
                                                //   double.parse(value.qty[index].text),
                                                // );

                                                // Provider.of<Controller>(context,
                                                //         listen: false)
                                                //     .viewCart(
                                                //   context,
                                                // );
                                              });
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
                                              // Provider.of<Controller>(context,
                                              //         listen: false)
                                              //     .updateCart(
                                              //         context,
                                              //         map,
                                              //         date!,
                                              //         value.customerId.toString(),
                                              //         double.parse(val),
                                              //         index,
                                              //         "from cart",
                                              //         0,
                                              //         "");

                                              // Provider.of<Controller>(context,
                                              //         listen: false)
                                              //     .viewCart(
                                              //   context,
                                              // );
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
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback(
                                                      (_) async {
                                                await Provider.of<Controller>(
                                                        context,
                                                        listen: false)
                                                    .setQty(1.0, index, "inc");

                                                // await Provider.of<Controller>(context,
                                                //         listen: false)
                                                //     .updateCart2(
                                                //   context,
                                                //   map,
                                                //   0,
                                                //   double.parse(value.qty[index].text),
                                                // );

                                                // Provider.of<Controller>(context,
                                                //         listen: false)
                                                //     .viewCart(
                                                //   context,
                                                // );
                                              });
                                            },
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.green,
                                            )),
                                      ],
                                    ),
                                    // Spacer(),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 8, bottom: 4, top: 4),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 300,
                                      child: StatefulBuilder(
                                        builder: (BuildContext context,
                                                void Function(void Function())
                                                    setState) =>
                                            Autocomplete<String>(
                                                initialValue: TextEditingValue(
                                                    text:
                                                        map["Cart_Description"]
                                                            .toString()
                                                            .trimLeft()),
                                                optionsBuilder:
                                                    (TextEditingValue
                                                        textEditingValue) {
                                                  if (textEditingValue
                                                      .text.isEmpty) {
                                                    return value.suggestions;
                                                  }
                                                  return value.suggestions
                                                      .where((suggst) => suggst
                                                          .toLowerCase()
                                                          .contains(
                                                              textEditingValue
                                                                  .text
                                                                  .toLowerCase()));
                                                },
                                                optionsViewBuilder: (context,
                                                    onSelected, options) {
                                                  return Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Material(
                                                      elevation: 4.0,
                                                      child: Container(
                                                        width:
                                                            300, // Set the width of the options here
                                                        child: ListView.builder(
                                                          shrinkWrap: true,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          itemCount:
                                                              options.length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            final String
                                                                option = options
                                                                    .elementAt(
                                                                        index);

                                                            return GestureDetector(
                                                              onTap: () {
                                                                onSelected(
                                                                    option);
                                                              },
                                                              child: ListTile(
                                                                title: Text(
                                                                    option),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                onSelected: (suggestion) {
                                                  // desss = suggestion;
                                                  // print(
                                                  //     "auto-----------$desss");
                                                  // // handle user selection of a country
                                                  setState(() {
                                                    searchController.clear();
                                                    searchController.text =
                                                        suggestion;
                                                    searchController.selection =
                                                        TextSelection
                                                            .fromPosition(
                                                      TextPosition(
                                                          offset: suggestion
                                                              .length),
                                                    );

                                                    finalText = suggestion;
                                                    print(
                                                        "Complete text: $finalText");
                                                    print(
                                                        "Saving text: $finalText");
                                                  });
                                                  // print(
                                                  //     "Complete text: $newText");
                                                  // print(
                                                  //     "saving text----$finalText");
                                                },
                                                fieldViewBuilder: (context,
                                                    searchController,
                                                    focusNode,
                                                    onEditingComplete) {
                                                  return TextField(
                                                    controller:
                                                        searchController,
                                                    focusNode: focusNode,
                                                    onChanged: (text) {
                                                      setState(() {
                                                        completeText = text;
                                                        finalText = text;
                                                      });
                                                      print(
                                                          "Text in the field: $completeText");
                                                      print(
                                                          "Text in finalText: $finalText");
                                                    },
                                                    decoration: InputDecoration(
                                                      // prefixIcon: Icon(
                                                      //   Icons.search,
                                                      //   color: Colors.black,
                                                      // ),
                                                      suffixIcon: IconButton(
                                                        icon:
                                                            Icon(Icons.cancel),
                                                        onPressed: () {
                                                          searchController
                                                              .clear();
                                                          completeText = "";
                                                          finalText = "";
                                                        },
                                                      ),
                                                      hintText: "Type Here...",
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   width: 180,
                                    //   child: TextFormField(
                                    //     controller: dect,
                                    //   ),
                                    // ),
                                    // Text(
                                    //   // "cart rate",
                                    //   "${map["Cart_Description"].toString().trimLeft()}",
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.bold,
                                    //       fontSize: 16),
                                    // ),
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
                                      child: ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white),
                                          onPressed: () async {
                                            // WidgetsBinding.instance
                                            //     .addPostFrameCallback(
                                            //         (_) async {
                                              await Provider.of<Controller>(
                                                      context,
                                                      listen: false)
                                                  .updateCart2(
                                                context,
                                                map,
                                                0,
                                                // newText,
                                                finalText,
                                                // completeText,
                                                // dess,
                                                // dect.text,
                                                // value.descr[index].text,
                                                double.parse(
                                                    value.qty[index].text),
                                              );
                                              await Provider.of<Controller>(
                                                      context,
                                                      listen: false)
                                                  .viewCart(
                                                context,
                                              );
                                            // });
                                            Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop(false);
                                          },
                                          label: Text("Update")),
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
