import 'dart:async';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:restaurent_kot/Screen/authentication/login.dart';
import 'package:restaurent_kot/Screen/home.dart';
import 'package:restaurent_kot/components/custom_snackbar.dart';
import 'package:restaurent_kot/components/external_dir.dart';
import 'package:restaurent_kot/model/customer_model.dart';
import 'package:restaurent_kot/model/registration_model.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sql_conn/sql_conn.dart';

import '../components/network_connectivity.dart';

class Controller extends ChangeNotifier {
  // int? cartId;
  String? fromDate;
  String? lastdate;
  String? customerId;
  double bal = 0.0;
  int? cartCount;
  String? cname;
  double sum = 0.0;
  bool isSearch = false;
  String? colorString;
  // List<CD> cD = [];
  List<Map<String, dynamic>> customerList = [];
  List<Map<String, dynamic>> filteredlist = [];
  List<Map<String, dynamic>> orderlist = [];
  List<Map<String, dynamic>> orderDetails = [];
  bool isOrderLoading = false;
  bool isfreez = false;
  List<Map<String, dynamic>> cartItems = [];
  bool isCartLoading = false;
  List<Map<String, dynamic>> categoryList = [];
  List<Map<String, dynamic>> itemList = [];
  List<TextEditingController> qty = [];
  bool isCusLoading = false;
  DateTime? sdate;
  DateTime? ldate;
  String? os;
  String? cName;
  List<Widget> calendarWidget = [];
  List<int> response = [];
  String? fp;
  String? cid;
  ExternalDir externalDir = ExternalDir();

  String? sof;
  String? branchname;
  String? selected;
  // ignore: prefer_typing_uninitialized_variables
  var jsonEncoded;
  String poptitle = "";
  bool isDbNameLoading = false;
  String? dashDate;
  DateTime d = DateTime.now();
  String? todate;

  bool isLoading = false;
  bool isReportLoading = false;

  String? appType;
  bool isdbLoading = true;

  // List<Map<String, dynamic>> filteredList = [];
  var result1 = <String, List<Map<String, dynamic>>>{};
  var resultList = <String, List<Map<String, dynamic>>>{};
  List<Map<String, dynamic>> list = [];
     List<Map<String, dynamic>> tabllist = [
    {"tab": "Table 1","tid":1},
    {"tab": "Table 2","tid":2},
    {"tab": "Table 3","tid":3},
    {"tab": "Table 4","tid":4},
    {"tab": "Table 5","tid":5},
  ];
  List<Map<String, dynamic>> catlist = [
    {"catid":"C1","catname":"Category1"},
    {"catid":"C2","catname":"Category2"},
    {"catid":"C3","catname":"Category3"},
    {"catid":"C4","catname":"Category4"},
    {"catid":"C5","catname":"Category5"},
    {"catid":"C6","catname":"Category6"},
    {"catid":"C7","catname":"Category7"},
  ];
   List<Map<String, dynamic>> itemlist = [
    {"catid":"C1","catname":"Category1","pname":"item1","rate":30.0},
    {"catid":"C1","catname":"Category1","pname":"item2","rate":30.0},
    {"catid":"C2","catname":"Category2","pname":"item4","rate":30.0},
    {"catid":"C2","catname":"Category2","pname":"item1","rate":30.0},
    {"catid":"C5","catname":"Category5","pname":"item1","rate":30.0},
    
  ];

  String? userName;
  String param = "";
  List<bool> isAdded = [];
  bool isLoginLoading = false;
  Timer timer=Timer.periodic(Duration(seconds: 3), (timer) { 
  
  });

