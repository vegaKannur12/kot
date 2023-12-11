import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
print(widget.list);
    return Consumer<Controller>(
      builder: (context, value, child) => Expanded(
        child: widget.list.length == 0
            ? Container(
                // height: size.height * 0.7,
                child: Center(
                    child: Text("no data")))
            : ListView.builder(
              shrinkWrap: true,
              itemCount: widget.list.length,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
              return SizedBox(
                width: 250,
                child: ListTile(title: Text(widget.list[index]["pname"].toString()),));
            })
      ),
    );
  }
}