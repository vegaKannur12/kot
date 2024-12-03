import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_kot/Screen/2categoryPage.dart';
import 'package:restaurent_kot/Screen/viewkot.dart';
import 'package:restaurent_kot/components/custom_snackbar.dart';
import 'package:restaurent_kot/controller/controller.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? date;
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<Controller>(context, listen: false).getTableList(context);
      if (Provider.of<Controller>(context, listen: false).settingsList[1]
              ["SVALUE"] ==
          "YES") {
        Provider.of<Controller>(context, listen: false).getRoomList(context);
      }
      Provider.of<Controller>(context, listen: false).getOs();
    });
    // showAlert();
    int timerval = Provider.of<Controller>(context, listen: false)
        .settingsList[2]["SVALUE"];
    print("Timer val == $timerval");
    timer = Timer.periodic(Duration(seconds: timerval), (Timer t) {
      showAlert();
    });
    date = DateFormat('dd-MMM-yyyy').format(DateTime.now());
  }

  showAlert() async {
    //  await Provider.of<Controller>(context, listen: false).checkCondition();
    await Provider.of<Controller>(context, listen: false).checkCondition();
    // if (await Provider.of<Controller>(context, listen: false)
    //     .checkCondition()) {
    //   Provider.of<Controller>(context, listen: false)
    //       .showReminderNotification();
    // }
  }

  TextEditingController seacrh = TextEditingController();
  TextEditingController seacrhRoom = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("width===${size.width}");
    print("height===${size.height}");
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 204, 208, 231),
        extendBody: true,
        // appBar: AppBar(
        //   toolbarHeight: 80,
        //   backgroundColor: Colors.indigo,
        //   title: Consumer<Controller>(
        //       builder:
        //           (BuildContext context, Controller value, Widget? child) =>
        //               Text(
        //                 value.os.toString(),
        //                 style: TextStyle(
        //                   fontWeight: FontWeight.bold,
        //                   color: Colors.black,
        //                 ),
        //               )),
        //   actions: [
        //     Align(
        //       alignment: Alignment.centerRight,
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.end,
        //         children: [
        //           Icon(
        //             Icons.calendar_month,
        //             color: Colors.white,
        //           ),
        //           SizedBox(
        //             width: 5,
        //           ),
        //           Text(
        //             date.toString(),
        //             style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 16,
        //                 fontWeight: FontWeight.bold),
        //           ),
        //         ],
        //       ),
        //     ),
        //     IconButton.filled(
        //       onPressed: () {
        //         Provider.of<Controller>(context, listen: false)
        //             .viewKot(context, date!);
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => ViewKot()),
        //         );
        //       },
        //       icon: Icon(
        //         Icons.shopping_bag,
        //         color: Colors.white,
        //       ),
        //     )
        //     // SizedBox(
        //     //   child: ElevatedButton(
        //     //     child: Icon(Icons.shopping_bag_outlined,color: Colors.white,),
        //     //     onPressed: () {},
        //     //     style: ElevatedButton.styleFrom(
        //     //         backgroundColor: Colors.black,
        //     //         padding: EdgeInsets.all(5),
        //     //         textStyle:
        //     //             TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        //     //   ),
        //     // ),
        //     // IconButton(
        //     //   onPressed: () async {
        //     //     List<Map<String, dynamic>> list =
        //     //         await KOT.instance.getListOfTables();
        //     //     Navigator.push(
        //     //       context,
        //     //       MaterialPageRoute(
        //     //           builder: (context) => TableList(list: list)),
        //     //     );
        //     //   },
        //     //   icon: Icon(Icons.table_bar, color: Colors.green),
        //     // ),
        //   ],
        // ),
        bottomNavigationBar: Provider.of<Controller>(context, listen: false)
                .tablID!
                .isEmpty
            ? Container()
            : Consumer<Controller>(
                builder:
                    (BuildContext context, Controller value, Widget? child) {
                  return Container(
                    height:
                        value.settingsList[1]["SVALUE"] == "YES" ? 170 : 110,
                    decoration: BoxDecoration(
                      // color: Color.fromARGB(255, 111, 128, 228),
                      color: Color.fromARGB(255, 204, 208, 231),
                      // Color.fromARGB(255, 197, 121, 71),
                      // borderRadius: const BorderRadius.only(
                      //   topLeft: Radius.circular(20),
                      //   topRight: Radius.circular(20),
                      // ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        value.settingsList[1]["SVALUE"] == "YES"
                            ? Container(
                                height: 65,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 69, 79, 134),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      value.tablname.toString().trimLeft().toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Container(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            value.settingsList[1]["SVALUE"] == "YES"
                                ? Container(
                                    margin: EdgeInsets.only(bottom: 10),
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
                                    height: 65,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        // backgroundColor: Colors.black
                                        backgroundColor: Colors
                                            .transparent, // Make button background transparent
                                        shadowColor: Colors.transparent,
                                      ),
                                      onPressed: () {
                                        showModalBottomSheet<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return StatefulBuilder(
                                              builder: (BuildContext context,
                                                      void Function(
                                                              void Function())
                                                          setState) =>
                                                  Container(
                                                // height: 200,
                                                height:
                                                    value.roomlist.isNotEmpty
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.65
                                                        : size.height * 0.2,
                                                color: Colors.white,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    value.roomlist.isNotEmpty
                                                        ? Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .close))
                                                            ],
                                                          )
                                                        : Container(),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: Color.fromARGB(
                                                            241, 235, 236, 236),
                                                      ),
                                                      child: TextFormField(
                                                        controller: seacrhRoom,
                                                        //   decoration: const InputDecoration(,
                                                        onChanged: (val) {
                                                          setState(() {
                                                            Provider.of<Controller>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .searchRoom(val
                                                                    .toString());
                                                          });
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          fillColor:
                                                              Colors.white,
                                                          filled: true,
                                                          prefixIcon:
                                                              const Icon(
                                                            Icons.search,
                                                            color: Colors.black,
                                                          ),
                                                          suffixIcon:
                                                              IconButton(
                                                            icon: const Icon(
                                                                Icons.cancel),
                                                            onPressed: () {
                                                              setState(() {
                                                                print(
                                                                    "pressed");
                                                                seacrhRoom
                                                                    .clear();

                                                                Provider.of<Controller>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .searchRoom(
                                                                        "");
                                                              });
                                                            },
                                                          ),
                                                          border:
                                                              InputBorder.none,
                                                          // focusedBorder:
                                                          //     UnderlineInputBorder(
                                                          //   borderRadius:
                                                          //       BorderRadius.circular(20.0),
                                                          //   borderSide: const BorderSide(
                                                          //       color: Colors.blue,
                                                          //       width: 1.0),
                                                          // ),
                                                          enabledBorder:
                                                              InputBorder.none,
                                                          // OutlineInputBorder(
                                                          //   borderRadius:
                                                          //       BorderRadius.circular(20.0),
                                                          //   borderSide: const BorderSide(
                                                          //       color: Colors.black,
                                                          //       width: 1.0),
                                                          // ),
                                                          hintText:
                                                              "Search room...",
                                                        ),
                                                      ),
                                                    ),
                                                    value.isRoomSearch
                                                        ? roomWidget(
                                                            size,
                                                            value
                                                                .filteredroomlist,
                                                            context)
                                                        : roomWidget(
                                                            size,
                                                            value.roomlist,
                                                            context)
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.cabin,
                                              color: Colors.white),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Room Credit',
                                            // textScaleFactor:
                                            //     ScaleSize.textScaleFactor(context),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    padding: EdgeInsets.only(left: 10,top: 10,bottom: 10,right: 15),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 69, 79, 134),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${value.tablname.toString().trimLeft().toUpperCase()}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                            Padding(
                              padding: EdgeInsets.only(right: 20, bottom: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      // Color.fromARGB(255, 253, 192, 123),
                                      // Color.fromARGB(255, 50, 71, 190),
                                      // Color.fromARGB(255, 48, 54, 90),
                                      // Colors.indigo,
                                      Color.fromARGB(255, 67, 83, 155),
                                      Color.fromARGB(255, 50, 71, 190),
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                height: 70,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors
                                        .transparent, // Make button background transparent
                                    shadowColor: Colors.transparent,
                                  ),
                                  onPressed: () async {
                                    print("------------${value.tablID}");
                                    if (value.tablID!.isNotEmpty) {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      int? c = prefs.getInt("cartNo");
                                      if (c != 0) {
                                        await Provider.of<Controller>(context,
                                                listen: false)
                                            .getCategoryList(context);
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .getItemList(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => CatTEST(
                                                    // builder: (context) => CategoryScreen(
                                                    tablId: value.tablname
                                                        .toString(),
                                                    roomId: value.roomnm
                                                            .toString() ??
                                                        "",
                                                  )),
                                        ).then((value) {
                                          // This code runs when returning from the NextScreen
                                          // You can put your refresh logic here
                                          setState(() {
                                            Provider.of<Controller>(context,
                                                    listen: false)
                                                .clearAllData(context);
                                            seacrhRoom.clear();
                                            // Update data or perform actions to refresh the page
                                          });
                                        });
                                      } else {
                                        CustomSnackbar snackbar =
                                            CustomSnackbar();
                                        snackbar.showSnackbar(context,
                                            "Error getting Cart Number", "");
                                      }
                                    } else {
                                      CustomSnackbar snackbar =
                                          CustomSnackbar();
                                      snackbar.showSnackbar(
                                          context, "Select Table", "");
                                    }
                                  },
                                  child: Text(
                                    "Proceed",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.white),
                                  ),
                                ).animate().fade(duration: 300.ms).scale(),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                // gradient: RadialGradient(
                //   colors: [Colors.orange, Colors.red],
                //   center: Alignment(0.7, -0.6), // Adjusts the gradient position
                //   radius: 0.6,
                // ),
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
                // image: DecorationImage(
                //     image: AssetImage("assets/appbar1.jfif"),
                //     fit: BoxFit.fill),
              ),
              child: Consumer<Controller>(
                  builder: (context, value, child) => Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    value.os.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.calendar_month,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          date.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        IconButton.filled(
                                          onPressed: () {
                                            Provider.of<Controller>(context,
                                                    listen: false)
                                                .viewKot(context, date!);

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ViewKot()),
                                            );

                                            // Provider.of<Controller>(context,
                                            //         listen: false)
                                            //     .kitchenDisplayData(
                                            //         context, date!);

                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           KitchenDisp()),
                                            // );
                                          },
                                          icon: Icon(
                                            Icons.shopping_bag,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // value.table_catID == 0
                            //     ?
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                  // height: 50,
                                  // width: 250,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(23),
                                    color: Color.fromARGB(241, 235, 236, 236),
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(23),
                                        ),
                                        fillColor: Colors.white,
                                        filled: true),
                                    isExpanded: true,
                                    hint: Text(" Select Table Category"),
                                    value: value.selectedTableCat,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        value.selectedTableCat = newValue;
                                        print(("object"));
                                        print(
                                            ("selected TableCAT== ${value.selectedTableCat}"));
                                        value.selectedItemTablecat = value
                                            .tableCategoryList
                                            .firstWhere((element) =>
                                                element['Table_Category'] ==
                                                newValue);
                                        print(
                                            "${value.selectedItemTablecat!['Table_Category']}");
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .updateTableCAT(context);
                                      });
                                    },
                                    items: value.tableCategoryList
                                        .map<DropdownMenuItem<String>>(
                                            (Map<String, dynamic> item) {
                                      return DropdownMenuItem<String>(
                                        value: item['Table_Category'],
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Text(item['Table_Category']),
                                        ),
                                      );
                                    }).toList(),
                                  ).animate().fade(duration: 300.ms).scaleX()),
                            )
                            // : Padding(
                            //     padding: EdgeInsets.all(15),
                            //     child: Container(
                            //       child: Center(
                            //         child: Text(
                            //           "${value.table_catNM}",
                            //           style: TextStyle(
                            //               color: Colors.white,
                            //               fontWeight: FontWeight.bold,
                            //               fontSize: 20),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                          ],
                        ),
                      )),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _handleRefresh,
                child: CustomScrollView(slivers: [
                  Consumer<Controller>(builder: (context, value, child) {
                    if (value.isTableLoading) {
                      return SliverFillRemaining(
                        child: Center(
                          child: SpinKitCircle(
                            color: Colors.black,
                          ),
                        ),
                      );
                    } else if (value.tabllistCAT.isEmpty) {
                      return SliverFillRemaining(
                        child: Center(
                          child: Lottie.asset(
                            "assets/noitem.json",
                            height: size.height * 0.3,
                          ),
                        ),
                      );
                    } else {
                      return SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: size.width >= 420 ? 4 : 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return tableWidget(
                                size, value.tabllistCAT[index], context);
                          },
                          childCount: value.tabllistCAT.length,
                        ),
                      );
                    }
                  })
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

