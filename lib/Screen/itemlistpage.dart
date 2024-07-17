import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_kot/Screen/cartpage.dart';
import 'package:restaurent_kot/Screen/itemwidget.dart';
import 'package:restaurent_kot/controller/controller.dart';
import 'package:badges/badges.dart' as badges;

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
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    print("catid====${widget.catlId}");
    print("catnm====${widget.catName}");

    return Scaffold(
      appBar: AppBar(
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
              builder: (context, value, child) => Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: badges.Badge(
                      badgeStyle: badges.BadgeStyle(badgeColor: Colors.black),
                      position: badges.BadgePosition.topEnd(top: -5, end: -10),
                      showBadge: true,
                      badgeContent: Text(
                        value.cartTotal.toString() ?? "0",
                        style: TextStyle(color: Colors.white),
                      ),
                      child: OutlinedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Colors.orangeAccent)),
                          onPressed: () {
                            Provider.of<Controller>(context, listen: false)
                                .viewCart(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartBag()),
                            );
                          },
                          child:
                              Icon(Icons.shopping_cart, color: Colors.white)),
                    ),
                  ))
        ],
      ),
      // bottomNavigationBar: Container(
      //     height: 55,
      //     width: size.width,
      //     decoration: BoxDecoration(
      //         color: Colors.amber,
      //         borderRadius: BorderRadius.only(
      //             topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      //     child: Consumer<Controller>(
      //       builder: (context, value, child) => TextButton(
      //           onPressed: () {},
      //           child: Text(
      //             "ADD ${value.itemcount.toInt()} ITEM TO BAG",
      //             style: const TextStyle(color: Colors.black),
      //           )),
      //     )),
      body: Consumer<Controller>(
        builder: (context, value, child) => value.isLoading
            ? SpinKitCircle(
                color: Colors.black,
              )
            : Column(
                children: [
                  Container(
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
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.0),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                        // filled: true,
                        hintStyle: TextStyle(color: Colors.black, fontSize: 13),
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
                          list: value.itemlist, catId: widget.catlId.toString())
                ],
              ),
      ),
    );
  }
}
