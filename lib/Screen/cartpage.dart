import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_kot/Screen/home.dart';
import 'package:restaurent_kot/controller/controller.dart';
import 'dart:io';

class CartBag extends StatefulWidget {
  const CartBag({super.key});

  @override
  State<CartBag> createState() => _CartBagState();
}

class _CartBagState extends State<CartBag> {
  String? date;
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<Controller>(context, listen: false).getIDss();
    });
    super.initState();
    date = DateFormat('dd-MMM-yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
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
              "Your Order ( ${value.cart_id.toString()})",

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
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "${value.tabl_name.toString().toUpperCase()} / ${value.room_nm.toString().toUpperCase() == "" || value.room_nm.toString().toUpperCase().isEmpty || value.room_nm.toString().toUpperCase() == "NULL" ? "" : value.room_nm.toString().toUpperCase()}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
          backgroundColor: Theme.of(context).primaryColor,
        ),
        bottomNavigationBar: Provider.of<Controller>(context, listen: false)
                .cartItems
                .isEmpty
            ? Container()
            : Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 197, 121, 71),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    showDialog(
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
                            height: 150,
                            child: Column(
                              children: [
                                Text("Do you want to save"),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                       await Provider.of<Controller>(context,
                                                listen: false)
                                            .finalSave(context);
                                            // print("res----${res}");

                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) {
                                              Size size =
                                                  MediaQuery.of(context).size;

                                              Future.delayed(
                                                  Duration(seconds: 5), () {
                                                Navigator.of(context).pop(true);
                                                Provider.of<Controller>(context,
                                                listen: false)
                                            .clearAllData(context);

                                                Navigator.of(context).push(
                                                  PageRouteBuilder(
                                                      opaque:
                                                          false, // set to false
                                                      pageBuilder:
                                                          (_, __, ___) =>
                                                              HomePage()
                                                      // OrderForm(widget.areaname,"return"),
                                                      ),
                                                );
                                              });
                                              return AlertDialog(
                                                  content: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'KOT Saved!!!!',
                                                    style: TextStyle(
                                                        color: Colors.green),
                                                  ),
                                                  Icon(
                                                    Icons.done,
                                                    color: Colors.green,
                                                  )
                                                ],
                                              ));
                                            });
                                      },
                                      child: Text("Yes"),
                                      style: ElevatedButton.styleFrom(
                                          // backgroundColor:
                                          // ,
                                          textStyle: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.03,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("No"),
                                      style: ElevatedButton.styleFrom(
                                          // backgroundColor:
                                          //     P_Settings.salewaveColor,
                                          textStyle: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
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
                    // Provider.of<Controller>(context, listen: false).viewCart(context);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => CartBag()),
                    // );
                  },
                  child: Consumer<Controller>(
                    builder: (BuildContext context, Controller value,
                            Widget? child) =>
                        Padding(
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
        body: 
        Consumer<Controller>(
          builder: (context, value, child) => value.isCartLoading
              ? SpinKitCircle(
                  color: Colors.black,
                )
              : value.cartItems.length == 0
                  ? Container(
                      height: size.height * 0.7,
                      child: Center(
                          child: Lottie.asset("assets/noitem.json",
                              height: size.height * 0.3)))
                  : value.isCartLoading
                      ? const Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: SpinKitCircle(
                              color: Colors.black,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: value.cartItems.length,
                          itemBuilder: (context, int index) {
                            // return cartItems(index, size, value.cartItems[index]);
                            return customCard(
                                index, size, value.cartItems[index]);
                          }),
        ),
      ),
    );
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            // Text("Srate : "),
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            InkWell(
                                onTap: () async {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) async {
                                    await Provider.of<Controller>(context,
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
                              margin: EdgeInsets.only(left: 5, right: 5,top: 5,
                                              bottom: 5),
                              width: size.width * 0.14,
                              // height: size.height * 0.05,
                              child: TextField(
                                onTap: () {
                                  value.qty[index].selection = TextSelection(
                                      baseOffset: 0,
                                      extentOffset:
                                          value.qty[index].value.text.length);
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
                                        color: Colors.grey), //<-- SEE HERE
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.grey), //<-- SEE HERE
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                                onTap: () {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) async {
                                    await Provider.of<Controller>(context,
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
                      ],
                    ),
                    Row(
                      children: [
                        // Container(
                        //   margin: EdgeInsets.only(left: 10, right: 7),
                        //   width: size.width * 0.48,
                        //   height: size.height * 0.08,
                        //   child: TextField(
                        //     onTap: () {
                        //       print("ddddddddddd=================${value.descr[index].text}");
                        //       value.descr[index].selection = TextSelection(
                        //           baseOffset: 0,
                        //           extentOffset:
                        //               value.descr[index].value.text.length);
                        //     },
                        //     onSubmitted: (val) {
                        //       // Provider.of<Controller>(context,
                        //       //         listen: false)
                        //       //     .updateCart(
                        //       //         context,
                        //       //         map,
                        //       //         date!,
                        //       //         value.customerId.toString(),
                        //       //         double.parse(val),
                        //       //         index,
                        //       //         "from cart",
                        //       //         0,
                        //       //         "");

                        //       // Provider.of<Controller>(context, listen: false)
                        //       //     .viewCart(
                        //       //   context,
                        //       // );
                        //     },
                        //     controller: value.descr[index],
                        //     textAlign: TextAlign.center,
                        //     style: TextStyle(
                        //         color: Colors.black,
                        //         fontSize: 12,
                        //         fontWeight: FontWeight.w600),
                        //     decoration: InputDecoration(
                        //       contentPadding: EdgeInsets.all(10),
                        //       enabledBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(
                        //             width: 1,
                        //             color: Colors.grey), //<-- SEE HERE
                        //       ),
                        //       focusedBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(
                        //             width: 1,
                        //             color: Colors.grey), //<-- SEE HERE
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // Text("---${value.descr[index].text.toString()}")
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
                            Text("Total : "),
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
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) async {
                                    await Provider.of<Controller>(context,
                                            listen: false)
                                        .updateCart2(
                                      context,
                                      map,
                                      0,
                                      // value.descr[index].text,
                                      double.parse(value.qty[index].text),
                                    );
                                    await Provider.of<Controller>(context,
                                            listen: false)
                                        .viewCart(
                                      context,
                                    );
                                  });
                                  // Navigator.pop(context);
                                },
                                child: Text(
                                  "Update",
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
                                              onPressed: () {
                                                WidgetsBinding.instance
                                                    .addPostFrameCallback(
                                                        (_) async {
                                                  await Provider.of<Controller>(
                                                          context,
                                                          listen: false)
                                                      .updateCart2(
                                                    context,
                                                    map,
                                                    1,
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
                                                });
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
