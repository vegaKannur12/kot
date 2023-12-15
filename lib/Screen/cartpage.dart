import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_kot/controller/controller.dart';

class CartBag extends StatefulWidget {
  const CartBag({super.key});

  @override
  State<CartBag> createState() => _CartBagState();
}

class _CartBagState extends State<CartBag> {
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Consumer<Controller>(
          builder: (BuildContext context, Controller value, Widget? child) =>
              Text(
            "Your Cart ( ${value.cartItems.length} items)",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Consumer<Controller>(
        builder: (context, value, child) => value.isCartLoading
            ? SpinKitCircle(
                color: Colors.black,
              )
            : value.cartItems.length == 0
                ? Container(
                    height: size.height * 0.7,
                    child: Center(
                        child: Lottie.asset("assets/cart.json",
                            height: size.height * 0.3)))
                : ListView.builder(
                    itemCount: value.cartItems.length,
                    itemBuilder: (context, int index) {
                      // return cartItems(index, size, value.cartItems[index]);
                      return customCard(index, size, value.cartItems[index]);
                    }),
      ),
    );
  }

//////////////////////////////////////////////////////////////////
  Widget customCard(int index, Size size, Map map) {
    return Consumer<Controller>(
        builder: (context, value, child) => Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                            child: Text(
                          "product name",
                          // "${map["Prod_Name"].toUpperCase()} ( ${map["Cart_Batch"]} )",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 2, 131, 236)),
                        )),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            map["Pkg"] == null || map["Pkg"].isEmpty
                                ? Container()
                                : Text("Pkg    : "),
                            map["Pkg"] == null || map["Pkg"].isEmpty
                                ? Container()
                                : Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 235, 234, 234),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0,
                                          right: 8,
                                          bottom: 4,
                                          top: 4),
                                      child: Text(
                                        "pakage",
                                        // map["Pkg"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                        Row(
                          children: [
                            map["Cart_Unit"] == null || map["Cart_Unit"].isEmpty
                                ? Container()
                                : Text("Unit : "),
                            map["Cart_Unit"] == null || map["Cart_Unit"].isEmpty
                                ? Container()
                                : Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 250, 205, 220),
                                      borderRadius: BorderRadius.circular(10),
                                      // border: Border.all(color: Colors.green)
                                      // color: Colors.yellow,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0,
                                          right: 8,
                                          bottom: 4,
                                          top: 4),
                                      child: Text(
                                        "cart unit",
                                        // "${map["Cart_Unit"]}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            // Text("Srate : "),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(255, 238, 221, 71),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8, bottom: 4, top: 4),
                                child: Text(
                                  "cart rate",
                                  // "\u{20B9}${map["Cart_Rate"].toStringAsFixed(2)}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            InkWell(
                                onTap: () async {
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .setQty(1.0, index, "dec");
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .updateCart(
                                          context,
                                          map,
                                          date!,
                                          value.customerId.toString(),
                                          double.parse(value.qty[index].text),
                                          index,
                                          "from cart",
                                          0,
                                          '');

                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .viewCart(
                                    context,
                                    value.customerId.toString(),
                                  );
                                },
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.red,
                                )),
                            Container(
                              margin: EdgeInsets.only(left: 7, right: 7),
                              width: size.width * 0.14,
                              height: size.height * 0.05,
                              child: TextField(
                                onTap: () {
                                  value.qty[index].selection = TextSelection(
                                      baseOffset: 0,
                                      extentOffset:
                                          value.qty[index].value.text.length);
                                },
                                onSubmitted: (val) {
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .updateCart(
                                          context,
                                          map,
                                          date!,
                                          value.customerId.toString(),
                                          double.parse(val),
                                          index,
                                          "from cart",
                                          0,
                                          "");

                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .viewCart(
                                    context,
                                    value.customerId.toString(),
                                  );
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
                                        color: Colors.grey), //<-- SEE HERE
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.grey), //<-- SEE HERE
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                                onTap: () {
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .setQty(1.0, index, "inc");

                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .updateCart(
                                          context,
                                          map,
                                          date!,
                                          value.customerId.toString(),
                                          double.parse(value.qty[index].text),
                                          index,
                                          "from cart",
                                          0,
                                          "");

                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .viewCart(
                                    context,
                                    value.customerId.toString(),
                                  );
                                },
                                child: Icon(
                                  Icons.add,
                                  color: Colors.green,
                                )),
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("Total : "),
                            Text(
                              "total",
                              // "\u{20B9}${map["It_Total"].toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                        InkWell(
                            onTap: () async {
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content:
                                          Text('Delete ${map["Prod_Name"]}?'),
                                      actions: <Widget>[
                                        new TextButton(
                                          onPressed: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop(
                                                    false); // dismisses only the dialog and returns false
                                          },
                                          child: Text('No'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Provider.of<Controller>(context,
                                                    listen: false)
                                                .updateCart(
                                                    context,
                                                    map,
                                                    date!,
                                                    value.customerId.toString(),
                                                    double.parse(
                                                        value.qty[index].text),
                                                    index,
                                                    "from cart",
                                                    1,
                                                    "");
                                            Provider.of<Controller>(context,
                                                    listen: false)
                                                .viewCart(
                                              context,
                                              value.customerId.toString(),
                                            );
                                            Navigator.pop(context);
                                          },
                                          child: Text('Yes'),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Delete",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.close,
                                  size: 16,
                                  color: Colors.red,
                                )
                              ],
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ));
  }
}