  Future<void> sendHeartbeat() async {
  try {
   if (SqlConn.isConnected) 
   {
    print("connected.........OK");
   }
   else
   {
    print("Not  connected.........OK"); 
   }
  } 
  catch (error) 
  {
    // Handle the error (connection issue)
    print("Connection lost: $error");
    // You can trigger a reconnection here
    // ...
  }
}
  /////////////////////////////////////////////
  Future<RegistrationData?> postRegistration(
      String companyCode,
      String? fingerprints,
      String phoneno,
      String deviceinfo,
      BuildContext context) async 
    {
    NetConnection.networkConnection(context).then((value) async {
      // ignore: avoid_print
      print("Text fp...$fingerprints---$companyCode---$phoneno---$deviceinfo");
      // ignore: prefer_is_empty
      if (companyCode.length >= 0) {
        appType = companyCode.substring(10, 12);
      }
      if (value == true) {
        try {
          Uri url =
              Uri.parse("https://trafiqerp.in/order/fj/get_registration.php");
          Map body = {
            'company_code': companyCode,
            'fcode': fingerprints,
            'deviceinfo': deviceinfo,
            'phoneno': phoneno
          };
          // ignore: avoid_print
          print("register body----$body");
          isLoading = true;
          notifyListeners();
          http.Response response = await http.post(
            url,
            body: body,
          );
          // print("body $body");
          var map = jsonDecode(response.body);
          // ignore: avoid_print
          print("regsiter map----$map");
          RegistrationData regModel = RegistrationData.fromJson(map);

          sof = regModel.sof;
          fp = regModel.fp;
          String? msg = regModel.msg;

          if (sof == "1") {
            if (appType == 'GM') {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              /////////////// insert into local db /////////////////////
              String? fp1 = regModel.fp;
              // ignore: avoid_print
              print("fingerprint......$fp1");
              prefs.setString("fp", fp!);
              if (map["os"] == null || map["os"].isEmpty) {
                isLoading = false;
                notifyListeners();
                CustomSnackbar snackbar = CustomSnackbar();
                snackbar.showSnackbar(context, "Series is Missing", "");
              } else {
                cid = regModel.cid;
                prefs.setString("cid", cid!);

                cname = regModel.c_d![0].cnme;

                prefs.setString("cname", cname!);
                prefs.setString("os", regModel.os!);

                // ignore: avoid_print
                print("cid----cname-----$cid---$cname");
                notifyListeners();
                await externalDir.fileWrite(fp1!);
                // ignore: duplicate_ignore
                for (var item in regModel.c_d!) {
                  // ignore: avoid_print
                  print("ciddddddddd......$item");
                  // cD.add(item);
                }
                // verifyRegistration(context, "");
                isLoading = false;
                notifyListeners();
                prefs.setString("user_type", appType!);
                prefs.setString("db_name", map["mssql_arr"][0]["db_name"]);
                prefs.setString("old_db_name", map["mssql_arr"][0]["db_name"]);
                prefs.setString("ip", map["mssql_arr"][0]["ip"]);
                prefs.setString("port", map["mssql_arr"][0]["port"]);
                prefs.setString("usern", map["mssql_arr"][0]["username"]);
                prefs.setString("pass_w", map["mssql_arr"][0]["password"]);
                prefs.setString("multi_db", map["mssql_arr"][0]["multi_db"]);

                // await JeminiBorma.instance
                //     .deleteFromTableCommonQuery("companyRegistrationTable", "");
                // ignore: use_build_context_synchronously
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              }
            } else {
              isLoading = false;
              notifyListeners();
              CustomSnackbar snackbar = CustomSnackbar();
              // ignore: use_build_context_synchronously
              snackbar.showSnackbar(context, "Invalid Apk Key", "");
            }
          }
          /////////////////////////////////////////////////////
          if (sof == "0") {
            isLoading = false;
            notifyListeners();
            CustomSnackbar snackbar = CustomSnackbar();
            // ignore: use_build_context_synchronously
            snackbar.showSnackbar(context, msg.toString(), "");
          }
          notifyListeners();
        } catch (e) {
          // ignore: avoid_print
          print(e);
          return null;
        }
      }
    });
    return null;
  }
  //////////////////////////////////////////////////////////
  getLogin(String userName, String password, BuildContext context) async {
    try {
      isLoginLoading = true;
      notifyListeners();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (userName.toLowerCase() != "vega" ||
          password.toLowerCase() != "vega") {
        CustomSnackbar snackbar = CustomSnackbar();
        // ignore: use_build_context_synchronously
        snackbar.showSnackbar(context, "Incorrect Username or Password", "");
        isLoginLoading = false;
        notifyListeners();
      } else {
        prefs.setString("st_uname", userName);
        prefs.setString("st_pwd", password);
        // ignore: use_build_context_synchronously
        initDb(context, "from login");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => 
          HomePage()
          ),
        );
      }
      isLoginLoading = false;
      notifyListeners();
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return null;
    }
  }

