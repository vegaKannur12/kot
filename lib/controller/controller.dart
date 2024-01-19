import 'dart:async';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:restaurent_kot/Screen/authentication/login.dart';
import 'package:restaurent_kot/Screen/db_selection.dart';
import 'package:restaurent_kot/Screen/home.dart';
import 'package:restaurent_kot/components/custom_snackbar.dart';
import 'package:restaurent_kot/components/external_dir.dart';
import 'package:restaurent_kot/db_helper.dart';
import 'package:restaurent_kot/model/customer_model.dart';
import 'package:restaurent_kot/model/registration_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sql_conn/sql_conn.dart';
import '../components/network_connectivity.dart';

class Controller extends ChangeNotifier {
  // int? cartNo;
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
  List<Map<String, dynamic>> itemlist = [];

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
  List<CD> c_d = [];
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
  List<TextEditingController> qty = [];
  List<bool> isAdded = [];
  List<Map<String, dynamic>> list = [];
  List<Map<String, dynamic>> tabllist = [
    {"tab": "Table 1", "tid": 1},
    {"tab": "Table 2", "tid": 2},
    {"tab": "Table 3", "tid": 3},
    {"tab": "Table 4", "tid": 4},
    {"tab": "Table 5", "tid": 5},
  ];
  List<Map<String, dynamic>> catlist = [
    {"catid": "C1", "catname": "Category1"},
    {"catid": "C2", "catname": "Category2"},
    {"catid": "C3", "catname": "Category3"},
    {"catid": "C4", "catname": "Category4"},
    {"catid": "C5", "catname": "Category5"},
    {"catid": "C6", "catname": "Category6"},
    {"catid": "C7", "catname": "Category7"},
  ];
  // List<Map<String, dynamic>> itemlist = [
  //   {"catid": "C1", "catname": "Category1", "pname": "item1", "rate": 30.0},
  //   {"catid": "C1", "catname": "Category1", "pname": "item2", "rate": 30.0},
  //   {"catid": "C2", "catname": "Category2", "pname": "item4", "rate": 30.0},
  //   {"catid": "C2", "catname": "Category2", "pname": "item1", "rate": 30.0},
  //   {"catid": "C5", "catname": "Category5", "pname": "item1", "rate": 30.0},
  // ];
  List<Map<String, dynamic>> myBagList = [];
  bool showBottombar = true;
  double itemcount = 0.0;

  String? userName;
  String param = "";
  List<Map<String, dynamic>> db_list = [];
  bool isYearSelectLoading = false;
  bool isLoginLoading = false;
  bool isDBLoading = false;
  bool isTableLoading = false;
  bool isCategoryLoading = false;
  bool isItemLoading = false;
  String? tablID = "";
  String? catlID = "";
  Timer timer = Timer.periodic(Duration(seconds: 3), (timer) {});
  // qtyadd() {
  //   qty = List.generate(itemlist.length, (index) => TextEditingController());
  //   isAdded = List.generate(itemlist.length, (index) => false);
  //   notifyListeners();
  //   for (int i = 0; i < itemlist.length; i++) {
  //     qty[i].text = "1.0";
  //   }
  // }

