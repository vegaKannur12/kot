import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_kot/Screen/cartpage.dart';
import 'package:restaurent_kot/controller/controller.dart';

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
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: Container(
                        height: 220,
                        decoration: BoxDecoration(
                            color: Colors.green[20],
                            borderRadius: BorderRadius.circular(13)),
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.list[index]["pname"]
                                      .toString()
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Theme.of(context).primaryColor),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Quantity : '),
                                Text('Rate : '),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                maxLines: 3,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Description',
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                print("move to bag");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const CartBag()),
                                );
                              },
                              icon: Icon(
                                Icons.trolley,
                              ),
                              label: Text(
                                "Add to Bag",
                              ),
                              // style: ElevatedButton.styleFrom(
                              //   backgroundColor: Theme.of(context).primaryColor,
                              // ),
                            )
                          ],
                        ),
                      ),
                    );
                  })),
    );
  }
}
