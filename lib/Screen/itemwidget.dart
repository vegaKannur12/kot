import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_kot/Screen/cartpage.dart';
import 'package:restaurent_kot/components/sizeScaling.dart';
import 'package:restaurent_kot/controller/controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemWidget extends StatefulWidget {
  List<Map<String, dynamic>> list;
  String catId;
  ItemWidget({required this.list, required this.catId});

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
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
                      height: 180,
                      decoration: BoxDecoration(
                          color: Colors.green[20],
                          borderRadius: BorderRadius.circular(13)),
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.list[index]["pname"]
                                    .toString()
                                    .toUpperCase(),
                                textScaleFactor:
                                    ScaleSize.textScaleFactor(context),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Theme.of(context).primaryColor),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\u{20B9} ${widget.list[index]["rate"].toString()}',
                                textScaleFactor:
                                    ScaleSize.textScaleFactor(context),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
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
                                                onTap: ()  {
                                                  // value.response[index] = 0;
                                                 

                                                  value
                                                      .totalItemCount(value.qty[index].text,"dec");
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
                                                  onSubmitted: (val) {
                                                    // value.response[index] = 0;
                                                    // Provider.of<Controller>(context,
                                                    //         listen: false)
                                                    //     .updateCart(
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
                                                    // value.itemcount=value.itemcount+double.parse(value.qty[index].text);
                                                     value
                                                      .totalItemCount(value.qty[index].text,"inc");
                                                    // value.response[index] = 0;
                                                  },
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
                            height: 10,
                          ),
                          Row(
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
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            color: Colors.black45,
                          )
                        ],
                      ),
                    );
                  })),
    );
  }
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
