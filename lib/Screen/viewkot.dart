// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:intl/intl.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import 'dart:io';

// import 'package:restaurent_kot/controller/controller.dart';
// class ViewKot extends StatefulWidget {
//   const ViewKot({super.key});

//   @override
//   State<ViewKot> createState() => _ViewKotState();
// }

// class _ViewKotState extends State<ViewKot> {
//  String? date;
//   @override
//   void initState() {
//     // TODO: implement initState
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       // Provider.of<Controller>(context, listen: false).getIDss();
//     });
//     super.initState();
//     date = DateFormat('dd-MMM-yyyy').format(DateTime.now());
//   }
//   Widget build(BuildContext context) {
//         Size size = MediaQuery.of(context).size;
//     return WillPopScope(
//        onWillPop: () => _onBackPressed(context),
//       child: Scaffold(
//         appBar: AppBar(title: Consumer<Controller>(
//             builder: (BuildContext context, Controller value, Widget? child) =>
//                 Text(
//               "KOT List",

//               ///value.cartItems.length
//               style: TextStyle(
//                 fontSize: 19,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ),),
//         body:   Consumer<Controller>(
//           builder: (context, value, child) => value.isCartLoading
//               ? SpinKitCircle(
//                   color: Colors.black,
//                 )
//               : value.cartItems.length == 0
//                   ? Container(
//                       height: size.height * 0.7,
//                       child: Center(
//                           child: Lottie.asset("assets/noitem.json",
//                               height: size.height * 0.3)))
//                   : value.isCartLoading
//                       ? const Expanded(
//                           child: Align(
//                             alignment: Alignment.center,
//                             child: SpinKitCircle(
//                               color: Colors.black,
//                             ),
//                           ),
//                         )
//                       : ListView.builder(
//                           itemCount: value.cartItems.length,
//                           itemBuilder: (context, int index) {
//                             // return cartItems(index, size, value.cartItems[index]);
//                             // return customCard(
//                             //     index, size, value.cartItems[index]);
//                           }),
//         ),),
//     );
//   }
// }
// Future<bool> _onBackPressed(BuildContext context) async {
//   return await showDialog(
//     context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         // title: const Text('AlertDialog Title'),
//         content: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: ListBody(
//             children: const <Widget>[
//               Text('Do you want to exit from this app'),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: const Text('cancel'),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           TextButton(
//             child: const Text('Ok'),
//             onPressed: () {
//               exit(0);
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_kot/Screen/home.dart';
import 'package:restaurent_kot/controller/controller.dart';
import 'dart:io';

class ViewKot extends StatefulWidget {
  const ViewKot({super.key});

  @override
  State<ViewKot> createState() => _ViewKotState();
}

class _ViewKotState extends State<ViewKot> {
  String? date;
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Provider.of<Controller>(context, listen: false).getIDss();
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
              "KOT List",

              ///value.cartItems.length
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Consumer<Controller>(
          builder: (context, value, child) => value.isKOTLoading
              ? SpinKitCircle(
                  color: Colors.black,
                )
              : value.kotItems.length == 0
                  ? Container(
                      height: size.height * 0.7,
                      child: Center(
                          child: Lottie.asset("assets/noitem.json",
                              height: size.height * 0.3)))
                  : value.isKOTLoading
                      ? const Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: SpinKitCircle(
                              color: Colors.black,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: value.kotItems.length,
                          itemBuilder: (context, int index) {
                            // return cartItems(index, size, value.cartItems[index]);
                            return customCard(
                                index, size, value.kotItems[index]);
                          }),
        ),
      ),
    );
  }

//////////////////////////////////////////////////////////////////
  Widget customCard(int index, Size size, Map map) {
    return Consumer<Controller>(builder: (context, value, child) {
      String dateTimeString = map["kot_Date"].toString().trimLeft();
      DateTime dateTime = DateTime.parse(dateTimeString);

      String formattedDate =
          "${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year}";
      String dateTimeString1 = map["kot_time"].toString().trimLeft();
      DateTime dateTime1 = DateTime.parse(dateTimeString1);

      DateFormat dateFormat = DateFormat("hh:mm:ss a");
      String formattedTime = dateFormat.format(dateTime1);

      return Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Text(
                    // "product name",
                    "${map["Kot_No"].toString().trimLeft().toUpperCase()}",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )),
                  Container(
                    color: Colors.yellow,
                    padding: EdgeInsets.all(5),
                    child: Row(children: [
                      Text(
                        // "product name",
                        "${map["Table_No"].toString().trimLeft().toUpperCase() == "NULL" || map["Table_No"].toString().trimLeft().toUpperCase() == " " ? "" : map["Table_No"].toString().trimLeft().toUpperCase()}",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 2, 131, 236)),
                      ),
                      Text(
                        // "product name",
                        "/ ${map["Room_No"].toString().trimLeft().toUpperCase() == "NULL" || map["Room_No"].toString().trimLeft().toUpperCase() == " " ? "" : map["Room_No"].toString().trimLeft().toUpperCase()}",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 2, 131, 236)),
                      ),
                    ]),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: const Color.fromARGB(255, 2, 131, 236),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        // "product name",
                        "${formattedDate}",
                        style: TextStyle(
                            fontSize: 17,
                            // fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 2, 131, 236)),
                      ),
                    ],
                  )),
                  Flexible(
                      child: Text(
                    // "product name",
                    "${formattedTime}",
                    style: TextStyle(
                        fontSize: 17,
                        // fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 2, 131, 236)),
                  )),
                ],
              ),
            ],
          ),
        ),
      );
    });
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
