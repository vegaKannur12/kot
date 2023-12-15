import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_kot/Screen/cartpage.dart';
import 'package:restaurent_kot/components/sizeScaling.dart';
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
                        height: 250,
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
                                  textScaleFactor:
                                      ScaleSize.textScaleFactor(context),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.green),
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
                                  'Quantity : ',
                                  textScaleFactor:
                                      ScaleSize.textScaleFactor(context),
                                ),
                                Text(
                                  'Rate : ${widget.list[index]["rate"].toString()}',
                                  textScaleFactor:
                                      ScaleSize.textScaleFactor(context),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: SizedBox(height: 100,
                                child: TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                    labelText: 'Description',
                                  ),
                                  style:TextStyle(overflow: TextOverflow.ellipsis),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.trolley),
                                label: Text(
                                  "Add to Bag",
                                  textScaleFactor:
                                      ScaleSize.textScaleFactor(context),
                                ))
                          ],
                        ),
                      ),
                    );
                  })),
    );
  }
}