  Future<void> sendHeartbeat() async {
    try {
      if (SqlConn.isConnected) {
        print("connected.........OK");
      } else {
        print("Not  connected.........OK");
      }
    } catch (error) {
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
      BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
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
            if (appType == 'UY') {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              /////////////// insert into local db /////////////////////
              String? fp1 = regModel.fp;

              // ignore: avoid_print
              print("fingerprint......$fp1");
              prefs.setString("fp", fp!);

              cid = regModel.cid;
              os = regModel.os;
              prefs.setString("cid", cid!);

              cname = regModel.c_d![0].cnme;

              prefs.setString("cname", cname!);
              prefs.setString("os", os!);
              print("cid----cname-----$cid---$cname....$os");
              notifyListeners();

              await externalDir.fileWrite(fp1!);

              // ignore: duplicate_ignore
              for (var item in regModel.c_d!) {
                print("ciddddddddd......$item");
                c_d.add(item);
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

              String? user = prefs.getString("userType");
              await KOT.instance
                  .deleteFromTableCommonQuery("companyRegistrationTable", "");
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DBSelection()),
              );
            } else {
              CustomSnackbar snackbar = CustomSnackbar();
              // ignore: use_build_context_synchronously
              snackbar.showSnackbar(context, "Invalid Apk Key", "");
            }
          }
          /////////////////////////////////////////////////////
          if (sof == "0") {
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
      String? os = prefs.getString("os");

      print("unaaaaaaaaaaammmeeeeeeeee$userName");
      String oo = "Flt_Sp_Verify_User '$os','$userName','$password'";
      print("loginnnnnnnnnnnnnnn$oo");
      //  print("{Flt_Sp_Verify_User '$os','$userName','$password'}");
      // initDb(context, "from login");
      // initYearsDb(context, "");
      var res = await SqlConn.readData(
          "Flt_Sp_Verify_User '$os','$userName','$password'");
      var valueMap = json.decode(res);
      print("item list----------$res");
      if (valueMap != null) {
        print("item list----------$res");
        print("smId.............>${valueMap[0]["Sm_id"]}");
        prefs.setString("Sm_id", valueMap[0]["Sm_id"].toString());
        prefs.setString("st_uname", userName);
        prefs.setString("st_pwd", password);
       
        Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
      } else {
        CustomSnackbar snackbar = CustomSnackbar();
        snackbar.showSnackbar(context, "Incorrect Username or Password", "");
        isLoginLoading = false;
        notifyListeners();
      }

      isLoginLoading = false;
      notifyListeners();
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return null;
    }
  }

  ////////////////////////////////////////////////////////
  getDatabasename(BuildContext context, String type) async {
    isdbLoading = true;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? db = prefs.getString("db_name");
    String? cid = await prefs.getString("cid");
    print("cid dbname---------$cid---$db");
    var res = await SqlConn.readData("Flt_LoadYears '$db','$cid'");
    var map = jsonDecode(res);
    db_list.clear();
    if (map != null) {
      for (var item in map) {
        db_list.add(item);
      }
    }
    print("years res-$res");
    print("tyyyyyyyyyp--------$type");
    isdbLoading = false;
    notifyListeners();
    SqlConn.disconnect();
    print("disconnected--------$db");
    if (db_list.length > 1) {
      if (type == "from login") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DBSelection()),
        );
      }
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