// ItemList(catlId: map["catid"],catName: map["catname"],)
/////////////////////////////////////////////////////////////////
  Widget tableWidget(
      Size size, Map<String, dynamic> list, BuildContext context) {
    return Consumer<Controller>(
      builder: (context, value, child) => Container(
        decoration: BoxDecoration(
            // image: DecorationImage(
            //                       image: AssetImage("assets/food.jpg"),
            //                       fit: BoxFit.fill),
            color: list["STATUS"] == 1
                ? Color.fromARGB(255, 230, 167, 167) // pending
                : Colors.white, // free
            border: Border.all(color: Colors.black45),
            borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          onLongPress: () async {
            await Provider.of<Controller>(context, listen: false)
                .viewTableItems(
                    context, list["Table_Name"].toString().trimLeft(), 0);
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Column(
                    children: [
                      Text('Pending Orders( ${value.tableItemList.length} )',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 111, 128, 228),
                          )),
                      Divider()
                    ],
                  ),
                  content: Container(
                    width: size.width * 1 / 2,
                    // width: double.maxFinite,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.tableItemList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  " ${value.tableItemList[index]['Item'].toString().trimLeft().toUpperCase()}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                " ${value.tableItemList[index]['Qty'].toStringAsFixed(0)}",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
            // showDialog(
            //     barrierDismissible: false,
            //     context: context,
            //     builder: (context) {
            //       Size size = MediaQuery.of(context).size;

            //       // Future.delayed(Duration(seconds: 5), () {
            //       //   Navigator.of(context).pop(true);
            //       // });
            //       return AlertDialog(
            //           content: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Text(
            //             'jghjgjgj',
            //           ),

            //           Icon(
            //             Icons.done,
            //             color: Colors.green,
            //           )
            //         ],
            //       ));
            //     });
          },
          onTap: () async {
            await value.setTableID(list, context);
            await Provider.of<Controller>(context, listen: false)
                .getCartNo(context);
            // CustomSnackbar snackbar = CustomSnackbar();
            // snackbar.showSnackbar(
            //     context,
            //     "Table ${value.tablname.toString().trimLeft().toUpperCase()} Selected.",
            //     "");

            setState(() {});
          },
          child: Container(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8),
              child: Column(
                children: [
                  Text(
                    // textAlign: TextAlign.center,
                    maxLines: 2,
                    // "SDFGGGTHHJJJJJJJJSSS",
                    list["Table_Name"].toString().trimLeft().toUpperCase(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: size.width > 360 ? 25 : 20),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    width: size.width > 360 ? 68 : 40,
                    height: 56,
                    child: Image.asset("assets/table3.png"),
                  )
                  // ConstrainedBox(
                  //    constraints: BoxConstraints(minWidth: 40,maxHeight: 65,maxWidth:65,minHeight: 40),child: SizedBox(child: Image.asset("assets/table3.png"),)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget roomWidget(Size size, List list, BuildContext context) {
    return Consumer<Controller>(
      builder: (context, value, child) => value.isRoomLoading
          ? const Expanded(
              child: Align(
                alignment: Alignment.center,
                child: SpinKitCircle(
                  color: Colors.black,
                ),
              ),
            )
          : Expanded(
              child: list.isEmpty
                  ? const Center(child: Text("no data"))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: value.isRoomSearch
                          ? value.filteredroomlist.length
                          : value.roomlist.length,
                      // gridDelegate:
                      //     const SliverGridDelegateWithFixedCrossAxisCount(
                      //         crossAxisCount: 1,
                      //         crossAxisSpacing: 12,
                      //         mainAxisSpacing: 12),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () async {
                          await value.setRoomID(
                              list[index]["Room_ID"].toString().trimLeft(),
                              list[index]["Room_Name"].toString().trimLeft(),
                              list[index]["Guest_Info"].toString().trimLeft(),
                              context);
                          Navigator.pop(context);
                          // CustomSnackbar snackbar = CustomSnackbar();
                          // snackbar.showSnackbar(
                          //     context,
                          //     "Room ${value.roomID.toString()} Selected.",
                          //     "");
                          // showDialog(
                          //     barrierDismissible: false,
                          //     context: context,
                          //     builder: (context) {
                          //       Size size = MediaQuery.of(context).size;

                          //       Future.delayed(Duration(seconds: 2), () {
                          //         Navigator.of(context).pop(true);
                          //       });
                          //       return AlertDialog(
                          //           content: Row(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: [
                          //           Text(
                          //             'Room ${value.roomID.toString()} Selected.',
                          //           ),
                          //           Icon(
                          //             Icons.done,
                          //             color: Colors.green,
                          //           )
                          //         ],
                          //       ));
                          //     });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black12)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 8.0, bottom: 8),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: SizedBox(
                                          width: size.width * 1 / 4.4,
                                          child: Text(
                                            maxLines: 2,
                                            list[index]["Room_Name"]
                                                .toString()
                                                .trimLeft(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // color: Colors.yellow,
                                        width: size.width * 1 / 2,
                                        child: Text(
                                          maxLines: 2,
                                          // "gfgfhfh dgdhfhfhf fhyfhfhjfjhfhj eteteteteye",
                                          list[index]["Guest_Info"]
                                              .toString()
                                              .trimLeft(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
    );
  }

  Future<void> _handleRefresh() async {
    // Simulate network fetch or database query
    await Future.delayed(Duration(seconds: 2));
    // Update the list of items and refresh the UI
    setState(() {
      Provider.of<Controller>(context, listen: false).clearAllData(context);
      Provider.of<Controller>(context, listen: false).getTableList(context);
      print("Table Refreshed----");
      // items = List.generate(20, (index) => "Refreshed Item ${index + 1}");
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
