import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_kot/Screen/home.dart';
import 'package:restaurent_kot/Screen/itemlistpage.dart';
import 'package:restaurent_kot/controller/controller.dart';
import 'dart:io';

class CategoryScreen extends StatefulWidget {
  String? tablId;
  String? roomId;
  CategoryScreen({super.key, required this.tablId, required this.roomId});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  TextEditingController seacrh = TextEditingController();
  String? date;
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
  Widget build(BuildContext context) {
    print(widget.tablId.toString());
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => _handleBackPressed(context),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<Controller>(
            builder: (context, value, child) => Column(
              children: [
                TextFormField(
                  controller: seacrh,
                  //   decoration: const InputDecoration(,
                  onChanged: (val) {
                    Provider.of<Controller>(context, listen: false)
                        .searchCat(val.toString());
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: () {
                        seacrh.clear();
                        Provider.of<Controller>(context, listen: false)
                            .searchCat("");
                      },
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1.0),
                    ),
                    hintText: "Search Category...",
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                value.isSearch
                    ? categoryWidget(size, value.filteredlist,
                        value.tabl_ID.toString(), value.room_ID.toString())
                    : categoryWidget(size, value.catlist,
                        value.tabl_ID.toString(), value.room_ID.toString())
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget categoryWidget(Size size, List list, String tbl, String rm) {
    return Consumer<Controller>(
      builder: (context, value, child) => value.isCategoryLoading
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
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: value.isSearch
                          ? value.filteredlist.length
                          : value.catlist.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 12,
                              childAspectRatio: 1.5,
                              mainAxisSpacing: 12),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          value.setCatID(
                              list[index]["Cat_Id"].toString().trimLeft(),
                              context);
                          Provider.of<Controller>(context, listen: false)
                              .getItemList(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ItemList(
                                      catlId: list[index]["Cat_Id"],
                                      catName: list[index]["Cat_Name"],
                                      // tablId: tbl,roomId: rm,
                                    )),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black45),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8),
                                  child: Center(
                                    child: Text(
                                      maxLines: 2,
                                      list[index]["Cat_Name"]
                                          .toString()
                                          .trimLeft()
                                          .toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
    );
  }
}

Future<bool> _handleBackPressed(BuildContext context) async {
  final cartNotEmpty =
     await Provider.of<Controller>(context, listen: false).cartItems.isNotEmpty;
  if (cartNotEmpty) {
    return await _onBackPressed(context);
  } else {
     await Provider.of<Controller>(context, listen: false)
                  .clearAllData(context);
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
            onPressed: () async{
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