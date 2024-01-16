import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_kot/Screen/cartpage.dart';
import 'package:restaurent_kot/components/sizeScaling.dart';
import 'package:restaurent_kot/controller/controller.dart';
import 'package:restaurent_kot/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemWidget extends StatefulWidget {
  List<Map<String, dynamic>> list;
  String catId;
  ItemWidget({required this.list, required this.catId});

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  String? date;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    date = DateFormat('dd-MMM-yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(widget.list);
    return Consumer<Controller>(
      builder: (context, value, child) => Expanded(
          child: widget.list.length == 0
              ? Container(
                  // height: size.height * 0.7,
                  child: Center(child: Text("no data")))
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.list.length,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.green[20],
                          borderRadius: BorderRadius.circular(13)),
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  widget.list[index]["Product"]
                                      .toString()
                                      .toUpperCase(),
                                      maxLines: 2,
                                  textScaleFactor:
                                      ScaleSize.textScaleFactor(context),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,color: Color.fromARGB(255, 104, 40, 35)
                                      // color: Theme.of(context).primaryColor
                                      ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  widget.list[index]["Pkg"] == null ||
                                          widget.list[index]["Pkg"] == ""
                                      ? Container()
                                      : Container(
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 235, 234, 234),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            // border: Border.all(
                                            //     color: Colors.red)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0,
                                                right: 8,
                                                bottom: 4,
                                                top: 4),
                                            child: Text(
                                              widget.list[index]["Pkg"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                  widget.list[index]["Unit"] == null ||
                                          widget.list[index]["Unit"] == ""
                                      ? Container()
                                      : Container(
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 247, 208, 221),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            // border: Border.all(
                                            //     color: Colors.green)
                                            // color: Colors.yellow,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0,
                                                right: 8,
                                                bottom: 4,
                                                top: 4),
                                            child: Text(
                                              "${widget.list[index]["Unit"]}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                  Row(
                                    children: [
                                      // Text("Rs : "),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.yellow,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0,
                                              right: 8,
                                              bottom: 4,
                                              top: 4),
                                          child: Text(
                                            "\u{20B9}${widget.list[index]["Srate"].toStringAsFixed(2)}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                          Row(
                            
                            children: [
                              Text(
                                '\u{20B9} ${widget.list[index]["Srate"].toString()}',
                                textScaleFactor:
                                    ScaleSize.textScaleFactor(context),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  onTap: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: TextField(
                                              maxLines: 3,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            actions: <Widget>[
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pop(false);
                                                  },
                                                  child: Text('Cancel')),
                                              ElevatedButton(
                                                  onPressed: () {},
                                                  child: Text("Save"))
                                            ],
                                          );
                                        });
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 25,
                                        width: 18,
                                        child: Image.asset(
                                          "assets/instructions.png",
                                          fit: BoxFit.contain,
                                          width: 300,
                                          height: 300,
                                        ),
                                      ),
                                      Text("Add Instructions"),
                                    ],
                                  )),
                                  Container(
                                  height: 40,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: value.isAdded[index] == true
                                          ? Colors.red
                                          : Colors.grey[300],
                                      borderRadius: BorderRadius.circular(10)),
                                  child: value.isAdded[index] == true
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  // value.response[index] = 0;

                                                  // value
                                                  //     .totalItemCount(value.qty[index].text,"dec");
                                                  Provider.of<Controller>(
                                                          context,
                                                          listen: false)
                                                      .setQty(
                                                          1.0, index, "dec");
                                                },
                                                child: Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                )),
                                            Container(
                                              width: size.width * 0.14,
                                              height: size.height * 0.05,
                                              child: Center(
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none),
                                                  onTap: () {
                                                    value.qty[index].selection =
                                                        TextSelection(
                                                            baseOffset: 0,
                                                            extentOffset: value
                                                                .qty[index]
                                                                .value
                                                                .text
                                                                .length);
                                                    print("couuuuuuu..........${value.qty[index].text}");
                                                  },
                                                  // onSubmitted:
                                                  // (val) {
                                                  //   // value.response[index] = 0;
                                                  // setState(() {

                                                  //    Provider.of<Controller>(context,
                                                  //           listen: false)
                                                  //       .addToBag(
                                                  //           context,
                                                  //           widget.list[index],
                                                  //           date!,
                                                  //           value.tablID.toString(),
                                                  //           widget.catId,
                                                  //           double.parse(val),
                                                  //           index,
                                                  //           "from itempage",
                                                  //           0);
                                                  // });
                                                  // },
                                                  onChanged: (val) {
                                                    setState(() {
                                                       print("txtttttttttttttt$val");
                                                    });
                                                   
                                                    // value.response[index] = 0;
                                                    // setState(() async {
                                                    //   await KOT.instance
                                                    //       .insertorderBagTab(
                                                    //     value.tablID.toString(),
                                                    //     widget.list[index],
                                                    //     double.parse(val),
                                                    //   );
                                                      // await Provider.of<
                                                      //             Controller>(
                                                      //         context,
                                                      //         listen: false)
                                                      //     .addToBag(
                                                      //         context,
                                                      //         widget
                                                      //             .list[index],
                                                      //         date!,
                                                      //         value.tablID
                                                      //             .toString(),
                                                      //         widget.catId,
                                                      //         double.parse(val),
                                                      //         index,
                                                      //         "from itempage",
                                                      //         0);
                                                    // });
                                                  },
                                                  //  onTextChanged,
                                                  controller: value.qty[index],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  // value.response[index] = 0;
                                                  // Provider.of<Controller>(
                                                  //         context,
                                                  //         listen: false)
                                                  //     .totalItemCount("inc");
                                                  Provider.of<Controller>(
                                                          context,
                                                          listen: false)
                                                      .setQty(
                                                          1.0, index, "inc");
                                                },
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                )),
                                          ],
                                        )
                                      : TextButton(
                                          onPressed: () {
                                            value.isAdded[index] = true;
                                            setState(() {});
                                          },
                                          child: Text(
                                            "ADD",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          )))
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(thickness: 2,
                            color: Colors.black45,
                          )
                        ],
                      ),
                    );
                  })),
    );
  }

  void onTextChanged(String value) {
    // Your custom logic goes here
    print('TextField value changed: $value');
  }
  // textfldchange(int index, Map<String, dynamic> list, String tablID,
  //     String catId, String s, int i) {
  //   Provider.of<Controller>(context, listen: false).addToBag(
  //       context,
  //       list,
  //       date!,
  //       tablID,
  //       catId,
  //       double.parse(val),
  //       index,
  //       s,
  //       i);
  // }
}

class MyBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add Item to Cart',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          // Add your item selection widgets here
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Handle item selection
              Navigator.pop(context); // Close the bottom sheet
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Handle item selection
              Navigator.pop(context); // Close the bottom sheet
            },
          ),
          // Add more items as needed
        ],
      ),
    );
  }
}
