import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_kot/Screen/addressAddBottomshet.dart';
import 'package:restaurent_kot/Screen/home.dart';
import 'package:restaurent_kot/Screen/orderEditBottom.dart';
import 'package:restaurent_kot/controller/controller.dart';
import 'dart:io';

class CartBag extends StatefulWidget {
  const CartBag({super.key});

  @override
  State<CartBag> createState() => _CartBagState();
}

class _CartBagState extends State<CartBag> {
  String? date;
  OrderEditBottomSheet cocosheet = OrderEditBottomSheet();
  AddressAddBottomSheet addressaddsheet = AddressAddBottomSheet();
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<Controller>(context, listen: false).getIDss();
      print(
          "sel table--${Provider.of<Controller>(context, listen: false).selTableMap}");
    });
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
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Consumer<Controller>(
          builder: (BuildContext context, Controller value, Widget? child) =>
              Text(
            "Your Order ( ${value.cart_id.toString()} )",

            ///value.cartItems.length
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          Consumer<Controller>(
            builder: (context, value, child) => Card(
              shape: const StadiumBorder(),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "${value.tabl_name.toString().toUpperCase()} ${value.room_nm.toString().toUpperCase() == "" || value.room_nm.toString().toUpperCase().isEmpty || value.room_nm.toString().toUpperCase() == "NULL" ? "" : "/ ${value.room_nm.toString().toUpperCase()}"}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
        backgroundColor: Color.fromARGB(255, 69, 79, 134),
      ),
      bottomNavigationBar: Provider.of<Controller>(context, listen: false)
              .cartItems
              .isEmpty
          ? Container()
          : Container(
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 67, 83, 155),
                    Color.fromARGB(255, 50, 71, 190),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Consumer<Controller>(
                builder:
                    (BuildContext context, Controller value, Widget? child) =>
                        InkWell(
                  onTap: () {
                    if (value.table_adrscollect == 0) {
                      showDirectsaveKot(context, "", "", "");
                    } else {
                      if (value.selTableMap!["MOBILE"].toString().isNotEmpty &&
                          value.selTableMap!["MOBILE"].toString() != "" &&
                          value.selTableMap!["MOBILE"]
                                      .toString()
                                      .toLowerCase() !=
                                  "null" &&
                              value.selTableMap!["SHOPER_NAME"].isNotEmpty &&
                          value.selTableMap!["SHOPER_NAME"].toString() != "" &&
                          value.selTableMap!["SHOPER_NAME"]
                                      .toString()
                                      .toLowerCase() !=
                                  "null"  &&
                              value.selTableMap!["SHOPER_ADDRESS"].isNotEmpty &&
                          value.selTableMap!["SHOPER_ADDRESS"].toString() != "" &&
                          value.selTableMap!["SHOPER_ADDRESS"]
                                      .toString()
                                      .toLowerCase() !=
                                  "null"  ) {
                        print('kot is pending in this table');
                        showDirectsaveKot(
                            context,
                            value.selTableMap!["MOBILE"].toString(),
                            value.selTableMap!["SHOPER_NAME"].toString(),
                            value.selTableMap!["SHOPER_ADDRESS"].toString());
                      } else {
                        print('New kot in this table ,pls add address');
                        addressaddsheet.showaddressAddMoadlBottomsheet(
                            context, size);
                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'SAVE KOT',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                        Text(
                          "${value.karttotal.toStringAsFixed(2)} \u{20B9} ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
      body: Consumer<Controller>(
        builder: (context, value, child) => value.isCartLoading
            ? Align(
                alignment: Alignment.center,
                child: SpinKitCircle(
                  color: Colors.black,
                ),
              )
            : value.cartItems.isEmpty
                ? Container(
                    height: size.height * 0.7,
                    child: Center(
                        child: Lottie.asset("assets/noitem.json",
                            height: size.height * 0.3)))
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.cartItems.length,
                    itemBuilder: (context, int index) {
                      // return cartItems(index, size, value.cartItems[index]);
                      return customCard(index, size, value.cartItems[index]);
                    },
                  ),
      ),
    );
  }

  Future<dynamic> showDirectsaveKot(
      BuildContext context, String ph, String nm, String ad) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          Size size = MediaQuery.of(context).size;

          // Future.delayed(Duration(seconds: 2), () {
          //   Navigator.of(context).pop(true);

          //   Navigator.of(context).push(
          //     PageRouteBuilder(
          //         opaque: false, // set to false
          //         pageBuilder: (_, __, ___) => Dashboard(
          //             type: "return from cartList",
          //             areaName: areaname)
          //         // OrderForm(widget.areaname,"return"),
          //         ),
          //   );
          // });
          return AlertDialog(
              content: Container(
            height: 100,
            child: Column(
              children: [
                Text("Do you want to save ?"),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
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
                      child: ElevatedButton(
                        onPressed: () async {
                          //add want print dialog
                          bool isSuccess = await Provider.of<Controller>(
                                  context,
                                  listen: false)
                              .finalSave(context, ph, nm, ad);
                          if (isSuccess) {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                Size size = MediaQuery.of(context).size;

                                // Future.delayed(
                                //     Duration(seconds: 3), () {
                                //   Navigator.of(context).pop(true);
                                //   Provider.of<Controller>(context,
                                //           listen: false)
                                //       .clearAllData(context);

                                //   Navigator.of(context).push(
                                //     PageRouteBuilder(
                                //       opaque: false,
                                //       pageBuilder: (_, __, ___) =>
                                //           HomePage(),
                                //     ),
                                //   );
                                // });
                                return AlertDialog(
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // InkWell(
                                      //   onLongPress: () {
                                      // print(
                                      //     "direct pirnt call");
                                      // List ll = [
                                      //   {
                                      //     "Cart_ID": 12,
                                      //     "Cart_date":
                                      //         "2024-08-01 00:00:00.0",
                                      //     "Cart_Salesman_ID":
                                      //         "VGMHD3",
                                      //     "Cart_Table_ID":
                                      //         "VGMHD8",
                                      //     "Cart_Room_ID": 15,
                                      //     "Cart_Guest_Info":
                                      //         "SIRISHA",
                                      //     "Cart_Qty": 1.0000,
                                      //     "Cart_Rate":
                                      //         100.0000,
                                      //     "It_Total":
                                      //         100.0000,
                                      //     "Prod_Name":
                                      //         "CHEESE SANDWICH",
                                      //   },
                                      //   {
                                      //     "Cart_ID": 12,
                                      //     "Cart_date":
                                      //         "2024-08-01 00:00:00.0",
                                      //     "Cart_Salesman_ID":
                                      //         "VGMHD3",
                                      //     "Cart_Table_ID":
                                      //         "VGMHD8",
                                      //     "Cart_Room_ID": 15,
                                      //     "Cart_Guest_Info":
                                      //         "SIRISHA",
                                      //     "Cart_Qty": 2.0000,
                                      //     "Cart_Rate":
                                      //         20.0000,
                                      //     "It_Total": 40.0000,
                                      //     "Prod_Name": "TEA",
                                      //   }
                                      // ];
                                      // NetworkPrinter netwrkP =
                                      //     NetworkPrinter();
                                      // netwrkP.testTicket(ll);
                                      // },
                                      // child:
                                      Text(
                                        'KOT Saved..Want Print ?',
                                        style: TextStyle(color: Colors.green),
                                      ),
                                      // ),
                                      // Icon(
                                      //   Icons.done,
                                      //   color: Colors.green,
                                      // )
                                    ],
                                  ),
                                  actions: [
                                    Container(
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
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            // backgroundColor:
                                            // ,
                                            textStyle: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                        child: const Text(
                                          'Yes',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () async {
                                          print("pirnt call");
                                          await Provider.of<Controller>(context,
                                                  listen: false)
                                              .finalPrint(context);
                                          await Provider.of<Controller>(context,
                                                  listen: false)
                                              .clearAllData(context);

                                          Navigator.of(context).push(
                                            PageRouteBuilder(
                                              opaque: false,
                                              pageBuilder: (_, __, ___) =>
                                                  HomePage(),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
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
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            // backgroundColor:
                                            // ,
                                            textStyle: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                        child: const Text(
                                          'No',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop(true);
                                          Provider.of<Controller>(context,
                                                  listen: false)
                                              .clearAllData(context);

                                          Navigator.of(context).push(
                                            PageRouteBuilder(
                                              opaque: false,
                                              pageBuilder: (_, __, ___) =>
                                                  HomePage(),
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
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Save Failed'),
                                  content: Text(
                                      'An error occurred while saving the KOT. Please try again.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Text(
                          "Yes",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            // backgroundColor:
                            // ,
                            textStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Container(
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
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "No",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            // backgroundColor:
                            //     P_Settings.salewaveColor,
                            textStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
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

//////////////////////////////////////////////////////////////////
  Widget customCard(int index, Size size, Map map) {
    return Consumer<Controller>(
        builder: (context, value, child) => Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                            child: Text(
                          // "product name",
                          "${map["Prod_Name"].toString().trimLeft().toUpperCase()}" ??
                              "",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 2, 131, 236)),
                        )),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(255, 238, 221, 71),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8, bottom: 4, top: 4),
                            child: Text(
                              // "cart rate",
                              "${map["Cart_Rate"].toStringAsFixed(2)} \u{20B9} ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8, bottom: 4, top: 4),
                              child: Text(
                                "${map["Cart_Qty"].toStringAsFixed(0)}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, bottom: 4, top: 4),
                          child: Text(
                            // "cart rate",
                            "${map["Cart_Description"].toString().trimLeft()}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Total : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              // "total",
                              "${map["It_Total"].toStringAsFixed(2)} \u{20B9}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            InkWell(
                                onTap: () async {
                                  cocosheet.showorderEditMoadlBottomsheet(
                                      map, context, size, index, date);
                                  // Navigator.pop(context);
                                },
                                child: Text(
                                  "Edit",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                                onTap: () async {
                                  await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text('Delete Order?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pop(
                                                        false); // dismisses only the dialog and returns false
                                              },
                                              child: Text('No'),
                                            ),
                                            TextButton(
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
                                                  1, "",
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
                                                // setState(() {});
                                                Navigator.pop(context);
                                              },
                                              child: Text('Yes'),
                                            ),
                                          ],
                                        );
                                      });

                                  ///////

                                  // Navigator.pop(context);
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "Delete",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Icon(
                                      Icons.close,
                                      size: 16,
                                      color: Colors.red,
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ));
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