//////////////////////////////////////////////////////////
  initDb(BuildContext context, String type) async 
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? db = prefs.getString("old_db_name");
    String? ip = prefs.getString("ip");
    String? port = prefs.getString("port");
    String? un = prefs.getString("usern");
    String? pw = prefs.getString("pass_w");
    debugPrint("Connecting...");
    try {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Please wait",
                  style: TextStyle(fontSize: 13),
                ),
                SpinKitCircle(
                  color: Colors.green,
                )
              ],
            ),
          );
        },
      );
      await SqlConn.connect(
          ip: ip!, port: port!, databaseName: db!, username: un!, password: pw!
          // ip: "192.168.18.37",
          // port: "1433",
          // databaseName: "GE169715",
          // username: "sa",
          // password: "1"
          );
        
      getCategoryList(context);
      getCustomerList(context, "");
      debugPrint("Connected!");
    } 
    catch (e) {
      debugPrint(e.toString());
    } finally {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

//////////////////////////////////////////////////////////
  getUserData() async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cname = prefs.getString("cname");
    userName = prefs.getString("name");
    // ignore: avoid_print
    print("haiii ----$cname");
    isLoading = false;
    notifyListeners();
  }

  ////////////////////////////////////
  setDate(String date1, String date2) {
    fromDate = date1;
    todate = date2;
    print("gtyy----$fromDate----$todate");
    notifyListeners();
  }