/////////////////////////////////////////////////////////////////////////////
  initYearsDb(
    BuildContext context,
    String type,
  ) async {
   
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? ip = prefs.getString("ip");
    String? port = prefs.getString("port");
    String? un = prefs.getString("usern");
    String? pw = prefs.getString("pass_w");
    String? db = prefs.getString("db_name");
    String? multi_db = prefs.getString("multi_db");

    debugPrint("Connecting selected DB...$db----");
    try { isYearSelectLoading=true;
    notifyListeners();
      // await SqlConn.disconnect();
      showDialog(
        context: context,
        builder: (context) {
          // Navigator.push(
          //   context,
          //   new MaterialPageRoute(builder: (context) => HomePage()),
          // );
          // Future.delayed(Duration(seconds: 5), () {
          //   Navigator.of(mycontxt).pop(true);
          // });
          return AlertDialog(
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
      if (multi_db == "1") {
        await SqlConn.connect(
            ip: ip!,
            port: port!,
            databaseName: db!,
            username: un!,
            password: pw!);
      }
      debugPrint("Connected selected DB!----$ip------$db");
      // getDatabasename(context, type);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      // yr = prefs.getString("yr_name");
      // dbn = prefs.getString("db_name");
      cName = prefs.getString("cname");
       isYearSelectLoading=false;
    notifyListeners();
      // prefs.setString("db_name", dbn.toString());
      // prefs.setString("yr_name", yrnam.toString());
      // getDbName();
      // getBranches(context);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      Navigator.pop(context);
    }
  }

//////////////////////////////////////////////////////////
  initDb(BuildContext context, String type) async {
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
          return AlertDialog(
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
          // ip:"192.168.18.37",
          // port: "1433",
          // databaseName: "epulze",
          // username: "sa",
          // password: "1"

          );
      debugPrint("Connected!");
      getDatabasename(context, type);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      Navigator.pop(context);
    }
  }

///////////////////////////////////////////////
  getTableList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? os = await prefs.getString("os");
    String? smid = await prefs.getString("Sm_id");
    print("tabl para---------$os---$smid");
    isTableLoading = true;
    notifyListeners();
    var res = await SqlConn.readData("Flt_Sp_Get_Tables '$os','$smid'");
    var map = jsonDecode(res);
    tabllist.clear();
    if (map != null) {
      for (var item in map) {
        tabllist.add(item);
      }
    }
    print("tablelist-$res");

    isTableLoading = false;
    notifyListeners();
  }

///////////////////////////////////
  getCategoryList() async {
    isCategoryLoading = true;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? os = await prefs.getString("os");
    String? smid = await prefs.getString("Sm_id");
    print("cat para---------$os---------$tablID-----------$smid");
    
    var res =
        await SqlConn.readData("Flt_Sp_Get_Category_Kot '$tablID','$smid'");
    var map = jsonDecode(res);
    catlist.clear();
    if (map != null) {
      for (var item in map) {
        catlist.add(item);
      }
    }
    print("categoryList...................-$res");

    isCategoryLoading = false;
    notifyListeners();
  }

///////////////////////////////////
  /////////////////////////////////////////////////
  getItemList(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? cid = await prefs.getString("cid");
    // String? db = prefs.getString("db_name");
    // String? brId = await prefs.getString("br_id");
    String? os = await prefs.getString("os");
    int? cartNo = await prefs.getInt("cartNo");

    print("catttt iidd----$catlID---$cartNo----$os");
    isLoading = true;
    notifyListeners();
    var res =
        await SqlConn.readData("Flt_Sp_ItemList '$catlID','$cartNo','$os'");
    var valueMap = json.decode(res);
    print("item list----------$valueMap");
    itemlist.clear();
    if (valueMap != null) {
      for (var item in valueMap) {
        itemlist.add(item);
      }
    }
    isSearch = false;
    notifyListeners();
    qty = List.generate(itemlist.length, (index) => TextEditingController());
    isAdded = List.generate(itemlist.length, (index) => false);
    response = List.generate(itemlist.length, (index) => 0);
    for (int i = 0; i < itemlist.length; i++) {
      qty[i].text = "1.0";
      response[i] = 0;
    }
    isLoading = false;
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
    print("cart map------$res");
    var valueMap = json.decode(res);
    // cartId = valueMap[0]["CartId"];
    prefs.setInt("cartNo", valueMap[0]["CartId"]);
    int? c = prefs.getInt("cartNo");
    print("cart No------$c");
    notifyListeners();
    // customerList.clear();
    // if (valueMap != null) {
    //   for (var item in valueMap) {
    //     customerList.add(item);
    //   }
    // }

    notifyListeners();
  }

  ////////////////////////////////////
  setDate(String date1, String date2) {
    fromDate = date1;
    todate = date2;
    print("gtyy----$fromDate----$todate");
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
      } else {
        isAdded[index] = false;
        notifyListeners();
      }
    }
  }

  ///////////////////////////////////
  totalItemCount(String val, String type) {
    if (type == "inc") {
      itemcount = itemcount + double.parse(val);
      notifyListeners();
    } else if (type == "dec") {
      if (itemcount > 1) {
        itemcount = itemcount - double.parse(val);
        notifyListeners();
      }
    }
    print("object$itemcount");
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

    notifyListeners();
  }

