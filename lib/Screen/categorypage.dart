import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_kot/Screen/itemlistpage.dart';
import 'package:restaurent_kot/controller/controller.dart';

class CategoryScreen extends StatefulWidget {
  String? tablId;
  CategoryScreen({super.key, required this.tablId});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  TextEditingController seacrh = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(widget.tablId.toString());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.table_bar_outlined),
              SizedBox(
                width: 5,
              ),
              Text(
                "Table : ${widget.tablId.toString()}",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
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
                      .searchCat(val);
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
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                    hintText: "Search Category...",
                    
                    ),
              ),
              SizedBox(
                height: 15,
              ),
              value.isSearch
                  ? categoryWidget(size, value.filteredlist)
                  : categoryWidget(size, value.catlist)
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryWidget(Size size, List list) {
    return Consumer<Controller>(
      builder: (context, value, child) => Expanded(
        child: list.length == 0
            ? Container(
                // height: size.height * 0.7,
                child: Center(child: Text("no data")))
            : GridView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: value.isSearch
                    ? value.filteredlist.length
                    : value.tabllist.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ItemList(
                                catlId: list[index]["catid"],
                                catName: list[index]["catname"],
                              )),
                    );
                  },
                  child: Card(
                    color: Colors.grey[200],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                            child: Text(
                              list[index]["catname"].toString(),
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
