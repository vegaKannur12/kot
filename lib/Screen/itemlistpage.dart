import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_kot/Screen/cartpage.dart';
import 'package:restaurent_kot/Screen/itemwidget.dart';
import 'package:restaurent_kot/controller/controller.dart';
import 'package:badges/badges.dart' as badges;
import 'dart:io';

class ItemList extends StatefulWidget {
  String? catlId;
  String? catName;

  ItemList({super.key, required this.catlId, required this.catName});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  TextEditingController seacrh = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<Controller>(context, listen: false).getIDss();
    });
    // ModalRoute.of(context)?.addScopedWillPopCallback(() {
    // This callback runs when navigating back to this page
    // setState(() {
    // Provider.of<Controller>(context, listen: false).getItemList(context);
    //   // });
    //   return Future.value(true); // Return true to allow popping
    // });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    print("catid====${widget.catlId}");
    print("catnm====${widget.catName}");

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () async{
           await Provider.of<Controller>(context, listen: false).viewCart(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartBag()),
            ).then((value) {
              // This code runs when returning from the NextScreen
              // You can put your refresh logic here
              setState(() {
                Provider.of<Controller>(context, listen: false)
                    .getItemList(context);
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
                    padding: EdgeInsets.only(right: 10),
                    child: badges.Badge(
                      badgeStyle: badges.BadgeStyle(badgeColor: Colors.black),
                      position:
                          badges.BadgePosition.topEnd(top: -14, end: -15),
                      showBadge: true,
                      badgeContent: Text(
                        value.cartTotal.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      child: Icon(Icons.shopping_cart, color: Colors.white),
                    ),
                  ))),
      appBar: AppBar(
          title:  Container(
                  width: double.infinity,
                  height: 50,
                  color: Color.fromARGB(255, 139, 200, 228),
                  child: Center(
                    child: Text(
                      "${widget.catName.toString().toUpperCase()}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
        leading: IconButton(
            onPressed: () {
              // Provider.of<Controller>(context, listen: false).viewCart(
              //   context,
              //   value.customerId.toString(),
              // );
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        backgroundColor: Color.fromARGB(255, 139, 200, 228),
        // Theme.of(context).primaryColor,
    
        actions: [
          Consumer<Controller>(
            builder: (context, value, child) => Card(
              shape: const StadiumBorder(),
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "${value.tabl_name.toString().toUpperCase()} ${value.room_nm.toString().toUpperCase() == "" || value.room_nm.toString().toUpperCase().isEmpty || value.room_nm.toString().toUpperCase() == "NULL" ? "" : "/ ${value.room_nm.toString().toUpperCase()}"} / ${value.cart_id.toString()}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
          // Consumer<Controller>(
          //     builder: (context, value, child) => Padding(
          //           padding: EdgeInsets.only(right: 10),
          //           child: badges.Badge(
          //             badgeStyle: badges.BadgeStyle(badgeColor: Colors.black),
          //             position: badges.BadgePosition.topEnd(top: -5, end: -10),
          //             showBadge: true,
          //             badgeContent: Text(
          //               value.cartTotal.toString(),
          //               style: TextStyle(color: Colors.white),
          //             ),
          //             child: OutlinedButton(
          //                 style: ButtonStyle(
          //                     backgroundColor: MaterialStatePropertyAll(
          //                         Colors.orangeAccent)),
          //                 onPressed: () {
          //                   Provider.of<Controller>(context, listen: false)
          //                       .viewCart(context);
          //                   Navigator.push(
          //                     context,
          //                     MaterialPageRoute(
          //                         builder: (context) => CartBag()),
          //                   );
          //                 },
          //                 child:
          //                     Icon(Icons.shopping_cart, color: Colors.white)),
          //           ),
          //         ))
        ],
      ),
      // bottomNavigationBar: Consumer<Controller>(
      //   builder: (context, value, child) => Row(mainAxisAlignment: MainAxisAlignment.end,
      //     children: [
      //       FloatingActionButton(
      //           onPressed: () {},
      //           child: Text(
      //             "VIEW",
      //             style: const TextStyle(color: Colors.black),
      //           )),
      //     ],
      //   ),
      // ),
      body: Consumer<Controller>(
        builder: (context, value, child) => value.isLoading
            ? SpinKitCircle(
                color: Colors.black,
              )
            : Column(
                children: [
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: seacrh,
                      //   decoration: const InputDecoration(,
                      onChanged: (val) {
                        Provider.of<Controller>(context, listen: false)
                            .searchItem(val.toString());
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        suffixIcon: IconButton(
                          icon: new Icon(Icons.cancel),
                          onPressed: () {
                            seacrh.clear();
                            Provider.of<Controller>(context, listen: false)
                                .searchItem("");
                          },
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                              color: Colors.black, width: 1.0),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                              color: Colors.blue, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                        // filled: true,
                        hintStyle:
                            TextStyle(color: Colors.black, fontSize: 13),
                        hintText: "Search Item here.. ",
                        // fillColor: Colors.grey[100]
                      ),
                    ),
                  ),
                  value.isSearch
                      ? ItemWidget(
                          list: value.filteredlist,
                          catId: widget.catlId.toString(),
                        )
                      : ItemWidget(
                          list: value.itemlist,
                          catId: widget.catlId.toString())
                ],
              ),
      ),
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
