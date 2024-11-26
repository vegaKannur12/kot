import 'package:flutter/material.dart';
import 'package:restaurent_kot/db_helper.dart';

class TableList extends StatefulWidget {
  final List<Map<String, dynamic>> list;
  TableList({required this.list});

  @override
  State<TableList> createState() => _TableListState();
}

class _TableListState extends State<TableList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("List Of tables")),
      body: ListView.builder(
        itemCount: widget.list.length,
        itemBuilder: ((context, index) {
          return ListTile(
            title: Text(widget.list[index]["name"]),
            onTap: () async { 
              List<Map<String, dynamic>> list = await KOT.instance
                  .getTableData(widget.list[index]["name"]);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TableContent(
                          tableName: widget.list[index]["name"],
                          list: list,
                        )
                        ),
              );
            },
          );
        }),
      ),
    );
  }
}

/////////////////////////////////////////////
class TableContent extends StatefulWidget {
  String tableName;
  List<Map<String, dynamic>> list;
  TableContent({required this.tableName, required this.list});
  @override
  State<TableContent> createState() => _TableContentState();
}

class _TableContentState extends State<TableContent> {
  String searchkey = "";
  bool isSearch = false;
  String hinttext = "";
  List<Map<String, dynamic>>? newList = [];

  onChangedValue(String value) {
    newList!.clear();

    print("value inside function ---${value}");
    setState(() {
      searchkey = value;
      if (value.isEmpty) {
        isSearch = false;
      } else {
        isSearch = true;
        if (widget.tableName == "registrationTable") {
          newList = widget.list
              .where((cat) =>
                  cat["cid"].toUpperCase().contains(value.toUpperCase()))
              .toList();
        } else if (widget.tableName == "staffDetailsTable") {
          newList = widget.list
              .where((cat) =>
                  cat["sid"].toUpperCase().contains(value.toUpperCase()))
              .toList();
        } else if (widget.tableName == "areaDetailsTable") {
          newList = widget.list
              .where((cat) =>
                  cat["aid"].toUpperCase().contains(value.toUpperCase()))
              .toList();
        } else if (widget.tableName == "accountHeadsTable") {
          newList = widget.list
              .where((cat) =>
                  cat["hname"].toUpperCase().contains(value.toUpperCase()))
              .toList();
        } else if (widget.tableName == "productDetailsTable") {
          newList = widget.list
              .where((cat) =>
                  cat["tax"].toUpperCase().contains(value.toUpperCase()))
              .toList();
        }
      }
    });
    print("new list---${newList}");
  }

  @override
  void initState() 
  {
    // TODO: implement initState
    super.initState();
    if (widget.tableName == "registrationTable") {
      hinttext = "search with cid";
    } else if (widget.tableName == "staffDetailsTable") {
      hinttext = "search with sid";
    } else if (widget.tableName == "areaDetailsTable") {
      hinttext = "search with aid";
    } else if (widget.tableName == "accountHeadsTable") {
      hinttext = "search with hname";
    }
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Table Content---${widget.tableName}"),
      ),
      body: 
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 60,
              child: TextField(
                onChanged: (value) {
                  onChangedValue(value);
                },
                decoration: InputDecoration(
                  hintText: hinttext,
                  prefixIcon: Icon(Icons.search),
                  // suffix: ElevatedButton(child: Text("search"),
                  // onPressed: (){

                  // },)
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: isSearch ? newList!.length : widget.list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(isSearch
                      ? newList![index].toString()
                      : widget.list[index].toString()),
                );
              },
            ),
          ),
        ],
      ),
      
      // body:
      // SingleChildScrollView(
      // scrollDirection: Axis.horizontal,
      // child: DataTable(
      //   columns: [
      //     DataColumn(label: Text("id")),
      //     DataColumn(label: Text("barcode")),
      //     DataColumn(label: Text("time")),
      //     DataColumn(label: Text("qty")),
      //     DataColumn(label: Text("")),

      //     // DataColumn(label: Text("id")),
      //   ],
      //   rows: widget.list
      //       .map(
      //         (e) => DataRow(cells: [
      //           DataCell(Text(e["id"].toString())),
      //           DataCell(Text(e["barcode"].toString())),
      //           DataCell(Text(e["time"].toString())),
      //           DataCell(TextField()),
      //           // DataCell(Text(e["qty"].toString())),
      //           DataCell(Icon(Icons.delete)),
      //           // DataCell(TextField())

      //         ]),
      //       )
      //       .toList(),
      // ),
      // ),
    );
  }
}