///////////////////////////////////////////////////
  addToBag(
    BuildContext context,
    Map map,
    String dateTime,
    String tablId,
    String catid,
    double qty,
    int index,
    String type,
    int status,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? os = await prefs.getString("os");
    isAdded[index] = true;
    await KOT.instance.insertorderBagTab(tablId, map, qty);
    notifyListeners();
    print("stattuss----$status");
    var res;

    // if (type == "from cart")
    // {
    //   // res = await SqlConn.readData(
    //   //     "Flt_Update_Cart $cartid,'$dateTime','${map["Cart_Cust_ID"]}',0,'$os','${map["Cart_Batch"]}',$qty,${map["Cart_Rate"]},${map["Cart_Pid"]},'${map["Cart_Unit"]}','${map["Pkg"]}',$status");
    // }
    // else if (type == "from itempage")
    // {
    //   // myBagList.add({});
    //   // print("bbbbbbbbbbbbaaaaaaaggggg=======$map");
    // }

    // // ignore: avoid_print
    // print("insert cart---$res");
    // var valueMap = json.decode(res);
    // response[index] = valueMap[0]["Result"];
    // isAdded[index] = false;
    // notifyListeners();
  }

  ///////////////////////////////////////////////
  updateCart(
    BuildContext context,
    Map map,
    String dateTime,
    double qty,
    String des,
    int index,
    String type,
    int status,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? cid = await prefs.getString("cid");
    // String? db = prefs.getString("db_name");
    // String? brId = await prefs.getString("br_id");
    String? os = await prefs.getString("os");
    int? cartid = await prefs.getInt("cartNo");
    int? c = prefs.getInt("cartNo");
    String? smid = await prefs.getString("Sm_id");

    isAdded[index] = true;
    notifyListeners();
    print("stattuss----$status");
    var res;
    notifyListeners();
    if (type == "from cart") 
    {
      // res = await SqlConn.readData(
      //     "Flt_Update_Cart_Kot $cartid,'$dateTime','${map["Cart_Cust_ID"]}',0,'$os','${map["Cart_Batch"]}',$qty,${map["Cart_Rate"]},${map["Cart_Pid"]},'${map["Cart_Unit"]}','${map["Pkg"]}',$status");
    } else if (type == "from itempage") {
      res = await SqlConn.readData(
        "Flt_Update_Cart_Kot $cartid,'$dateTime','$smid',$tablID,0,'$os','${map["code"]}',$qty,'${map["Srate"]}',${map["ProdId"]},'${map["Unit"]}','dec',1,'${map["Pkg"]}',$status",
      );
      print("data added..............--------------------------------------------------------------");
      //getItemList(context);
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
    
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? cid = await prefs.getString("cid");
    // String? db = prefs.getString("db_name");
    // String? brId = await prefs.getString("br_id");
    String? os = await prefs.getString("os");
    int? cartNo = await prefs.getInt("cartNo");
  

    isCartLoading = true;
    notifyListeners();

    print("jbjhbvbv -------------{Flt_Sp_Get_Unsaved_Cart_KOT $cartNo,'$tablID','$os'}");
    var res = await SqlConn.readData(
        "Flt_Sp_Get_Unsaved_Cart_KOT $cartNo,'$tablID','$os'");
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
    filteredlist = tabllist;
    if (val.isNotEmpty) {
      isSearch = true;
      notifyListeners();

      filteredlist = tabllist
          .where((e) => e["Table_Name"]
              .toString()
              .toLowerCase()
              .contains(val.toLowerCase()))
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
    filteredlist = catlist;
    if (val.isNotEmpty) {
      isSearch = true;
      notifyListeners();

      filteredlist = catlist
          .where((e) => e["Cat_Name"]
              .toString()
              .toLowerCase()
              .contains(val.toLowerCase()))
          .toList();
    } else {
      isSearch = false;
      notifyListeners();
      filteredlist = catlist;
    }
    // qty =
    //     List.generate(filteredlist.length, (index) => TextEditingController());
    // isAdded = List.generate(filteredlist.length, (index) => false);
    // response = List.generate(filteredlist.length, (index) => 0);
    // for (int i = 0; i < filteredlist.length; i++) {
    //   qty[i].text = "1.0";
    //   response[i] = 0;
    // }
    print("filtered_CAT_List----------------$filteredlist");
    notifyListeners();
  }

  searchItem(String val) {
    filteredlist = itemlist;
    if (val.isNotEmpty) {
      isSearch = true;
      notifyListeners();

      filteredlist = itemlist
          .where((e) =>
              e["Product"].toString().toLowerCase().contains(val.toLowerCase()))
          .toList();
    } else {
      isSearch = false;
      notifyListeners();
      filteredlist = itemlist;
    }

    // }
    print("filtered_ITEM_List----------------$filteredlist");
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////////////
  setTableID(String id, BuildContext context) {
    tablID = id;

    print("tablID----$tablID");
    notifyListeners();
  }

  ///////////////........................../////////////////////////////
  setCatID(String id, BuildContext context) {
    catlID = id;

    print("catlID----$catlID");
    notifyListeners();
  }

  /////////////////////////////////////////////////////////////////////

  ///////////////////////////////////////////////////////
  getorderDetails(String ordNo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? cid = await prefs.getString("cid");
    // String? db = prefs.getString("db_name");
    // String? brId = await prefs.getString("br_id");
    String? os = await prefs.getString("os");
    int? cartNo = await prefs.getInt("cartNo");
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
    filteredlist.clear();
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
