import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_kot/Screen/itemwidget.dart';
import 'package:restaurent_kot/controller/controller.dart';

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
        backgroundColor: Colors.white,
        // Theme.of(context).primaryColor,
        title: Text(
          "${widget.catName.toString().toUpperCase()}",
          style: TextStyle(
              color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          Consumer<Controller>(
            builder: (context, value, child) => Card(
             shape: StadiumBorder(),
              color: Colors.black,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                 "Table : ${value.tablID.toString().toUpperCase()}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
          height: 55,
          width: size.width,
          decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: Consumer<Controller>(
            builder: (context, value, child) => TextButton(
                onPressed: () {},
                child: Text(
                  "ADD ${value.itemcount.toInt()} ITEM TO BAG",
                  style: const TextStyle(color: Colors.black),
                )),
          )
          ),
      body: Consumer<Controller>(
        builder: (context, value, child) => value.isLoading
            ? SpinKitCircle(
                color: Colors.black,
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: seacrh,
                      //   decoration: const InputDecoration(,
                      onChanged: (val) {
                        Provider.of<Controller>(context, listen: false)
                            .searchItem(val);
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
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 18, vertical: 0),
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
