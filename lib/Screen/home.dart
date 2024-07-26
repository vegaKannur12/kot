import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_kot/Screen/cartpage.dart';
import 'package:restaurent_kot/Screen/categorypage.dart';
import 'package:restaurent_kot/Screen/viewkot.dart';
import 'package:restaurent_kot/components/custom_snackbar.dart';
import 'package:restaurent_kot/components/sizeScaling.dart';
import 'package:restaurent_kot/controller/controller.dart';
import 'package:restaurent_kot/db_helper.dart';
import 'package:restaurent_kot/tableList.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? date;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<Controller>(context, listen: false).getTableList(context);
      Provider.of<Controller>(context, listen: false).getRoomList(context);
      // Provider.of<Controller>(context, listen: false)
      //     .qtyadd();           //tempry adding qty

      Provider.of<Controller>(context, listen: false).getOs();
    });
    date = DateFormat('dd-MMM-yyyy').format(DateTime.now());
  }

  TextEditingController seacrh = TextEditingController();
  TextEditingController seacrhRoom = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: const Color.fromARGB(255, 111, 128, 228),
          title: Consumer<Controller>(
              builder:
                  (BuildContext context, Controller value, Widget? child) =>
                      Text(
                        value.os.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )),
          actions: [
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
                ],
              ),
            ),
            IconButton.filled(
              onPressed: () {
                Provider.of<Controller>(context, listen: false)
                    .viewKot(context, date!);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewKot()),
                );
              },
              icon: Icon(
                Icons.shopping_bag,
                color: Colors.white,
              ),
            )
            // SizedBox(
            //   child: ElevatedButton(
            //     child: Icon(Icons.shopping_bag_outlined,color: Colors.white,),
            //     onPressed: () {},
            //     style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.black,
            //         padding: EdgeInsets.all(5),
            //         textStyle:
            //             TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            //   ),
            // ),
            // IconButton(
            //   onPressed: () async {
            //     List<Map<String, dynamic>> list =
            //         await KOT.instance.getListOfTables();
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => TableList(list: list)),
            //     );
            //   },
            //   icon: Icon(Icons.table_bar, color: Colors.green),
            // ),
          ],
        ),
        bottomNavigationBar: Provider.of<Controller>(context, listen: false)
                .tablID!
                .isEmpty
            ? Container()
            : Consumer<Controller>(
                builder:
                    (BuildContext context, Controller value, Widget? child) {
                  return Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 111, 128, 228),
                      // Color.fromARGB(255, 197, 121, 71),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                    builder: (BuildContext context,
                                            void Function(void Function())
                                                setState) =>
                                        Container(
                                      // height: 200,
                                      height: value.roomlist.isNotEmpty
                                          ? MediaQuery.of(context).size.height *
                                              0.65
                                          : size.height * 0.2,
                                      color: Colors.white,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          value.roomlist.isNotEmpty
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        icon: const Icon(
                                                            Icons.close))
                                                  ],
                                                )
                                              : Container(),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
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
                                                          listen: false)
                                                      .searchRoom(
                                                          val.toString());
                                                });
                                              },
                                              decoration: InputDecoration(
                                                prefixIcon: const Icon(
                                                  Icons.search,
                                                  color: Colors.black,
                                                ),
                                                suffixIcon: IconButton(
                                                  icon:
                                                      const Icon(Icons.cancel),
                                                  onPressed: () {
                                                    setState(() {
                                                      print("pressed");
                                                      seacrhRoom.clear();

                                                      Provider.of<Controller>(
                                                              context,
                                                              listen: false)
                                                          .searchRoom("");
                                                    });
                                                  },
                                                ),
                                                border: InputBorder.none,
                                                // focusedBorder:
                                                //     UnderlineInputBorder(
                                                //   borderRadius:
                                                //       BorderRadius.circular(20.0),
                                                //   borderSide: const BorderSide(
                                                //       color: Colors.blue,
                                                //       width: 1.0),
                                                // ),
                                                enabledBorder: InputBorder.none,
                                                // OutlineInputBorder(
                                                //   borderRadius:
                                                //       BorderRadius.circular(20.0),
                                                //   borderSide: const BorderSide(
                                                //       color: Colors.black,
                                                //       width: 1.0),
                                                // ),
                                                hintText: "Search room...",
                                              ),
                                            ),
                                          ),
                                          value.isRoomSearch
                                              ? roomWidget(
                                                  size,
                                                  value.filteredroomlist,
                                                  context)
                                              : roomWidget(
                                                  size, value.roomlist, context)
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Icon(Icons.cabin, color: Colors.black),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Room Credit',
                                  textScaleFactor:
                                      ScaleSize.textScaleFactor(context),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black),
                                )
                              ],
                            ),
                          ),
                          ElevatedButton(
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CategoryScreen(
                                                tablId:
                                                    value.tablname.toString(),
                                                roomId:
                                                    value.roomnm.toString() ??
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
                                    CustomSnackbar snackbar = CustomSnackbar();
                                    snackbar.showSnackbar(context,
                                        "Error getting Cart Number", "");
                                  }
                                } else {
                                  CustomSnackbar snackbar = CustomSnackbar();
                                  snackbar.showSnackbar(
                                      context, "Select Table", "");
                                }
                              },
                              child: Text("Proceed"))
                        ],
                      ),
                    ),
                  );
                },
              ),
        body: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<Controller>(
              builder: (context, value, child) => Column(
                children: [
                  Container(
                    // height: 50,
                    // width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(241, 235, 236, 236),
                    ),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(border: InputBorder.none),
                      isExpanded: true,
                      hint: Text("Select Table Category"),
                      value: value.selectedTableCat,
                      onChanged: (String? newValue) {
                        setState(() {
                          value.selectedTableCat = newValue;
                          print(("object"));
                          print(
                              ("selected TableCAT==${value.selectedTableCat}"));
                          value.selectedItemTablecat = value.tableCategoryList
                              .firstWhere((element) =>
                                  element['Table_Category'] == newValue);
                          print(
                              "${value.selectedItemTablecat!['Table_Category']}");
                          Provider.of<Controller>(context, listen: false)
                              .updateTableCAT(context);
                        });
                      },
                      items: value.tableCategoryList
                          .map<DropdownMenuItem<String>>(
                              (Map<String, dynamic> item) {
                        return DropdownMenuItem<String>(
                          value: item['Table_Category'],
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text(item['Table_Category']),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  // TextFormField(
                  //   controller: seacrh,
                  //   //   decoration: const InputDecoration(,
                  //   onChanged: (val) {
                  //     Provider.of<Controller>(context, listen: false)
                  //         .searchTable(val.toString());
                  //   },
                  //   decoration: InputDecoration(
                  //       prefixIcon: Icon(
                  //         Icons.search,
                  //         color: Colors.blue,
                  //       ),
                  //       suffixIcon: IconButton(
                  //         icon: new Icon(Icons.cancel),
                  //         onPressed: () {
                  //           seacrh.clear();
                  //           Provider.of<Controller>(context, listen: false)
                  //               .searchTable("");
                  //         },
                  //       ),
                  //       hintText: "Search Table..."),
                  // ),
                  const SizedBox(
                    height: 15,
                  ),
                  value.isSearch
                      ? tableWidget(size, value.filteredlist)
                      : tableWidget(size, value.tabllistCAT)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

// ItemList(catlId: map["catid"],catName: map["catname"],)
/////////////////////////////////////////////////////////////////
  Widget tableWidget(Size size, List list) {
    return Consumer<Controller>(
      builder: (context, value, child) => value.isTableLoading
          ? Expanded(
              child: Align(
                alignment: Alignment.center,
                child: SpinKitCircle(
                  color: Colors.black,
                ),
              ),
            )
          : Expanded(
              child: list.length == 0
                  ? Container(
                      height: size.height * 0.7,
                      child: Center(
                          child: Lottie.asset("assets/noitem.json",
                              height: size.height * 0.3)))
                  : GridView.builder(
                      shrinkWrap: true,
                      // physics: const ScrollPhysics(),
                      itemCount: value.isSearch
                          ? value.filteredlist.length
                          : value.tabllistCAT.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8),
                      itemBuilder: (context, index) => Container(
                        decoration: BoxDecoration(
                            color: list[index]["STATUS"] == 1
                                ? Color.fromARGB(255, 230, 167, 167)
                                : Colors.white,
                            border: Border.all(color: Colors.black45),
                            borderRadius: BorderRadius.circular(10)),
                        child: InkWell(
                          onLongPress: () async {
                            await Provider.of<Controller>(context,
                                    listen: false)
                                .viewTableItems(
                                    context,
                                    list[index]["Table_Name"]
                                        .toString()
                                        .trimLeft(),
                                    0);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Column(
                                    children: [
                                      Text(
                                          'Pending Orders( ${value.tableItemList.length} )',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromARGB(
                                                255, 111, 128, 228),
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
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  " ${value.tableItemList[index]['Item'].toString().trimLeft().toUpperCase()}",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                            await value.setTableID(
                                list[index]["Table_ID"].toString().trimLeft(),
                                list[index]["Table_Name"].toString().trimLeft(),
                                context);
                            await Provider.of<Controller>(context,
                                    listen: false)
                                .getCartNo(context);
                            CustomSnackbar snackbar = CustomSnackbar();
                            snackbar.showSnackbar(
                                context,
                                "Table ${value.tablname.toString().trimLeft().toUpperCase()} Selected.",
                                "");

                            setState(() {});
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Expanded(
                              //   child: Image.asset(
                              //     "assets/sweets.png",
                              //     height: size.height * 0.09,
                              //     width: size.width * 0.15,
                              //     // fit: BoxFit.contain,
                              //   ),
                              // ),
                              Container(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8),
                                  child: Text(
                                    list[index]["Table_Name"]
                                        .toString()
                                        .trimLeft(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              // Divider(color: Colors.black,)
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
