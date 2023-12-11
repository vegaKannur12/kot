import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_kot/Screen/categorypage.dart';
import 'package:restaurent_kot/controller/controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? date;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    date = DateFormat('dd-MMM-yyyy').format(DateTime.now());
  }

  TextEditingController seacrh = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.calendar_month),
              SizedBox(
                width: 15,
              ),
              Text(
                date.toString(),
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
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
                      .searchTable(val);
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.blue,
                  ),
                  suffixIcon: IconButton(
                    icon: new Icon(Icons.cancel),
                    onPressed: () {
                      seacrh.clear();
                      Provider.of<Controller>(context, listen: false)
                          .searchTable("");
                    },
                  ),
                  hintText: "Search Table..."
                ),
              ),
              SizedBox(
                height: 15,
              ),
              value.isSearch
                  ? tableWidget(size, value.filteredlist)
                  : tableWidget(size, value.tabllist)
            ],
          ),
        ),
      ),
    );
  }
// ItemList(catlId: map["catid"],catName: map["catname"],)
  Widget tableWidget(Size size, List list) {
    return Consumer<Controller>(
      builder: (context, value, child) => Expanded(
        child: list.length == 0
            ? Container(
                // height: size.height * 0.7,
                child: Center(
                    child: Text("no data")))
            :  GridView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount:
              value.isSearch ? value.filteredlist.length : value.tabllist.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CategoryScreen(tablId: list[index]["tid"].toString())),
              );
            },
            child: Card(
              color: Colors.grey[200],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Expanded(
                  //   child: Image.asset(
                  //     "assets/sweets.png",
                  //     height: size.height * 0.09,
                  //     width: size.width * 0.15,
                  //     // fit: BoxFit.contain,
                  //   ),
                  // ),
                  Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                      child: Text(
                        list[index]["tab"].toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                        overflow: TextOverflow.ellipsis,
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
