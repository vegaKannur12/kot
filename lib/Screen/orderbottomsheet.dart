import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_kot/controller/controller.dart';

class OrderBottomSheet {
  // String? selected;
  ValueNotifier<bool> visible = ValueNotifier(false);
  showorderMoadlBottomsheet(
    List<Map<String, dynamic>> list,
    BuildContext context,
    Size size,
    int index,
    TextEditingController dec_ctrl,
    String? date,
  ) async {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          print("param---$index--");

          return Consumer<Controller>(
            builder: (context, value, child) {
              return SingleChildScrollView(
                child: Container(
                  // height: size.height * 0.96,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: value.isLoading
                        ? SpinKitFadingCircle(color: Colors.black)
                        : Column(
                            // mainAxisSize:MainAxisSize.min ,
                            // spacing: 5,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.close,
                                          color: Colors.black)),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        list[index]["Product"]
                                            .toString().trimLeft()
                                            .toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Divider(
                                      thickness: 2,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15, bottom: 18),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "\u{20B9}${list[index]["SRATE"].toStringAsFixed(2)}",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              value.response[index] = 0;

                                              Provider.of<Controller>(context,
                                                      listen: false)
                                                  .setQty(1.0, index, "dec");
                                            },
                                            child: Icon(
                                              Icons.remove,
                                              color: Colors.red,
                                            )),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 5, right: 5,top: 5,
                                              bottom: 5),
                                          width: size.width * 0.14,
                                          // height: size.height * 0.05,
                                          child: TextField(
                                            onTap: () {
                                              value.qty[index].selection =
                                                  TextSelection(
                                                      baseOffset: 0,
                                                      extentOffset: value
                                                          .qty[index]
                                                          .value
                                                          .text
                                                          .length);
                                            },
                                            onSubmitted: (val) {
                                              value.response[index] = 0;
                                              // Provider.of<Controller>(context,
                                              //         listen: false)
                                              // .updateCart(
                                              //         context,
                                              //         widget.list[index],
                                              //         date!,
                                              //         value.customerId.toString(),
                                              //         double.parse(val),
                                              //         index,
                                              //         "from itempage",
                                              //         0,
                                              //         widget.catId);
                                            },
                                            onChanged: (val) {
                                              value.response[index] = 0;
                                            },
                                            controller: value.qty[index],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600),
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.all(3),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: Colors
                                                        .grey), //<-- SEE HERE
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: Colors
                                                        .grey), //<-- SEE HERE
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                            onTap: () {
                                              value.response[index] = 0;
                                              Provider.of<Controller>(context,
                                                      listen: false)
                                                  .setQty(1.0, index, "inc");
                                            },
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.green,
                                            )),
                                      ],
                                    )
                                    // Spacer(),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15, bottom: 18),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                        onTap: () async {
                                          await showDialog(barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content: TextField(
                                                    controller: dec_ctrl,
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  actions: <Widget>[
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context,
                                                                  rootNavigator:
                                                                      true)
                                                              .pop(false);
                                                        },
                                                        child: Text('Cancel')),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                  //          Provider.of<Controller>(context,
                                                  //     listen: false)
                                                  // .setDescr(value.descr[index].text.toString(),index);
                                                          Navigator.of(context,
                                                                  rootNavigator:
                                                                      true)
                                                              .pop(false);
                                                        },
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
                                            Text(
                                              "Add Instructions",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ],
                                        )),
                                    // widget.list[index]["Pkg"] == null ||
                                    //       widget.list[index]["Pkg"] == ""
                                    //   ? Container()
                                    //   : Container(
                                    //       decoration: BoxDecoration(
                                    //         color: Color.fromARGB(
                                    //             255, 235, 234, 234),
                                    //         borderRadius:
                                    //             BorderRadius.circular(10),
                                    //         // border: Border.all(
                                    //         //     color: Colors.red)
                                    //       ),
                                    //       child: Padding(
                                    //         padding: const EdgeInsets.only(
                                    //             left: 8.0,
                                    //             right: 8,
                                    //             bottom: 4,
                                    //             top: 4),
                                    //         child: Text(
                                    //           "Pkg :${widget.list[index]["Pkg"]}",
                                    //           style: TextStyle(
                                    //               fontWeight: FontWeight.bold,
                                    //               color: Colors.black),
                                    //         ),
                                    //       ),
                                    //     ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15, bottom: 18),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: size.width * 0.4,
                                      child: ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white),
                                          onPressed: value.response[index] > 0
                                              ? null
                                              : () {
                                                  Provider.of<Controller>(
                                                          context,
                                                          listen: false)
                                                      .updateCart(
                                                    context,
                                                    list[index],
                                                    date!,
                                                    double.parse(
                                                        value.qty[index].text),dec_ctrl.text,
                                                    // value.descr[index].text,
                                                    index,
                                                    "from itempage",
                                                    0,
                                                  );
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop(false);
                                                },
                                          // icon: value.response[index] > 0
                                          //     ? Icon(Icons.done)
                                          //     : Icon(Icons.shopping_cart),
                                          label: value.isAdded[index]
                                              ? SpinKitThreeInOut(
                                                  color: Colors.black,
                                                  size: 12,
                                                )
                                              : value.response[index] > 0
                                                  ? Text("Added")
                                                  : Text("ADD")),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              );
            },
          );
        });
  }

  //////////////////
  // dropDownUnit(
  //   Size size,
  //   int index,
  // ) {
  //   double qty;
  //   return Consumer<Controller>(
  //     builder: (context, value, child) {
  //       // value.selectedunit_X001 = null;
  //       // selected=null;
  //       print(
  //           "value.prUnitSaleListData2----${value.prUnitSaleListData2}----$index--${value.selectedItem}");
  //       return Padding(
  //         padding: const EdgeInsets.only(left: 0, right: 0),
  //         child: Container(
  //           width: size.height * 0.2,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(10.0),
  //             border: Border.all(
  //                 color: P_Settings.blue1,
  //                 style: BorderStyle.solid,
  //                 width: 0.4),
  //           ),
  //           child: DropdownButton<String>(
  //             isExpanded: true,
  //             value: value.selectedItem,
  //             // isDense: true,
  //             hint: Padding(
  //               padding: const EdgeInsets.all(10.0),
  //               child: Text(value.frstDropDown.toString()),
  //               // child: Text(value.selectedunit_X001 == null
  //               //     ? "Select Unit"
  //               //     : value.selectedunit_X001.toString()),
  //             ),
  //             autofocus: true,
  //             underline: SizedBox(),
  //             elevation: 0,

  //             items: value.prUnitSaleListData2
  //                 .map((item) => DropdownMenuItem<String>(
  //                     value: item.toString(),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             item.toString(),
  //                             style: TextStyle(fontSize: 14),
  //                           ),
  //                         ),
  //                       ],
  //                     )))
  //                 .toList(),
  //             onChanged: (item) {
  //               print("clicked");
  //               if (item != null) {
  //                 Provider.of<Controller>(context, listen: false).fromDb =
  //                     false;
  //                 value.selectedItem = item;

  //                 value.setUnitOrder_X001(value.selectedItem!, index);
  //                 print("ratjhd------${value.calculatedRate}");
  //                 if (value.qty[index].text == null ||
  //                     value.qty[index].text.isEmpty) {
  //                   qty = 1;
  //                 } else {
  //                   qty = double.parse(value.qty[index].text);
  //                   // Provider.of<Controller>(context, listen: false)
  //                   //     .calculateOrderNetAmount(
  //                   //   index,
  //                   //   value.calculatedRate!,
  //                   //   double.parse(value.qty[index].text),
  //                   // );
  //                 }
  //               }
  //             },
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
