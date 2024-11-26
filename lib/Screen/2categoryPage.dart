import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:restaurent_kot/Screen/cartpage.dart';
import 'package:restaurent_kot/Screen/home.dart';
import 'package:restaurent_kot/Screen/orderbottomsheet.dart';
import 'package:restaurent_kot/controller/controller.dart';
import 'package:badges/badges.dart' as badges;

class CatTEST extends StatefulWidget {
  String? tablId;
  String? roomId;
  CatTEST({super.key, required this.tablId, required this.roomId});

  @override
  State<CatTEST> createState() => _CatTESTState();
}

class _CatTESTState extends State<CatTEST> {
  TextEditingController seacrh = TextEditingController();
  TextEditingController seacrhcat = TextEditingController();
  String? date;
  int? selectedIndex;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<Controller>(context, listen: false).getIDss();
    });
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<Controller>(context, listen: false).getCategoryList(context);
    //   //tempry adding qty
    // });
    date = DateFormat('dd-MMM-yyyy').format(DateTime.now());
  }

  @override
  void dispose() {
    seacrh.dispose();
    seacrhcat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => _handleBackPressed(context),
      child: Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 48, 54, 90),
            onPressed: () async {
              await Provider.of<Controller>(context, listen: false)
                  .viewCart(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartBag()),
              ).then((value) {
                // This code runs when returning from the NextScreen
                // You can put your refresh logic here
                setState(() {
                  Provider.of<Controller>(context, listen: false)
                      .getItemList(context);
                  Provider.of<Controller>(context, listen: false)
                      .viewCart(context);
                  // Update data or perform actions to refresh the page
                });
              });
              // Navigator.of(context).push(
              //   PageRouteBuilder(
              //       opaque: false, // set to false
              //       pageBuilder: (_, __, ___) => CartBag()),
              // );
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => CartBag()),
              // );
            },
            child: Consumer<Controller>(
              builder: (context, value, child) => Padding(
                padding: EdgeInsets.only(right: 8),
                child: badges.Badge(
                  badgeStyle: badges.BadgeStyle(badgeColor: Colors.black),
                  position: badges.BadgePosition.topEnd(top: -14, end: -15),
                  showBadge: true,
                  badgeContent: Text(
                    value.cartTotal.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  child: Icon(Icons.shopping_cart, color: Colors.white),
                ),
              ),
            ),
          ),
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                // Provider.of<Controller>(context, listen: false).viewCart(
                //   context,
                //   value.customerId.toString(),
                // );
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            // backgroundColor: Color.fromARGB(255, 139, 200, 228),
            backgroundColor: Color.fromARGB(255, 69, 79, 134),
            // Theme.of(context).primaryColor,
            actions: [
              Consumer<Controller>(
                builder: (context, value, child) => Card(
                  shape: const StadiumBorder(),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      "${value.tabl_name.toString().toUpperCase()} ${value.room_nm.toString().toUpperCase() == "" || value.room_nm.toString().toUpperCase().isEmpty || value.room_nm.toString().toUpperCase() == "NULL" ? "" : "/ ${value.room_nm.toString().toUpperCase()}"} / ${value.cart_id.toString()}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
          body: Row(
            children: [
              Container(
                width: size.width * 1 / 3,
                color: Color.fromARGB(255, 204, 208, 231),
                child: Consumer<Controller>(builder: (context, value, child) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      categoryWidget(size, value.catlist,
                          value.tabl_ID.toString(), value.room_ID.toString())
                    ],
                  );
                }),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Consumer<Controller>(
                    builder: (context, value, child) => value.isLoading
                        ? SpinKitCircle(
                            color: Colors.black,
                          )
                        : Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              // Container(
                              //   width: double.infinity,
                              //   height: 50,
                              //   color: Color.fromARGB(255, 139, 200, 228),
                              //   child: Center(
                              //     child: Text(
                              //       "${widget.catName.toString().toUpperCase()}",
                              //       style: TextStyle(
                              //           color: Colors.white,
                              //           fontSize: 20,
                              //           fontWeight: FontWeight.bold),
                              //     ),
                              //   ),
                              // ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:
                                      const Color.fromARGB(241, 235, 236, 236),
                                ),
                                child: TextFormField(
                                  controller: seacrh,
                                  //   decoration: const InputDecoration(,
                                  onChanged: (val) {
                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .searchItem(val.toString());
                                  },
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: const Icon(
                                      Icons.search,
                                      color: Colors.black,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.cancel),
                                      onPressed: () {
                                        seacrh.clear();
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .searchItem("");
                                      },
                                    ),
                                    // contentPadding: const EdgeInsets.symmetric(
                                    //     horizontal: 5, vertical: 0),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black38),
                                      borderRadius: BorderRadius.circular(23),
                                    ),
                                    // border: OutlineInputBorder(
                                    //   borderRadius: BorderRadius.circular(20.0),
                                    //   borderSide: const BorderSide(
                                    //       color: Colors.black, width: 1.0),
                                    // ),
                                    // focusedBorder: UnderlineInputBorder(
                                    //   borderRadius: BorderRadius.circular(20.0),
                                    //   borderSide: const BorderSide(
                                    //       color: Colors.blue, width: 1.0),
                                    // ),
                                    // enabledBorder: OutlineInputBorder(
                                    //   borderRadius: BorderRadius.circular(20.0),
                                    //   borderSide:
                                    //       BorderSide(color: Colors.black, width: 1.0),
                                    // ),
                                    // filled: true,
                                    hintStyle: TextStyle(
                                        color: Colors.black, fontSize: 13),
                                    hintText: "Search Item here.. ",
                                    // fillColor: Colors.grey[100]
                                  ),
                                ),
                              ),
                              value.isSearch
                                  ? tblWidget(size, value.filteredlist, date!)
                                  : tblWidget(size, value.itemlist, date!)
                            ],
                          ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  categoryWidget(Size size, List list, String tbl, String rm) {
    String? cc = "";

    return Consumer<Controller>(builder: (context, value, child) {
      if (value.isCategoryLoading) {
        return Expanded(
          child: Align(
            alignment: Alignment.center,
            child: SpinKitCircle(
              color: Colors.black,
            ),
          ),
        );
      } else {
        return Expanded(
          child: list.isEmpty
              ? const Center(child: Text("no data"))
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount:
                      // value.isSearch
                      // ? value.filteredCatlist.length
                      // :
                      value.catlist.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.4,
                      mainAxisSpacing: 8),
                  itemBuilder: (context, index) {
                    bool isSelected = selectedIndex == index;
                    return GestureDetector(
                      onTap: () async {
                        setState(() {
                          selectedIndex = index;
                        });
                        print("sel, index=====$selectedIndex , $index");
                        await value.setCatID(
                            list[index]["Cat_Id"].toString().trimLeft(),
                            list[index]["Cat_Name"].toString().trimLeft(),
                            context);
                        // String selcat=list[index]["Cat_Id"].toString().trimLeft();

                        // SharedPreferences prefs =
                        //     await SharedPreferences.getInstance();
                        // setState(() {
                        //   cc = prefs.getString("CAT_id");
                        //   print("ccccccc---$cc");
                        // });
                        await Provider.of<Controller>(context, listen: false)
                            .getItemList(context);
                      },
                      child: AnimatedContainer(
                        //AnimatedSwitcher
                        width: isSelected ? 200 : 100,
                        height: isSelected ? 200 : 100,
                        // height: size.width >= 420 ? 150:120,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(10),

                          borderRadius:
                              BorderRadius.circular(isSelected ? 50 : 10),
                          //           color: isSelected
                          // ? Color.fromARGB(255, 255, 230, 128) // Highlighted color
                          // : Colors.white, // Default background color
                          color: isSelected
                              ? Color.fromARGB(
                                  255, 255, 230, 128) // Highlighted color
                              : Colors.white, // Default background color
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 232, 250, 72),
                                    blurRadius: 15,
                                    spreadRadius: 5,
                                  )
                                ]
                              : [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                  )
                                ],
                        ),
                        child: Stack(
                          children: [
                            Container(
                              height: size.width >= 420 ? 70 : 40,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 69, 79, 134),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10))),
                              child: Container(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 2, bottom: 2, left: 5),
                                  child: Text(
                                    maxLines: 1,
                                    list[index]["Cat_Name"]
                                        .toString()
                                        .trimLeft()
                                        .toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                            Positioned.fill(
                              top: size.width >= 420 ? 70 : 40,
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/food.jpg"),
                                      fit: BoxFit.fill),
                                  // color:
                                  //     isSelected

                                  //         ? Colors.red
                                  //         :
                                  //     Color.fromARGB(255, 237, 241, 241),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
        );
      }
    });
  }
}

