import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_kot/Screen/home.dart';
import 'package:restaurent_kot/controller/controller.dart';
import 'dart:io';

class KitchenDisp extends StatefulWidget {
  const KitchenDisp({super.key});

  @override
  State<KitchenDisp> createState() => _KitchenDispState();
}

class _KitchenDispState extends State<KitchenDisp> {
  String? date;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    date = DateFormat('dd-MMM-yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Consumer<Controller>(
          builder: (BuildContext context, Controller value, Widget? child) =>
              Text(
            "KitchenDisplay",

            ///value.cartItems.length
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 69, 79, 134),
      ),
      body: Consumer<Controller>(builder: (context, value, child) {
        if (value.isKOTLoading) {
          return SpinKitCircle(
            color: Colors.black,
          );
        } else if (value.kitchenKotItems.length == 0) {
          return Container(
              height: size.height * 0.7,
              child: Center(
                  child: Lottie.asset("assets/noitem.json",
                      height: size.height * 0.3)));
        } else if (value.isKOTLoading)
          return Expanded(
            child: Align(
              alignment: Alignment.center,
              child: SpinKitCircle(
                color: Colors.black,
              ),
            ),
          );
        else {
          // final groupedData = groupByTable(value.kitchenKotItems);
          return ListView.builder(
            itemCount: value.groupedData.keys.length,
            itemBuilder: (context, tableIndex) {
              final tableNo = value.groupedData.keys.elementAt(tableIndex);
              final items = value.groupedData[tableNo]!;
              print("itemssssss= $items");
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Table No Heading
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Table: $tableNo",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.greenAccent,
                        ),
                        constraints: BoxConstraints(
                            minWidth: size.width * 0.2, maxHeight: 50),
                        child: FittedBox(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors
                                  .transparent, // Make button background transparent
                              shadowColor: Colors.transparent,
                            ),
                            onPressed: () {},
                            child: Text("CALL"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Items for this table
                  ...items.map((item) {
                    return Container(
                        decoration: BoxDecoration(
                            border: Border.symmetric(
                                horizontal: BorderSide(color: Colors.black38))),
                        child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(children: [
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                      flex: 3,
                                      child: Text(
                                        // "product name",
                                        "${item['Kot_No']}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      )),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: item['isCallDisabled']
                                                  ? Color.fromARGB(
                                                      255, 91, 94, 90)
                                                  : Colors.green),
                                          constraints: BoxConstraints(
                                              minWidth: size.width * 0.2,
                                              maxHeight: 50),
                                          child: FittedBox(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors
                                                    .transparent, // Make button background transparent
                                                shadowColor: Colors.transparent,
                                              ),
                                              onPressed: item['isCallDisabled']
                                                  ? null // Disable the button if true
                                                  : () async {
                                                      setState(() {
                                                        item['isCallDisabled'] =
                                                            true; // Disable button
                                                      });
                                                      print(
                                                          "alert ${item['Kot_No']}");
                                                      // await Provider.of<
                                                      //             Controller>(
                                                      //         context,
                                                      //         listen: false)
                                                      //     .showReminderNotification(
                                                      //         'KOT : ${item['Kot_No']} ',
                                                      //         '${item['ITEM']} is prepared..');
                                                    },
                                              child: Text("CALL"),
                                            ).animate()
                                                .fade(duration: 300.ms)
                                                .scale(),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: Color.fromARGB(
                                                255, 243, 225, 170),
                                          ),
                                          constraints: BoxConstraints(
                                            minWidth: size.width * 0.2,
                                            maxHeight: 50,
                                          ),
                                          child: FittedBox(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors
                                                    .transparent, // Make button background transparent
                                                shadowColor: Colors.transparent,
                                              ),
                                              onPressed: () {},
                                              child: Text("COOKED"),
                                            )
                                                .animate()
                                                .fade(duration: 300.ms)
                                                .scale(),
                                          ),
                                        ),
                                      ]),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Row(
                                      children: [
                                        Text(
                                          // "product name",
                                          "${item['ITEM']}   ( ${item['qty']} )",
                                          style: TextStyle(
                                              fontSize: 17,
                                              // fontWeight: FontWeight.bold,
                                              color: const Color.fromARGB(
                                                  255, 2, 131, 236)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Flexible(
                                  //     child: Text(
                                  //   // "product name",
                                  //   "( ${item['qty']} )",
                                  //   style: TextStyle(
                                  //       fontSize: 17,
                                  //       // fontWeight: FontWeight.bold,
                                  //       color: const Color.fromARGB(
                                  //           255, 2, 131, 236)),
                                  // )),
                                ],
                              ),
                            ])));
                  }),
                ],
              );
            },
          );
        }
      }),
    );
  }
}

Future<bool> _onBackPressed(BuildContext context) async {
  return await showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        // title: const Text('AlertDialog Title'),
        content: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ListBody(
            children: const <Widget>[
              Text('Do you want to exit from this app'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              exit(0);
            },
          ),
        ],
      );
    },
  );
}
