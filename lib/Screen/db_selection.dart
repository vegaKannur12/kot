import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_kot/Screen/authentication/login.dart';
import 'package:restaurent_kot/Screen/home.dart';
import 'package:restaurent_kot/components/popup_unreg.dart';
import 'package:restaurent_kot/controller/controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sql_conn/sql_conn.dart';

class DBSelection extends StatefulWidget {
  const DBSelection({super.key});

  @override
  State<DBSelection> createState() => _DBSelectionState();
}

class _DBSelectionState extends State<DBSelection>
    with SingleTickerProviderStateMixin {
  Unreg popup = Unreg();
  late AnimationController _animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animationController.forward();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Provider.of<Controller>(context, listen: false).initDb(context, "");
      Provider.of<Controller>(context, listen: false)
          .getDatabasename(context, "");
      // Provider.of<Controller>(context, listen: false).getDbName();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        // backgroundColor: parseColor("#46bdc6"),
        appBar: AppBar(
          // backgroundColor: parseColor("#46bdc6"),
          // backgroundColor: Colors.transparent,
          // elevation: 0,
          automaticallyImplyLeading: false,
          //  flexibleSpace: Container(
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: [
          //         Color.fromARGB(255, 48, 54, 90),
          //         Colors.indigo,
          //       ],
          //       begin:Alignment.bottomRight,

          //       end:  Alignment.topLeft,
          //     ),
          //   ),
          // ),
          actions: [
            PopupMenuButton(itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text("Unregister"),
                ),
                // PopupMenuItem<int>(
                //   value: 1,
                //   child: Text("Exit"),
                // ),
              ];
            }, onSelected: (value) {
              if (value == 0) {
                popup.showAlertDialog(context);
              }
              //  else if (value == 1) {
              //   extPop.showAlertDialog(context);
              // }
            })
          ],
          // title: Text(
          //   "Year Selection",
          //   style: TextStyle(
          //       color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
          // ),
        ),

        body: Container(
          child: Consumer<Controller>(
              builder: (context, value, child) => value.isdbLoading
                  ? SpinKitCircle(
                      color: Colors.black,
                    )
                  : Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onLongPress: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  String? db = prefs.getString("db_name");
                                  String? ip = prefs.getString("ip");
                                  String? port = prefs.getString("port");
                                  String? un = prefs.getString("usern");
                                  String? pw = prefs.getString("pass_w");
                                  TextEditingController dbc =
                                      TextEditingController(
                                          text: db.toString());
                                  TextEditingController ipc =
                                      TextEditingController(
                                          text: ip.toString());
                                  TextEditingController usrc =
                                      TextEditingController(
                                          text: un.toString());
                                  TextEditingController portc =
                                      TextEditingController(
                                          text: port.toString());
                                  TextEditingController pwdc =
                                      TextEditingController(
                                          text: pw.toString());
                                  bool pressed = false;

                                  await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                          builder: (BuildContext context,
                                                  void Function(void Function())
                                                      setState) =>
                                              AlertDialog(
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                    style: ButtonStyle(),
                                                    onPressed: () {
                                                      Navigator.of(context,
                                                              rootNavigator:
                                                                  true)
                                                          .pop(false);
                                                    },
                                                    icon: Icon(Icons.close))
                                              ],
                                            ),
                                            content: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text('DB Deatails'),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                          width: 90,
                                                          child: Text("DB")),
                                                      pressed
                                                          ? SizedBox(
                                                              width:
                                                                  size.width *
                                                                      1 /
                                                                      3,
                                                              child:
                                                                  TextFormField(
                                                                controller: dbc,
                                                              ))
                                                          : Text(
                                                              " :  ${db.toString()}")
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                          width: 90,
                                                          child: Text("IP")),
                                                      pressed
                                                          ? SizedBox(
                                                              width:
                                                                  size.width *
                                                                      1 /
                                                                      3,
                                                              child:
                                                                  TextFormField(
                                                                controller: ipc,
                                                              ))
                                                          : Text(
                                                              " :  ${ip.toString()}")
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                          width: 90,
                                                          child: Text("PORT")),
                                                      pressed
                                                          ? SizedBox(
                                                              width:
                                                                  size.width *
                                                                      1 /
                                                                      3,
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    portc,
                                                              ))
                                                          : Text(
                                                              " :  ${port.toString()}")
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                          width: 90,
                                                          child:
                                                              Text("USERNAME")),
                                                      pressed
                                                          ? SizedBox(
                                                              width:
                                                                  size.width *
                                                                      1 /
                                                                      3,
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    usrc,
                                                              ))
                                                          : Text(
                                                              " :  ${un.toString()}")
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                          width: 90,
                                                          child:
                                                              Text("PASSWORD")),
                                                      pressed
                                                          ? SizedBox(
                                                              width:
                                                                  size.width *
                                                                      1 /
                                                                      3,
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    pwdc,
                                                              ))
                                                          : Text(
                                                              " :  ${pw.toString()}")
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      pressed = true;
                                                    });
                                                    dbc.text = db.toString();
                                                    ipc.text = ip.toString();
                                                    portc.text =
                                                        port.toString();
                                                    usrc.text = un.toString();
                                                    pwdc.text = pw.toString();
                                                    print("pressed---$pressed");
                                                  },
                                                  icon: Icon(Icons.edit)),
                                              TextButton(
                                                onPressed: () async {
                                                  await prefs.setString(
                                                      "old_db_name",
                                                      dbc.text.toString());
                                                  await prefs.setString(
                                                      "db_name",
                                                      dbc.text.toString());
                                                  await prefs.setString("ip",
                                                      ipc.text.toString());
                                                  await prefs.setString("port",
                                                      portc.text.toString());
                                                  await prefs.setString("usern",
                                                      usrc.text.toString());
                                                  await prefs.setString(
                                                      "pass_w",
                                                      pwdc.text.toString());
                                                  // setState(() {
                                                  //   pressed = false;
                                                  // });
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop(
                                                          false); // dismisses only the dialog and returns false
                                                },
                                                child: Text('UPDATE'),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: Animate(
                                  child: Text(
                                    "Year Selection".toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.indigo,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ).fadeIn(duration: Duration(seconds: 1)),
                              ),
                            ],
                          ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25,right: 25),
                              child: Divider(color: Colors.indigo,),
                            ),
                          SizedBox(
                            height: 10,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: value.db_list.length,
                              itemBuilder: (context, index) {
                                // Initialize the opacity and scale animations for each item
                                final animation =
                                    Tween<double>(begin: 0, end: 1).animate(
                                  CurvedAnimation(
                                    parent: _animationController,
                                    curve: Interval(
                                        (1 / value.db_list.length) * index, 1,
                                        curve: Curves.easeOut),
                                  ),
                                );
                                return FadeTransition(
                                  opacity: animation,
                                  child: ScaleTransition(
                                    scale: animation,
                                    child: Container(
                                      margin: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black38),
                                        borderRadius: BorderRadius.circular(30),
                                        gradient: LinearGradient(
                                          colors: [
                                            // Color.fromARGB(255, 253, 192, 123),
                                            //                   Color.fromARGB(255, 50, 71, 190),
                                            Color.fromARGB(255, 48, 54, 90),
                                            Colors.indigo,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                      padding: EdgeInsets.all(15),
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.currency_exchange_rounded,
                                          size: 40,
                                          color: Colors.blue,
                                        ),
                                        trailing: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color.fromARGB(
                                                    255, 195, 203, 241),
                                                Color.fromARGB(
                                                    255, 50, 71, 190),
                                              ],
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors
                                                    .transparent, // Make button background transparent
                                                shadowColor: Colors.transparent,
                                              ),
                                              onPressed: () async {
                                                SharedPreferences prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                prefs.setString(
                                                    "db_name",
                                                    value.db_list[index]
                                                            ["Data_Name"]
                                                        .toString());
                                                prefs.setString(
                                                    "yr_name",
                                                    value.db_list[index]
                                                            ["Year_Name"]
                                                        .toString());

                                                await Provider.of<Controller>(
                                                        context,
                                                        listen: false)
                                                    .initYearsDb(context, "");
                                                Provider.of<Controller>(context,
                                                        listen: false)
                                                    .getLogin(context);
                                                Provider.of<Controller>(context,
                                                        listen: false)
                                                    // .getSettings(
                                                    //     context, "ENB_ROOM_CR");
                                                .getSettings(context,"");
                                                Provider.of<Controller>(context,
                                                        listen: false)
                                                    .getTableCtegory(context);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LoginPage()),
                                                );
                                              },
                                              child: Text(
                                                "Connect",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )).animate().fade(duration: 300.ms).scale(),
                                        ),
                                        title: Text(
                                          value.db_list[index]["Year_Name"]
                                              .toString()
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                    )),
        ),
      ),
    );
  }
}

// Color parseColor(String color) {
//   print("Colorrrrr...$color");
//   String hex = color.replaceAll("#", "");
//   if (hex.isEmpty) hex = "ffffff";
//   if (hex.length == 3) {
//     hex =
//         '${hex.substring(0, 1)}${hex.substring(0, 1)}${hex.substring(1, 2)}${hex.substring(1, 2)}${hex.substring(2, 3)}${hex.substring(2, 3)}';
//   }
//   Color col = Color(int.parse(hex, radix: 16)).withOpacity(1.0);
//   return col;
// }

Future<bool> _onBackPressed(BuildContext context) async {
  return await showDialog(context: context, builder: (context) => exit(0));
}