//////////////////////////////////////////////////////////////////
  Future<List<CustomerModel>> getCustomerList(
      BuildContext context, String filter) async {
    List<CustomerModel> list = [];
    // var res = await SqlConn.readData(
    //     "SELECT fld1301 AS taxId,fld1302 as taxType FROM TAB13 WHERE  fld1302 LIKE '$filter%' ORDER BY fld1301");
    String f = filter.trim();
    // isCusLoading = true;

    // notifyListeners();

    print("dndndn------$filter");
    var res = await SqlConn.readData("Flt_Sp_Get_Customer '$filter'");
    // ignore: avoid_print
    print("customer list-----------$res");
    var valueMap = json.decode(res);
    customerList.clear();
    if (valueMap != null) {
      for (var item in valueMap) {
        // customerList.add(item);
        list.add(CustomerModel.fromJson(item));
      }
      return list;
    }
    return [];

    // isCusLoading = false;
    // notifyListeners();
  }

  /////////////////////////////////////////////////
  getCategoryList(
    BuildContext context,
  ) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? cid = await prefs.getString("cid");
    // String? db = prefs.getString("db_name");
    // String? brId = await prefs.getString("br_id");
    param = "";
    isLoading = true;

    var res = await SqlConn.readData("Flt_Sp_Get_Category");
    var valueMap = json.decode(res);

    // ignore: avoid_print
    print("category list----------$valueMap");
    categoryList.clear();
    if (valueMap != null) {
      for (var item in valueMap) {
        categoryList.add(item);
      }
    }

    isLoading = false;

    notifyListeners();
  }

  /////////////////////////////////////////////////
  getItemList(BuildContext context, String catId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? cid = await prefs.getString("cid");
    // String? db = prefs.getString("db_name");
    // String? brId = await prefs.getString("br_id");
    String? os = await prefs.getString("os");
    int? cartid = await prefs.getInt("cartId");
    print("catttt iidd----$catId---$cartid----$os");
    isLoading = true;
    notifyListeners();
    var res =
        await SqlConn.readData("Flt_Sp_ItemList '$catId','$cartid','$os'");
    var valueMap = json.decode(res);
    print("item list----------$valueMap");
    itemList.clear();
    if (valueMap != null) {
      for (var item in valueMap) {
        itemList.add(item);
      }
    }
    isSearch = false;
    notifyListeners();
    qty = List.generate(itemList.length, (index) => TextEditingController());
    isAdded = List.generate(itemList.length, (index) => false);
    response = List.generate(itemList.length, (index) => 0);
    for (int i = 0; i < itemList.length; i++) {
      qty[i].text = "1.0";
      response[i] = 0;
    }
    isLoading = false;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////
  setQty(double val, int index, String type) {
    if (type == "inc") {
      double d = double.parse(qty[index].text) + val;
      qty[index].text = d.toString();
      notifyListeners();
    } else if (type == "dec") {
      if (double.parse(qty[index].text) > 1) {
        double d = double.parse(qty[index].text) - val;
        qty[index].text = d.toString();
        notifyListeners();
      }
    }
  }

///////////////////////////////////////////////////////////
  // getCartItems(BuildContext context) async {
  //   isLoading = true;
  //   // var res = await SqlConn.readData("Flt_Sp_ItemList '$catId'");
  //   // var valueMap = json.decode(res);
  //   // print("item list----------$valueMap");
  //   // itemList.clear();
  //   // if (valueMap != null) {
  //   //   for (var item in valueMap) {
  //   //     itemList.add(item);
  //   //   }
  //   // }
  //   qty = List.generate(4, (index) => TextEditingController());

  //   for (int i = 0; i < itemList.length; i++) {
  //     qty[i].text = "1.0";
  //     response[i] = 0;
  //   }
  //   isLoading = false;
  //   notifyListeners();
  // }

/////////////////////////////////////////////////////////////////////////////
  setDropdowndata(String s, BuildContext context) async {
    // branchid = s;
    for (int i = 0; i < customerList.length; i++) {
      if (customerList[i]["Acc_Id"].toString() == s.toString()) {
        selected = customerList[i]["Acc_Name"];
        customerId = customerList[i]["Acc_Id"].toString();
        print("s------$s---$selected");
        getCartNo(context);
        notifyListeners();
      }
    }
    freezeDropdown(true);
    notifyListeners();
  }

///////////////////////////////////
  getCartNo(
    BuildContext context,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? cid = await prefs.getString("cid");
    // String? db = prefs.getString("db_name");
    // String? brId = await prefs.getString("br_id");
    String? os = await prefs.getString("os");

    var res = await SqlConn.readData("Flt_Sp_GetCartno '$os'");
    // ignore: avoid_print
    print("cart no------$res");
    var valueMap = json.decode(res);

    // cartId = valueMap[0]["CartId"];
    prefs.setInt("cartId", valueMap[0]["CartId"]);
    notifyListeners();
    // customerList.clear();
    // if (valueMap != null) {
    //   for (var item in valueMap) {
    //     customerList.add(item);
    //   }
    // }

    notifyListeners();
  }

  ///////////////////////////////////////////////
  updateCart(
      BuildContext context,
      Map map,
      String dateTime,
      String customId,
      double qty,
      int index,
      String type,
      int status,
      String category_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? cid = await prefs.getString("cid");
    // String? db = prefs.getString("db_name");
    // String? brId = await prefs.getString("br_id");
    String? os = await prefs.getString("os");
    int? cartid = await prefs.getInt("cartId");
    isAdded[index] = true;
    notifyListeners();
    print("stattuss----$status");
    var res;
    notifyListeners();
    if (type == "from cart") {
      res = await SqlConn.readData(
          "Flt_Update_Cart $cartid,'$dateTime','${map["Cart_Cust_ID"]}',0,'$os','${map["Cart_Batch"]}',$qty,${map["Cart_Rate"]},${map["Cart_Pid"]},'${map["Cart_Unit"]}','${map["Pkg"]}',$status");
    } else if (type == "from itempage") {
      res = await SqlConn.readData(
          "Flt_Update_Cart $cartid,'$dateTime','$customId',0,'$os','${map["code"]}',$qty,${map["Srate"]},${map["ProdId"]},'${map["Unit"]}','${map["Pkg"]}',$status");
      getItemList(context, category_id);
    }

    // ignore: avoid_print
    print("insert cart---$res");
    var valueMap = json.decode(res);
    response[index] = valueMap[0]["Result"];
    isAdded[index] = false;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////
  viewCart(
    BuildContext context,
    String customId,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? cid = await prefs.getString("cid");
    // String? db = prefs.getString("db_name");
    // String? brId = await prefs.getString("br_id");
    String? os = await prefs.getString("os");
    int? cartid = await prefs.getInt("cartId");

    isCartLoading = true;
    notifyListeners();

    print("jbjhbvbv -------------$os--$cartid ---- $customerId---");
    var res = await SqlConn.readData(
        "Flt_Sp_Get_Unsaved_Cart $cartid,'$customerId','$os'");
    var valueMap = json.decode(res);
    isCartLoading = false;
    notifyListeners();
    print("view cart---$res");

    cartItems.clear();
    for (var item in valueMap) {
      cartItems.add(item);
    }
    cartCount = cartItems.length;
    notifyListeners();
    qty = List.generate(cartItems.length, (index) => TextEditingController());
    notifyListeners();
    sum = 0.0;
    for (int i = 0; i < cartItems.length; i++) {
      qty[i].text = cartItems[i]["Cart_Qty"].toString();
      sum = sum + cartItems[i]["It_Total"];
    }

    notifyListeners();
  }

/////////////////////////////////////////////////////////////////////////////////////////
  searchTable(String val) {
    if (val.isNotEmpty) {
      isSearch = true;
      notifyListeners();
      filteredlist = tabllist
          .where((e) =>
              e["tab"].toLowerCase().contains(val.toLowerCase())
              )
          .toList();
    } else {
      isSearch = false;
      notifyListeners();
      filteredlist = tabllist;
    }
    // qty =
    //     List.generate(filteredlist.length, (index) => TextEditingController());
    // isAdded = List.generate(filteredlist.length, (index) => false);
    // response = List.generate(filteredlist.length, (index) => 0);
    // for (int i = 0; i < filteredlist.length; i++) {
    //   qty[i].text = "1.0";
    //   response[i] = 0;
    // }
    print("filtered_TABL_List----------------$filteredlist");
    notifyListeners();
  }

  //////////////////////////////////////////////
  searchCat(String val) {
    if (val.isNotEmpty) {
      isSearch = true;
      notifyListeners();
      filteredlist = catlist
          .where((e) =>
              e["catname"].toLowerCase().contains(val.toLowerCase())
              )
          .toList();
    } else {
      isSearch = false;
      notifyListeners();
      filteredlist = catlist;
    }
    print("filtered_CATGRY_List----------------$filteredlist");
    notifyListeners();
  }
   searchItem(String val) {
    if (val.isNotEmpty) {
      isSearch = true;
      notifyListeners();
      filteredlist = itemlist
          .where((e) =>
              e["pname"].toLowerCase().contains(val.toLowerCase())
              )
          .toList();
    } else {
      isSearch = false;
      notifyListeners();
      filteredlist = itemlist;
    }
    print("filtered_ITEM_List----------------$filteredlist");
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////////////
  freezeDropdown(bool val) {
    isfreez = val;
    print("isFreez-----$isfreez");
    // selected = null;

    notifyListeners();
  }

  /////////////////////////////////////////////////////////////////////
  saveOrder(BuildContext context, String date, double total, int count) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? cid = await prefs.getString("cid");
    // String? db = prefs.getString("db_name");
    // String? brId = await prefs.getString("br_id");
    String? os = await prefs.getString("os");
    int? cartid = await prefs.getInt("cartId");

    print("djgd----$os---$cartid---$customerId---$date---$total---$count");
    notifyListeners();
    var res = await SqlConn.readData(
        "Flt_Sp_Save_Order  $cartid,'$date','$customerId','$os',$total,$count");
    // ignore: avoid_print
    print("save order------$res");
    var valueMap = json.decode(res);
    // String val = valueMap[0]["Orderno"];
    if (valueMap[0]["Save_Status"] == "Success") {
      Fluttertoast.showToast(
          msg: "Order Saved as Order No : ${valueMap[0]["Orderno"]}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 18.0);
      isfreez = false;
      // viewCart(context, customerId.toString());
      selected = null;
      customerId = null;
      viewCart(context, customerId.toString());
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
    notifyListeners();
  }

  /////////////////////////////////////////////////////////////////////
  setcustomerId(String id, BuildContext context) {
    customerId = id;

    print("customer----$customerId");
    notifyListeners();
    getCartNo(context);
    freezeDropdown(true);
  }

  ///////////////////////////////////////////////////////////////////
  getorderList(String date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? cid = await prefs.getString("cid");
    // String? db = prefs.getString("db_name");
    // String? brId = await prefs.getString("br_id");
    String? os = await prefs.getString("os");
    int? cartid = await prefs.getInt("cartId");
    isOrderLoading = true;
    notifyListeners();
    print("djgd----$os--");
    notifyListeners();
    var res = await SqlConn.readData("Flt_Get_Order_List  '$os','$date'");
    // ignore: avoid_print
    var valueMap = json.decode(res);
    print("order list-----$valueMap");
    orderlist.clear();
    for (var item in valueMap) {
      orderlist.add(item);
    }
    isOrderLoading = false;
    // notifyListeners();
    notifyListeners();
  }

  ///////////////////////////////////////////////////////
  getorderDetails(String ordNo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? cid = await prefs.getString("cid");
    // String? db = prefs.getString("db_name");
    // String? brId = await prefs.getString("br_id");
    String? os = await prefs.getString("os");
    int? cartid = await prefs.getInt("cartId");
    isOrderLoading = true;
    notifyListeners();
    print("djgd----$os--");
    notifyListeners();
    var res = await SqlConn.readData("Flt_Get_Order_Details  '$os','$ordNo'");
    // ignore: avoid_print
    var valueMap = json.decode(res);
    print("order details-----$valueMap");
    orderDetails.clear();
    for (var item in valueMap) {
      orderDetails.add(item);
    }
    isOrderLoading = false;
    notifyListeners();
  }

///////////////////////////////////////////////////////////////
  searchOrder(String val) {
    // filteredlist.clear();
    if (val.isNotEmpty) {
      isSearch = true;
      notifyListeners();
      filteredlist = orderlist
          .where((e) =>
              e["Customer_Name"].toLowerCase().startsWith(val.toLowerCase()) ||
              e["Cust_ID"].toLowerCase().startsWith(val.toLowerCase()))
          .toList();
    } else {
      isSearch = false;
      notifyListeners();
      filteredlist = orderlist;
    }

    print("filteredList----------------$filteredlist");
    notifyListeners();
  }

  setIsSearch(bool val) {
    isSearch = val;
    notifyListeners();
  }

  getOs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? cid = await prefs.getString("cid");
    // String? db = prefs.getString("db_name");
    // String? brId = await prefs.getString("br_id");
    os = await prefs.getString("os");
    notifyListeners();
  }
 
  
}