Widget tblWidget(Size size, List<Map<String, dynamic>> list, String date
    // OrderBottomSheet cocosheet, String date
    ) {
  OrderBottomSheet cocosheet = OrderBottomSheet();
  return Consumer<Controller>(builder: (context, value, child) {
    return Expanded(
        child: list.length == 0
            ? Container(
                height: size.height * 0.7,
                child: Center(
                  child: Lottie.asset("assets/noitem.json",
                      height: size.height * 0.3),
                ),
              )
            : ResponsiveGridList(
                verticalGridSpacing: 0,
                horizontalGridSpacing: 5,
                minItemWidth: size.width / 1.2, //300
                minItemsPerRow: 1,
                // maxItemsPerRow: 2,
                children: List.generate(list.length, (index) {
                  String showrate;
                  value.table_rateID == 5
                      ? showrate = list[index]["SRATE"].toStringAsFixed(2)
                      : value.table_rateID == 6
                          ?
                          //  showrate ="50.0"
                          showrate = list[index]["SRATE1"].toStringAsFixed(2)
                          : showrate = list[index]["SRATE2"].toStringAsFixed(2);
                  return Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          selected: true,
                          minVerticalPadding: 5,
                          selectedTileColor: Colors.redAccent,
                          onTap: () {
                            cocosheet.showorderMoadlBottomsheet(
                                list, context, size, index, showrate, date);
                          },
                          contentPadding: EdgeInsets.only(left: 8.0, right: 0),
                          title: Text(
                            list[index]["Product"]
                                .toString()
                                .trimLeft()
                                .toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: const Color.fromARGB(255, 3, 100, 180)),
                          ),
                          subtitle: Text(
                            "\u{20B9}$showrate",
                            // "\u{20B9}${list[index]["SRATE"].toStringAsFixed(2)}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Divider()
                      ],
                    ),
                  );
                })));
  });
}

Future<bool> _handleBackPressed(BuildContext context) async {
  final cartNotEmpty = await Provider.of<Controller>(context, listen: false)
      .cartItems
      .isNotEmpty;
  if (cartNotEmpty) {
    return await _onBackPressed(context);
  } else {
    await Provider.of<Controller>(context, listen: false).clearAllData(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
    return false;
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
              Text('Your Cart will be cleared \nWant to proceed?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () async {
              await Provider.of<Controller>(context, listen: false)
                  .clearAllData(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));

              // exit(0);
            },
          ),
        ],
      );
    },
  );
}
