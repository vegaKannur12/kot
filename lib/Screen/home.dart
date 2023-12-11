import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_kot/controller/controller.dart';
import 'package:restaurent_kot/model/customer_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
   String? date;
  late CustomerModel selectedItem;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    date = DateFormat('dd-MMM-yyyy').format(DateTime.now());
    selectedItem = CustomerModel();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<Controller>(context, listen: false).initDb(context, "");
      Provider.of<Controller>(context, listen: false).getOs();
    });
  }

  TextEditingController cusCon = TextEditingController();
  List customerList = ["haiiii", "hoyyyy", "hsbhbf"];
  String? selected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Container(),
    );
  }
}