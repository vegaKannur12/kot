import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:restaurent_kot/Screen/authentication/login.dart';
import 'package:restaurent_kot/Screen/authentication/registration.dart';
import 'package:restaurent_kot/Screen/db_selection.dart';
import 'package:restaurent_kot/Screen/home.dart';
import 'package:restaurent_kot/components/c_errorDialog.dart';
import 'package:restaurent_kot/components/custom_snackbar.dart';
import 'package:restaurent_kot/components/external_dir.dart';
import 'package:restaurent_kot/db_helper.dart';
import 'package:restaurent_kot/model/customer_model.dart';
import 'package:restaurent_kot/model/login_model.dart';
import 'package:restaurent_kot/model/registration_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sql_conn/sql_conn.dart';
import '../components/network_connectivity.dart';

class Controller extends ChangeNotifier {
  //   int? cartNo;
  String? fromDate;
  String? lastdate;
  String? customerId;
  double bal = 0.0;
  int? cartCount;
  String? cname;
  double sum = 0.0;
  bool isSearch = false;
  bool isRoomSearch = false;
  String? colorString;
  // List<CD> cD = [];
  List<Map<String, dynamic>> customerList = [];
  List<Map<String, dynamic>> filteredlist = [];
  List<Map<String, dynamic>> filteredroomlist = [];
  List<Map<String, dynamic>> orderlist = [];
  List<Map<String, dynamic>> orderDetails = [];
  bool isOrderLoading = false;
  bool isfreez = false;
  List<Map<String, dynamic>> cartItems = [];
  List<Map<String, dynamic>> kotItems = [];
  List<Map<String, dynamic>> kitchenKotItems = [];
  List<Map<String, dynamic>> tableItemList = [];
  List<Map<String, dynamic>> kotItemList = [];
  bool isCartLoading = false;
  bool isKOTLoading = false;
  List<Map<String, dynamic>> categoryList = [];
  List<Map<String, dynamic>> itemlist = [];

  bool isCusLoading = false;
  DateTime? sdate;
  DateTime? ldate;
  String? os;
  int? table_catID;
  String? table_catNM;
  int? cartNum;
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
  List<TextEditingController> descr = [];
  List<bool> isAdded = [];
  List<Map<String, dynamic>> list = [];
  List<Map<String, dynamic>> tabllist = [];
  // {"tab": "Table 1", "tid": 1},
  // {"tab": "Table 2", "tid": 2},
  // {"tab": "Table 3", "tid": 3},
  // {"tab": "Table 4", "tid": 4},
  // {"tab": "Table 5", "tid": 5},

  List<Map<String, dynamic>> tabllistCAT = [];
  List<Map<String, dynamic>> roomlist = [];
  List<Map<String, dynamic>> catlist = [];
  // {"catid": "C1", "catname": "Category1"},
  // {"catid": "C2", "catname": "Category2"},
  // {"catid": "C3", "catname": "Category3"},
  // {"catid": "C4", "catname": "Category4"},
  // {"catid": "C5", "catname": "Category5"},
  // {"catid": "C6", "catname": "Category6"},
  // {"catid": "C7", "catname": "Category7"},

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
  bool isRoomLoading = false;
  bool isCategoryLoading = false;
  bool istableItemListLoading = false;
  bool isKOTItemListLoading = false;
  bool isItemLoading = false;
  String? tablID = "";
  String? roomID = "0";
  String? catlID = "";
  String roomnm = "";
  String tablname = "";
  String guestnm = " ";

  //new IDsss
  int cart_id = 0;
  String tabl_ID = "";
  String? room_ID = "0";
  // String? catlID = "";
  String? room_nm = "";
  String tabl_name = "";
  String? guest_nm = " ";
  Timer timer = Timer.periodic(Duration(seconds: 3), (timer) {});
  List<Map<String, dynamic>> logList = [];
  String? selectedSmName;
  Map<String, dynamic>? selectedItemStaff;
  int cartTotal = 0;
  double karttotal = 0.0;
  List<Map<String, dynamic>> tableCategoryList = [];
  List<Map<String, dynamic>> settingsList = [];
  String? selectedTableCat;
  Map<String, dynamic>? selectedItemTablecat;
  final suggestions = [
    'No Suger',
    'No Salt',
    'Strong',
    'Medium',
    'Light',
    'More Suger',
    'More Milk',
    'More Spicy',
    'Less Spicy',
    'Less Suger',
    'Less Salt'
  ];
  List filteredSuggestions = [];
  final Map<String, List<Map<String, dynamic>>> groupedData = {};
  List<bool> isCallDisabled = [];
  // qtyadd() {
  //   qty = List.generate(itemlist.length, (index) => TextEditingController());
  //   isAdded = List.generate(itemlist.length, (index) => false);
  //   notifyListeners();
  //   for (int i = 0; i < itemlist.length; i++) {
  //     qty[i].text = "1.0";
  //   }
  // }

  // Future<void> sendHeartbeat() async {
  //   try {
  //     if (SqlConn.isConnected) {
  //       print("connected.........OK");
  //     } else {
  //       print("Not  connected.........OK");
  //     }
  //   } catch (error) {
  //     // Handle the error (connection issue)
  //     print("Connection lost: $error");
  //     // You can trigger a reconnection here
  //     // ...
  //   }
  // }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Controller() {
    initializeNotifications();
    // startConditionChecker();
  }

  void initializeNotifications() {
    print("init notif");
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  startConditionChecker() {
    Timer.periodic(Duration(seconds: 60), (timer) async {
      bool condition = await checkCondition();
      if (condition) {
        showReminderNotification('Order Alert', 'You have a prepared order!');
      }
    });
  }

  Future<bool> checkCondition() async {
    // Implement your logic to check the condition here
    return true; // Example result, replace with actual condition
  }

  showReminderNotification(String dlgTitle, String dlgBodyy) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'reminder_channel_id',
      'Reminder Notifications',
      importance: Importance.high,
      priority: Priority.high,
      enableVibration: true,
      vibrationPattern: Int64List.fromList([0, 1000, 500, 1000]),
      sound: const RawResourceAndroidNotificationSound('notif2'),
    );
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      dlgTitle,
      dlgBodyy,
      platformChannelSpecifics,
    );
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
            if (appType == 'UY')
            // if (appType == 'ED')
            {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              /////////////// insert into local db /////////////////////
              String? fp1 = regModel.fp;
              if (map["os"] == null || map["os"].isEmpty) {
                isLoading = false;
                notifyListeners();
                CustomSnackbar snackbar = CustomSnackbar();
                snackbar.showSnackbar(context, "Series is Missing", "");
              } else {
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
                String? m_db = prefs.getString("multi_db");
                if (m_db != "1") {
                  print("dont want year select");
                  await initDb(context, "from login");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginPage()), //m_db=0
                  );
                } else {
                  print("want year select");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DBSelection()),
                  );
                }
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => DBSelection()),
                // );
              }
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
        } on SocketException catch (e) {
          // regLoad = false;
          notifyListeners();
          if (e.osError != null && e.osError!.errorCode == 110) {
            await showCommonErrorDialog(
                'Connection timed out. Please try again..',
                Registration(),
                context);
          } else {
            // print("SocketException");
            // ignore: use_build_context_synchronously
            await showCommonErrorDialog(
                'SocketException: ${e.message}', Registration(), context);
          }
        } catch (e) {
          // ignore: avoid_print
          // regLoad = false;
          await showCommonErrorDialog(
              'An unexpected error occurred: ${e.toString()}',
              Registration(),
              context);
          // return null;
        }
      }
    });
    return null;
  }

  //////////////////////////////////////////////////////////
  getLogin(BuildContext context) async {
    try {
      isLoginLoading = true;
      notifyListeners();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? os = prefs.getString("os");

      // print("unaaaaaaaaaaammmeeeeeeeee$userName");
      String oo = "Kot_Login_Info '$os'";
      print("loginnnnnnnnnnnnnnn$oo");
      //  print("{Flt_Sp_Verify_User '$os','$userName','$password'}");
      // initDb(context, "from login");
      // initYearsDb(context, "");
      var res = await SqlConn.readData("Kot_Login_Info '$os'");
      var valueMap = json.decode(res);
      print("login details----------$res");
      if (valueMap != null) {
        // LoginModel logModel = LoginModel.fromJson(valueMap);
        for (var item in valueMap) {
          // logList = [
          //   {
          //     "Sm_id": "VGMHD3",
          //     "Sm_Name": "MADHAV",
          //     "Us_Name": "MADHAV",
          //     "PWD": 3,
          //     "Tbl_catid": 0
          //   },
          //   {
          //     "Sm_id": "VGMHD2",
          //     "Sm_Name": "MANU",
          //     "Us_Name": "MANU",
          //     "PWD": 2,
          //     "Tbl_catid": 8
          //   },
          //   {
          //     "Sm_id": "VGMHD1",
          //     "Sm_Name": "SURAJ",
          //     "Us_Name": "SURAJ",
          //     "PWD": 1,
          //     "Tbl_catid": 0
          //   }
          // ];
          logList.add(item);
          notifyListeners();
        }
        print("LogList----$logList");
      }
      isLoginLoading = false;
      notifyListeners();
    } on PlatformException catch (e) {
      debugPrint("PlatformException Table: ${e.message}");
      debugPrint("not connected..Table..");
      // Navigator.pop(context);
      showConnectionDialog(context, "LOG", e.toString());
    } catch (e) {
      print("An unexpected error occurred: $e");
      // SqlConn.disconnect();
    }
  }

  verifyStaff(String pwd, BuildContext context) {
    print("pwd , selpwd ====$pwd ,${selectedItemStaff!['PWD']}");
    if (pwd == selectedItemStaff!['PWD'].toString().trim()) {
      return 1;
    } else {
      return 0;
    }
  }

  ////////////////////////////////////////////////////////
  getDatabasename(BuildContext context, String type) async {
    isdbLoading = true;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? db = prefs.getString("db_name");
    String? cid = await prefs.getString("cid");
    await initDb(context, "");
    print("cid dbname---------$cid---$db");
    try {
      var res = await SqlConn.readData("Flt_LoadYears '$db','$cid'");
      var map = jsonDecode(res);
      db_list.clear();
      if (map != null) {
        for (var item in map) {
          db_list.add(item);
        }
      }
      // db_list=[{"Data_Name":"AV172745", "Year_Name":"Year_2425"},{"Data_Name":"AV172745", "Year_Name":"Year_2425"},{"Data_Name":"AV172745", "Year_Name":"Year_2425"}];
      print("years res-$res");
      print("tyyyyyyyyyp--------$type");
      isdbLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint("not connected..db  select..");
      debugPrint(e.toString());
      Navigator.pop(context);
      await showConnectionDialog(context, "DB", e.toString());

      //   showDialog(
      //   context: context,
      //   builder: (context) {
      //     return AlertDialog(
      //       title: Text("Connection Failed"),
      //       content: Text("Failed to connect to the database. Please check your settings and try again."),
      //       actions: [
      //         TextButton(
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //           },
      //           child: Text("OK"),
      //         ),
      //       ],
      //     );
      //   },
      // );
    } finally {
      // Navigator.pop(context);
    }
    // SqlConn.disconnect();
    // print("disconnected--------$db");
    // if (db_list.length > 1) {
    //   if (type == "from login") {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (context) => DBSelection()),
    //     );
    //   }
    // } else {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => HomePage()),
    //   );
    // }
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
    debugPrint("Connecting ...$ip---$port----$un----$pw-");
    try {
      isYearSelectLoading = true;
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
      // if (multi_db == "1") {
      await SqlConn.connect(
          ip: ip!,
          port: port!,
          databaseName: db!,
          username: un!,
          password: pw!);
      // }
      debugPrint("Connected selected DB!----$ip------$db");
      // getDatabasename(context, type);
      Navigator.pop(context);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // yr = prefs.getString("yr_name");
      // dbn = prefs.getString("db_name");
      cName = prefs.getString("cname");
      isYearSelectLoading = false;
      notifyListeners();
      // prefs.setString("db_name", dbn.toString());
      // prefs.setString("yr_name", yrnam.toString());
      // getDbName();
      // getBranches(context);
      if (type == "DB") {
        await getDatabasename(context, "");
      } else if (type == "INDB") {
        await initDb(context, "");
      } else if (type == "INYR") {
        await initYearsDb(context, "");
      } else if (type == "LOG") {
        await getLogin(context);
      } else if (type == "TCAT") {
        await getTableCtegory(context);
      } else if (type == "TBL") {
        await getTableList(context);
      } else if (type == "ROM") {
        await getRoomList(context);
        await getTableList(context);
      } else if (type == "CAR") {
        await getCartNo(context);
      } else if (type == "CAT") {
        await getCategoryList(context);
      } else if (type == "ITM") {
        await getItemList(context);
      } else if (type == "VCART") {
        await viewCart(context);
      } else if (type == "FIN") {
        await finalSave(context);
      } else if (type == "FINP") {
        await finalPrint(context);
      } else if (type == "SET") {
        await getSettings(context, "");
      }
      // else if (type == "VWKOT") {
      //   await viewKot(context);
      // }
      else {}
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      debugPrint("not connected..init-YRDB..");
      Navigator.pop(context);
      await showConnectionDialog(context, "INYR", e.toString());
    } catch (e) {
      print("An unexpected error occurred: $e");
      // SqlConn.disconnect();
      // return [];
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
    debugPrint("Connecting...initDB..$db");
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
      Navigator.pop(context);
      // getDatabasename(context, type);
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("not connected..initDB..");
      Navigator.pop(context);
      await showINITConnectionDialog(context, "INDB", e.toString());

      //   showDialog(
      //   context: context,
      //   builder: (context) {
      //     return AlertDialog(
      //       title: Text("Connection Failed"),
      //       content: Text("Failed to connect to the database. Please check your settings and try again."),
      //       actions: [
      //         TextButton(
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //           },
      //           child: Text("OK"),
      //         ),
      //       ],
      //     );
      //   },
      // );
    } finally {
      // Navigator.pop(context);
    }
  }

///////////////////////////////////////////////
  getTableList(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? os = await prefs.getString("os");
    String? smid = await prefs.getString("Sm_id");
    String? tablecat = await prefs.getString("Sm_Tbl_catName"); //table_cat
    print("tabl para---------$os---$smid--$tablecat");
    isTableLoading = true;
    notifyListeners();
    try {
      var res = await SqlConn.readData("Kot_Table_List '$os','$smid'");
      var map = jsonDecode(res);
      tabllist.clear();
      tabllistCAT.clear();
      notifyListeners();
      print("tablelist--$res");
      if (map != null) {
        //            tabllist = [
        //   {
        //     "Table_ID": "VGMHD2",
        //     "Table_Name": "101T",
        //     "Table_Category": "TABLE",
        //     "STATUS": 1
        //   },
        //   {
        //     "Table_ID": "VGMHD5",
        //     "Table_Name": "1A",
        //     "Table_Category": "ALL",
        //     "STATUS": 1
        //   },
        //   {
        //     "Table_ID": "VGMHD6",
        //     "Table_Name": "1B",
        //     "Table_Category": "TABLE",
        //     "STATUS": 1
        //   },
        //   {
        //     "Table_ID": "VGMHD7",
        //     "Table_Name": "1C",
        //     "Table_Category": "ALL",
        //     "STATUS": 1
        //   }
        // ];
        for (var item in map) {
          tabllist.add(item);
        }
      }
      tabllistCAT = tabllist
          .where((e) => e["Table_Category"]
              .toString()
              .trimLeft()
              .toLowerCase()
              .contains(tablecat.toString().toLowerCase()))
          .toList();
      if (tablecat == "ALL") {
        tabllistCAT = tabllist;
      }

      print("tablelistCAT-$tabllistCAT");
      isTableLoading = false;
      notifyListeners();
    } on PlatformException catch (e) {
      debugPrint("PlatformException Table: ${e.message}");
      debugPrint("not connected..Table..");
      // Navigator.pop(context);
      await showConnectionDialog(context, "TBL", e.toString());
    } catch (e) {
      print("An unexpected error occurred: $e");
      // SqlConn.disconnect();
      return [];
    }
    // finally {
    //   if (SqlConn.isConnected==true) {
    //     debugPrint("Database connected, not popping context.");
    //   }
    //   else {
    //     debugPrint("from table");
    //     // If not connected, pop context to dismiss the dialog
    //     // showConnectionDialog(context,"TBL");
    //     debugPrint("Database not connected, popping context.");
    //   }
    // }
  }

  // getTableList(BuildContext context) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? os = await prefs.getString("os");
  //   String? smid = await prefs.getString("Sm_id");
  //   print("tabl para---------$os---$smid");
  //   isTableLoading = true;
  //   notifyListeners();
  //   try {
  //     var res = await SqlConn.readData("Kot_Table_List '$os','$smid'");
  //     var map = jsonDecode(res);
  //     tabllist.clear();
  //     if (map != null) {
  //       for (var item in map) {
  //         tabllist.add(item);
  //       }
  //     }
  //     print("tablelist-$res");

  //     isTableLoading = false;
  //     notifyListeners();
  //   } catch (e) {
  //     print("An unexpected error occurred: $e");
  //     SqlConn.disconnect();
  //     return [];
  //     // Handle other types of exceptions
  //   } finally {
  //     if (SqlConn.isConnected) {
  //       debugPrint("Database connected, not popping context.");
  //     } else {
  //       // If not connected, pop context to dismiss the dialog
  //       showConnectionDialog(context);
  //       debugPrint("Database not connected, popping context.");
  //     }
  //   }
  // }
  //////////////////////////////////////////////////////////
  getTableCtegory(BuildContext context) async {
    try {
      tableCategoryList.clear();
      tableCategoryList.add({"cate_id": 0, "Table_Category": "ALL"});
      notifyListeners();
      var res = await SqlConn.readData("Kot_Table_Category");
      var valueMap = json.decode(res);
      // print("login details----------$res");
      if (valueMap != null) {
        // LoginModel logModel = LoginModel.fromJson(valueMap);

        for (var item in valueMap) {
          tableCategoryList.add(item);
          notifyListeners();
        }
        selectedTableCat = tableCategoryList[0]["Table_Category"];
        notifyListeners();
        print("Table_CategoryList----$tableCategoryList");
      }
    } on PlatformException catch (e) {
      debugPrint("PlatformException Table_CategoryList: ${e.message}");
      debugPrint("not connected..Table_CategoryList..");
      // Navigator.pop(context);
      await showConnectionDialog(context, "TCAT", e.toString());
    } catch (e) {
      print("An unexpected error occurred: $e");
      // SqlConn.disconnect();
      // return [];
    }
    // catch (e) {
    //   print("An unexpected error occurred: $e");
    //   SqlConn.disconnect();
    // }
    // finally {
    //   if (SqlConn.isConnected == false) {
    //     print("hi");
    //     showConnectionDialog(context, "TCAT");
    //     debugPrint("Database not connected, popping context.");
    //   }
    // }
  }

///////////////////////////////////////////////////////////////////
  getSettings(BuildContext context, String sCode) async {
    try {
      settingsList.clear();
      notifyListeners();
      print("----Flt_GetSettings '$sCode'");
      var res = await SqlConn.readData("Flt_GetSettings '$sCode','KOT'");
      print("map-Flt_GetSettings-$res");
      var valueMap = json.decode(res);
      // print("login details----------$res");
      if (valueMap != null) {
        // LoginModel logModel = LoginModel.fromJson(valueMap);
        for (var item in valueMap) {
          settingsList.add(item);
          notifyListeners();
        }
        print("Settings List----$settingsList");
      }
    } on PlatformException catch (e) {
      debugPrint("PlatformException Settings List: ${e.message}");
      debugPrint("not connected..Settings List..");
      await showConnectionDialog(context, "SET", e.toString());
    } catch (e) {
      print("An unexpected error occurred: $e");
    }
  }

  getRoomList(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? os = await prefs.getString("os");
    String? smid = await prefs.getString("Sm_id");
    print("room para---------$os---$smid");
    isRoomLoading = true;
    notifyListeners();
    try {
      var res = await SqlConn.readData("Kot_Room_List '$os','$smid'");
      var map = jsonDecode(res);
      roomlist.clear();
      if (map != null) {
        for (var item in map) {
          roomlist.add(item);
        }
      }
      print("rooomlist-$res");

      isRoomLoading = false;
      notifyListeners();
    } on PlatformException catch (e) {
      debugPrint("PlatformException Room: ${e.message}");
      debugPrint("not connected..Room..");
      debugPrint(e.toString());
      // Navigator.pop(context);
      await showConnectionDialog(context, "ROM", e.toString());
    } catch (e) {
      print("An unexpected error occurred: $e");
      // SqlConn.disconnect();
      return [];
    }

    // finally {
    //   if (SqlConn.isConnected) {
    //     debugPrint("Database connected, not popping context.");
    //   }
    //    else
    //   {
    //     debugPrint("from room");
    //     // If not connected, pop context to dismiss the dialog
    //     // showConnectionDialog(context, "ROM");
    //     // showDialog(
    //     //   context: context,
    //     //   builder: (context) {
    //     //     return AlertDialog(
    //     //       title: Row(
    //     //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     //         children: [
    //     //           Text(
    //     //             "Not Connected.!",
    //     //             style: TextStyle(fontSize: 13),
    //     //           ),
    //     //           SpinKitCircle(
    //     //             color: Colors.green,
    //     //           )
    //     //         ],
    //     //       ),
    //     //       actions: [
    //     //         TextButton(
    //     //           onPressed: () async {
    //     //             await initYearsDb(context, "");
    //     //             Navigator.of(context).pop();
    //     //           },
    //     //           child: Text('Connect'),
    //     //         ),
    //     //       ],
    //     //     );
    //     //   },
    //     // );
    //     debugPrint("Database not connected, popping context.");
    //   }
    // }
  }

///////////////////////////////////
//   getCategoryList(BuildContext context) async {
//     isCategoryLoading = true;
//     notifyListeners();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? os = await prefs.getString("os");
//     String? smid = await prefs.getString("Sm_id");
//     print("cat para---------$os---------$tablID-----------$smid");
//     try {
//       var res = await SqlConn.readData("Kot_ItCategory_List '$os','$smid'");
//       var map = jsonDecode(res);
//       catlist.clear();
//       if (map != null) {
//         for (var item in map) {
//           catlist.add(item);
//         }
//       }
//       // catlist=[{"Cat_Id":"VGMHD1", "Cat_Name":"food"},{"Cat_Id":"VGMHD2", "Cat_Name":"black coffee"},{"Cat_Id":"VGMHD3", "Cat_Name":"FOOD"},{"Cat_Id":"VGMHD3", "Cat_Name":"RICE"},{"Cat_Id":"VGMHD3", "Cat_Name":"SALAD"},{"Cat_Id":"VGMHD3", "Cat_Name":"SNACKS"},];
//       print("categoryList...................-$res");

//       isCategoryLoading = false;
//       notifyListeners();
//     } on PlatformException catch (e) {
//       debugPrint("PlatformException Cat List: ${e.message}");
//       debugPrint("not connected..Cat List..");
//       debugPrint(e.toString());
//       // Navigator.pop(context);
//       await showConnectionDialog(context, "CAT", e.toString());
//     } catch (e) {
//       print("An unexpected error occurred: $e");
//       // SqlConn.disconnect();
//       return [];
//     }
//   }

// ///////////////////////////////////
//   /////////////////////////////////////////////////
//   getItemList(BuildContext context) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     // String? cid = await prefs.getString("cid");
//     // String? db = prefs.getString("db_name");
//     // String? brId = await prefs.getString("br_id");
//     String? os = await prefs.getString("os");
//     int? cartNo = await prefs.getInt("cartNo");

//     print("catttt iidd----$catlID---$cartNo----$os");
//     isLoading = true;
//     notifyListeners();
//     try {
//       var res =
//           await SqlConn.readData("Kot_ItemList '$catlID','$cartNo','$os'");
//       var valueMap = json.decode(res);
//       print("item list----------$valueMap");
//       itemlist.clear();
//       if (valueMap != null) {
//         for (var item in valueMap) {
//           itemlist.add(item);
//         }
//       }
//       isSearch = false;
//       notifyListeners();
//       qty = List.generate(itemlist.length, (index) => TextEditingController());
//       descr =
//           List.generate(itemlist.length, (index) => TextEditingController());
//       isAdded = List.generate(itemlist.length, (index) => false);
//       response = List.generate(itemlist.length, (index) => 0);
//       for (int i = 0; i < itemlist.length; i++) {
//         qty[i].text = "1.0";
//         descr[i].text = "";
//         response[i] = 0;
//       }
//       isLoading = false;
//       notifyListeners();
//     } on PlatformException catch (e) {
//       debugPrint("PlatformException Item List: ${e.message}");
//       debugPrint("not connected..Item List..");
//       debugPrint(e.toString());
//       // Navigator.pop(context);
//       await showConnectionDialog(context, "ITM", e.toString());
//     } catch (e) {
//       print("An unexpected error occurred: $e");
//       // SqlConn.disconnect();
//       return [];
//     }
//   }
  getCategoryList(BuildContext context) async {
    isCategoryLoading = true;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? os = await prefs.getString("os");
    String? smid = await prefs.getString("Sm_id");
    print("cat para---------$os---------$tablID-----------$smid");
    try {
      var res = await SqlConn.readData("Kot_ItCategory_List '$os','$smid'");
      var map = jsonDecode(res);
      catlist.clear();
      if (map != null) {
        for (var item in map) {
          catlist.add(item);
        }
      }
      // catlist=[{"Cat_Id":"VGMHD1", "Cat_Name":"food"},{"Cat_Id":"VGMHD2", "Cat_Name":"food1"},{"Cat_Id":"VGMHD3", "Cat_Name":"food2"},{"Cat_Id":"VGMHD4", "Cat_Name":"food3"}];
      print("categoryList...................-$res");
      print(
          "categoryList1st...................-${catlist[0]["Cat_Id"].toString()}");
      await prefs.setString("CAT_id", catlist[0]["Cat_Id"].toString());
      print("CATID default--${prefs.getString("CAT_id")}");
      isCategoryLoading = false;
      notifyListeners();
    } on PlatformException catch (e) {
      debugPrint("PlatformException Cat List: ${e.message}");
      debugPrint("not connected..Cat List..");
      debugPrint(e.toString());
      // Navigator.pop(context);
      await showConnectionDialog(context, "CAT", e.toString());
    } catch (e) {
      print("An unexpected error occurred: $e");
      // SqlConn.disconnect();
      return [];
    }
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
    String? cat_id = await prefs.getString("CAT_id");
    String? cat_name = await prefs.getString("CAT_nm");

    print("catttt iidd----$cat_id---$cat_name---$cartNo----$os");
    isLoading = true;
    notifyListeners();
    try {
      var res =
          await SqlConn.readData("Kot_ItemList '$cat_id','$cartNo','$os'");
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
      descr =
          List.generate(itemlist.length, (index) => TextEditingController());
      isAdded = List.generate(itemlist.length, (index) => false);
      response = List.generate(itemlist.length, (index) => 0);
      for (int i = 0; i < itemlist.length; i++) {
        qty[i].text = "1.0";
        descr[i].text = "";
        response[i] = 0;
      }
      isLoading = false;
      notifyListeners();
    } on PlatformException catch (e) {
      debugPrint("PlatformException Item List: ${e.message}");
      debugPrint("not connected..Item List..");
      debugPrint(e.toString());
      // Navigator.pop(context);
      await showConnectionDialog(context, "ITM", e.toString());
    } catch (e) {
      print("An unexpected error occurred: $e");
      // SqlConn.disconnect();
      return [];
    }
  }

  clearAllData(BuildContext context) async {
    tablID = "";
    roomID = "0";
    catlID = "";
    roomnm = "";
    tablname = "";
    guestnm = " ";
    cartItems.clear();
    cartTotal = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("table_id");
    prefs.remove("table_nm");
    prefs.remove("room_id");
    prefs.remove("room_nm");
    prefs.remove("gst_nm");
    prefs.remove("cartNo");
    notifyListeners();
    print("cleared...");
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
    String pp = "Kot_GetCartno '$os'";
    print("cart conn $pp");
    try {
      var res = await SqlConn.readData("Kot_GetCartno '$os'");
      // ignore: avoid_print
      print("cart map------$res");
      var valueMap = json.decode(res);
      // cartId = valueMap[0]["CartId"];
      prefs.setInt("cartNo", valueMap[0]["CartId"]);
      int? c = prefs.getInt("cartNo");
      print("cart No------$c");
      notifyListeners();
    } on PlatformException catch (e) {
      debugPrint("PlatformException CARTNO: ${e.message}");
      debugPrint("not connected..CARTNO..");
      debugPrint(e.toString());
      // Navigator.pop(context);
      await showConnectionDialog(context, "CAR", e.toString());
    } catch (e) {
      print("An unexpected error occurred: $e");
      // SqlConn.disconnect();
      return [];
    }
  }

  getIDss() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cart_id = prefs.getInt("cartNo")!;
    room_ID = prefs.getString("room_id");
    tabl_ID = prefs.getString("table_id")!;
    tabl_name = prefs.getString("table_nm")!;
    room_nm = prefs.getString("room_nm");
    guest_nm = prefs.getString("gst_nm");
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

  setDescr(String val, int index) {
    descr[index].text = "rrrrrr";
    notifyListeners();
    print(("descr-----$val----${descr[index].text}"));
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
    String? tab = await prefs.getString("table_id");
    String? rum = await prefs.getString("room_id");
    String? gus = await prefs.getString("gst_nm");
    String? smid = await prefs.getString("Sm_id");

    isAdded[index] = true;
    notifyListeners();
    try {
      print("stattuss----$status");
      var res;
      notifyListeners();
      if (type == "from cart") {
        // res = await SqlConn.readData(
        //     "Flt_Update_Cart_Kot $cartid,'$dateTime','${map["Cart_Cust_ID"]}',0,'$os','${map["Cart_Batch"]}',$qty,${map["Cart_Rate"]},${map["Cart_Pid"]},'${map["Cart_Unit"]}','${map["Pkg"]}',$status");
      } else if (type == "from itempage") {
        // double rt=double.parse(map["SRATE"]);
        // if (guestnm==" ") {
        //   String gst= ' ';
        // }
        // else{
        //   gst=
        // }
        print("------tablRmGUS==$tab,$rum,$gus");
        print(
            "Kot_Save_Cart--------------- $cartid,'$dateTime','$smid',$tab,$rum,$gus,0,'$os','${map["code"]}',$qty,${map["SRATE"]},${map["ProdId"]},"
            ",'$des',1,'',$status");
        res = await SqlConn.readData(
          "Kot_Save_Cart $cartid,'$dateTime','$smid','$tab','$rum','$gus',0,'$os','${map["code"]}',$qty,${map["SRATE"]},${map["ProdId"]},'','$des',1,'',$status",
        );
        print(
            "data added..............--------------------------------------------------------------");
        //getItemList(context);
      }

      // ignore: avoid_print
      print("inserted to cart---$res");
      var valueMap = json.decode(res);
      response[index] = valueMap[0]["Result"];
      cartTotal = valueMap[0]["TotalCount"];
      isAdded[index] = false;
      notifyListeners();
    } on PlatformException catch (e) {
      debugPrint("PlatformException ADD IITEM: ${e.message}");
      debugPrint("not connected..ADD IITEM..");
      debugPrint(e.toString());
      // Navigator.pop(context);
      await showConnectionDialog(context, "ADDITEM", e.toString());
    } catch (e) {
      print("An unexpected error occurred: $e");
      // SqlConn.disconnect();
      return [];
    }
  }

////////////////////////////////////////////////////////
  updateCart2(
    BuildContext context,
    Map map,
    int status,
    String? desc,
    double qty,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? cid = await prefs.getString("cid");
    // String? db = prefs.getString("db_name");
    // String? brId = await prefs.getString("br_id");
    String? os = await prefs.getString("os");
    int? cartid = await prefs.getInt("cartNo");
    int? c = prefs.getInt("cartNo");
    String? smid = await prefs.getString("Sm_id");
    // isAdded[index] = true;
    notifyListeners();
    try {
      print("stattuss----$status");
      var res;
      notifyListeners();
      // if (type == "from cart") {
      //   // res = await SqlConn.readData(
      //   //     "Flt_Update_Cart_Kot $cartid,'$dateTime','${map["Cart_Cust_ID"]}',0,'$os','${map["Cart_Batch"]}',$qty,${map["Cart_Rate"]},${map["Cart_Pid"]},'${map["Cart_Unit"]}','${map["Pkg"]}',$status");
      // } else if (type == "from itempage") {
      // double rt=double.parse(map["SRATE"]);
      // print("Kot_Save_Cart--------------- $cartid,'$dateTime','$smid',$tablID,$roomID,gust,0,'$os','${map["code"]}',$qty,${map["SRATE"]},${map["ProdId"]},"",'dec',1,'',$status");
      if (status == 0) {
        res = await SqlConn.readData(
          "Kot_Update_CartItems '${map["Cart_ID"]}','${map["Cart_Table_ID"]}','$os','${map["Cart_Row"]}',$qty,'$desc',$status",
        );
        print(
            "data Edited..........$res---------------------------------------------------");
      } else {
        res = await SqlConn.readData(
          "Kot_Update_CartItems '${map["Cart_ID"]}','${map["Cart_Table_ID"]}','$os','${map["Cart_Row"]}',$qty,'${map["Cart_Description"]}',$status",
        );
        print(
            "data deleted.........$res---------------------------------------------------");
      }

      //getItemList(context);
      // }

      // ignore: avoid_print
      // print("insert cart---$res");
      var valueMap = json.decode(res);
      // response[index] = valueMap[0]["Result"];
      // cartTotal=valueMap[0]["TotalCount"];
      // isAdded[index] = false;
      // getItemList(context);
      notifyListeners();
    } on PlatformException catch (e) {
      debugPrint("PlatformException UPD IITEM: ${e.message}");
      debugPrint("not connected..UPD IITEM..");
      debugPrint(e.toString());
      // Navigator.pop(context);
      await showConnectionDialog(context, "UPDITEM", e.toString());
    } catch (e) {
      print("An unexpected error occurred: $e");
      // SqlConn.disconnect();
      return [];
    }
  }

  finalPrint(
    BuildContext context,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? cid = await prefs.getString("cid");
    String? fbn = await prefs.getString("FBNO");
    try {
      print("---------Kot_Print_kot $fbn");
      var res = await SqlConn.readData("Kot_Print_kot '$fbn'");
      // if (res.isNotEmpty)
      //   if (res[0]["Save_Status"] == "Success") {
      //     print("Saveedddddddd ! $res");
      //     // print("Saved successfully! FB_no: ${response['FB_no']}");
      //     return true;
      //   } else {
      //     print("Save failed: $res");
      //     return false;
      //   }
      // } else {
      //   print("No data returned or empty result: $res");
      //   return false;
      // }
      print("Print success ! $res");
      // return true;
    } on PlatformException catch (e) {
      debugPrint("PlatformException Kot_Print_Kot: ${e.message}");
      debugPrint("not connected..Kot_Print_Kot..");
      debugPrint(e.toString());
      // Navigator.pop(context);
      await showConnectionDialog(context, "FINP", e.toString());
      // return false;
    } catch (e) {
      print("An unexpected error occurred: $e");
      // return false;
    }
  }

  finalSave(
    BuildContext context,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? cid = await prefs.getString("cid");
    // String? db = prefs.getString("db_name");
    // String? brId = await prefs.getString("br_id");
    String? os = await prefs.getString("os");
    int? cartNo = await prefs.getInt("cartNo");

    // for(var item in cartItems){
    // if(item['Cart_Row']!=0){
    try {
      List r = [];
      var res;
      int cartlen = cartItems.length;
      print("---------Kot_Save_Kot '$os',$cartNo,$cartlen");
      res = await SqlConn.readData("Kot_Save_Kot '$os',$cartNo,$cartlen");
      print("ress==${res.runtimeType}");
      //  res=  [{"FB_no":"ZV13", "Save_Status":"Success"}];
      if (res is String) {
        // Convert JSON string to List
        res = jsonDecode(res);
      }
      if (res.isNotEmpty) {
        r.add(res[0]);
        if (r[0]['Save_Status'].toString().trimLeft().toLowerCase() ==
            "success") {
          print("Saveedddddddd ! $res");
          print("List rr=${r[0]['FB_no'].toString()}");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("FBNO", r[0]['FB_no'].toString().trimLeft());
          print("okkkk");
          notifyListeners();
          return true;
        } else {
          print("Savee failed ! $res");
          return false;
        }
      } else {
        return false;
      }
      // if (res.isNotEmpty) {

      //   if (res[0]["Save_Status"] == "Success") {
      //     print("Saveedddddddd ! $res");
      //     // print("Saved successfully! FB_no: ${response['FB_no']}");
      //     return true;
      //   } else {
      //     print("Save failed: $res");
      //     return false;
      //   }
      // } else {
      //   print("No data returned or empty result: $res");
      //   return false;
      // }
    } on PlatformException catch (e) {
      debugPrint("PlatformException Kot_Save_Kot: ${e.message}");
      debugPrint("not connected..Kot_Save_Kot..");
      debugPrint(e.toString());
      // Navigator.pop(context);
      await showConnectionDialog(context, "FIN", e.toString());
      return false;
    } catch (e) {
      print("An unexpected error occurred: $e");
      return false;
    }
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
    String? tb = prefs.getString("table_id");
    isCartLoading = true;
    notifyListeners();

    print(
        "jbjhbvbv -------------{Flt_Sp_Get_Unsaved_Cart_KOT $cartNo,'$tb','$os'}");
    try {
      var res =
          await SqlConn.readData("Kot_Get_Unsaved_Cart $cartNo,'$tb','$os'");
      var valueMap = json.decode(res);

      notifyListeners();
      print("view cart---$res");

      cartItems.clear();
      notifyListeners();
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
      karttotal = sum;
      if (cartItems.isEmpty) {
        cartTotal = 0;
        notifyListeners();
      }
      cartTotal = cartItems.length;
      isCartLoading = false;
      notifyListeners();
    } on PlatformException catch (e) {
      debugPrint("PlatformException Viw CART: ${e.message}");
      debugPrint("not connected..Viw CART..");
      debugPrint(e.toString());
      // Navigator.pop(context);
      await showConnectionDialog(context, "VCART", e.toString());
    } catch (e) {
      print("An unexpected error occurred: $e");
      // SqlConn.disconnect();
      return [];
    }
  }

/////////////////////////////////////////////////////////////////////////////////////////
  viewKot(
    BuildContext context,
    String date,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? cid = await prefs.getString("cid");
    // String? db = prefs.getString("db_name");
    // String? brId = await prefs.getString("br_id");
    String? os = await prefs.getString("os");

    isKOTLoading = true;
    notifyListeners();

    print("Kot List -------------{Kot_Open_kot'$os','$date'}");
    try {
      var res = await SqlConn.readData("Kot_Open_kot'$os','$date'");
      var valueMap = json.decode(res);
      isKOTLoading = false;
      notifyListeners();
      print("view Kot---$res");
      kotItems.clear();
      for (var item in valueMap) {
        kotItems.add(item);
      }

      //  kotItems=[{"Kot_No":"AT3", "kot_Date":"2024-07-20 00:00:00.0", "kot_time":"2024-07-20 10:43:12.57", "Table_No":"t1", "Room_No":102, "Status":0},
      //   {"Kot_No":"AT2", "kot_Date":"2024-07-20 00:00:00.0", "kot_time":"2024-07-20 09:54:44.667", "Table_No":"101T", "Room_No":10, "Status":0},
      //    {"Kot_No":"AT1", "kot_Date":"2024-07-20 00:00:00.0", "kot_time":"2024-07-20 09:52:55.043", "Table_No":"101T", "Room_No":102, "Status":1},  {"Kot_No":"AT2", "kot_Date":"2024-07-20 00:00:00.0", "kot_time":"2024-07-20 09:54:44.667", "Table_No":"101T", "Room_No":10, "Status":0},
      //    {"Kot_No":"AT1", "kot_Date":"2024-07-20 00:00:00.0", "kot_time":"2024-07-20 09:52:55.043", "Table_No":"101T", "Room_No":102, "Status":1},  {"Kot_No":"AT2", "kot_Date":"2024-07-20 00:00:00.0", "kot_time":"2024-07-20 09:54:44.667", "Table_No":"101T", "Room_No":10, "Status":0},
      //    {"Kot_No":"AT1", "kot_Date":"2024-07-20 00:00:00.0", "kot_time":"2024-07-20 09:52:55.043", "Table_No":"101T", "Room_No":102, "Status":1},  {"Kot_No":"AT2", "kot_Date":"2024-07-20 00:00:00.0", "kot_time":"2024-07-20 09:54:44.667", "Table_No":"101T", "Room_No":10, "Status":0},
      //    {"Kot_No":"AT1", "kot_Date":"2024-07-20 00:00:00.0", "kot_time":"2024-07-20 09:52:55.043", "Table_No":"101T", "Room_No":102, "Status":1}];
      notifyListeners();
    } on PlatformException catch (e) {
      debugPrint("PlatformException Kot List: ${e.message}");
      debugPrint("not connected..Kot List..");
      debugPrint(e.toString());
      // Navigator.pop(context);
      await showConnectionDialog(context, "VWKOT", e.toString());
    } catch (e) {
      print("An unexpected error occurred: $e");
      // SqlConn.disconnect();
      return [];
    }
  }

///////////////////////////////////////////////////////////////////////////////////

  kitchenDisplayData(
    BuildContext context,
    String date,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? os = await prefs.getString("os");
    isKOTLoading = true;
    notifyListeners();

    print("Kot List -------------{Kot_status_list '$date'}");
    try {
      var res = await SqlConn.readData("Kot_status_list '$date'");
      var valueMap = json.decode(res);
      isKOTLoading = false;
      notifyListeners();
      print("view Kot_status_list---$res");
      kitchenKotItems.clear();
      kitchenKotItems = [
        {
          "Kot_No": "QL57",
          "kot_Date": "2024-11-19 00:00:00.0",
          "kot_time": "2024-11-19 10:02:43.79",
          "Table_No": "5C",
          "Room_No": "",
          "ITEM": "TENDER COCONUT",
          "msg": "",
          "qty": 1.00,
          "status": 0
        },
        {
          "Kot_No": "QL58",
          "kot_Date": "2024-11-19 00:00:00.0",
          "kot_time": "2024-11-19 10:02:43.79",
          "Table_No": "5C",
          "Room_No": "",
          "ITEM": "TEA",
          "msg": "",
          "qty": 2.00,
          "status": 0
        }
      ];
      // for (var item in valueMap) {
      //   kitchenKotItems.add(item);
      // }
       isCallDisabled = List.generate(kitchenKotItems.length, (index) => false);
      await groupByTable(kitchenKotItems);
      //  kotItems=[{"Kot_No":"AT3", "kot_Date":"2024-07-20 00:00:00.0", "kot_time":"2024-07-20 10:43:12.57", "Table_No":"t1", "Room_No":102, "Status":0},
      //   {"Kot_No":"AT2", "kot_Date":"2024-07-20 00:00:00.0", "kot_time":"2024-07-20 09:54:44.667", "Table_No":"101T", "Room_No":10, "Status":0},
      //    {"Kot_No":"AT1", "kot_Date":"2024-07-20 00:00:00.0", "kot_time":"2024-07-20 09:52:55.043", "Table_No":"101T", "Room_No":102, "Status":1},  {"Kot_No":"AT2", "kot_Date":"2024-07-20 00:00:00.0", "kot_time":"2024-07-20 09:54:44.667", "Table_No":"101T", "Room_No":10, "Status":0},
      //    {"Kot_No":"AT1", "kot_Date":"2024-07-20 00:00:00.0", "kot_time":"2024-07-20 09:52:55.043", "Table_No":"101T", "Room_No":102, "Status":1},  {"Kot_No":"AT2", "kot_Date":"2024-07-20 00:00:00.0", "kot_time":"2024-07-20 09:54:44.667", "Table_No":"101T", "Room_No":10, "Status":0},
      //    {"Kot_No":"AT1", "kot_Date":"2024-07-20 00:00:00.0", "kot_time":"2024-07-20 09:52:55.043", "Table_No":"101T", "Room_No":102, "Status":1},  {"Kot_No":"AT2", "kot_Date":"2024-07-20 00:00:00.0", "kot_time":"2024-07-20 09:54:44.667", "Table_No":"101T", "Room_No":10, "Status":0},
      //    {"Kot_No":"AT1", "kot_Date":"2024-07-20 00:00:00.0", "kot_time":"2024-07-20 09:52:55.043", "Table_No":"101T", "Room_No":102, "Status":1}];
      notifyListeners();
    } on PlatformException catch (e) {
      debugPrint("PlatformException Kot_status_list: ${e.message}");
      debugPrint("not connected..Kot_status_list..");
      debugPrint(e.toString());
      // Navigator.pop(context);
      // await showConnectionDialog(context, "VWKOT", e.toString());
    } catch (e) {
      print("An unexpected error occurred: $e");
      // SqlConn.disconnect();
      return [];
    }
  }

  Map<String, List<Map<String, dynamic>>> groupByTable(
      List<Map<String, dynamic>> items) {
    groupedData.clear();
      
   
    notifyListeners();
    for (var item in items) {
      Map<String, dynamic> temp={};
      final tableNo =
          item["Table_No"]?.toString().trim().toUpperCase() ?? "NO TABLE";
      if (!groupedData.containsKey(tableNo)) {
        groupedData[tableNo] = [];
      }
      temp['Kot_No']=item['Kot_No'];
      temp['kot_Date']=item['kot_Date'];
      temp['kot_time']=item['kot_time'];
      temp['Table_No']=item['Table_No'];
      temp['Room_No']=item['Room_No'];
      temp['ITEM']=item['ITEM'];
      temp['msg']=item['msg'];
      temp['qty']=item['qty'];
      temp['status']=item['status'];
      temp['isCallDisabled']=false;
      groupedData[tableNo]!.add(temp);
      // groupedData[tableNo]!.add({"isCallDisabled":true});
    }
    
    print("grouped data==$groupedData");
    return groupedData;
  }

  ///
  viewTableItems(BuildContext context, String tbl, int status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? cid = await prefs.getString("cid");
    // String? db = prefs.getString("db_name");
    // String? brId = await prefs.getString("br_id");
    String? os = await prefs.getString("os");

    istableItemListLoading = true;
    isKOTItemListLoading = true;
    notifyListeners();

    print("TableItems List -------------{Kot_Table_Items'$tbl',$status}");
    var res = await SqlConn.readData("Kot_Table_Items '$tbl',$status");
    var valueMap = json.decode(res);
    istableItemListLoading = false;
    isKOTItemListLoading = false;
    notifyListeners();
    if (status == 0) {
      print("TableItems---$res");
      tableItemList.clear();
      for (var item in valueMap) {
        tableItemList.add(item);
      }
    } else {
      print("KOTItems---$res");
      kotItemList.clear();
      for (var item in valueMap) {
        kotItemList.add(item);
      }
    }
    //  kotItems=[{"Kot_No":"AT3", "kot_Date":"2024-07-20 00:00:00.0", "kot_time":"2024-07-20 10:43:12.57", "Table_No":"t1", "Room_No":102, "Status":0}, {"Kot_No":"AT2", "kot_Date":"2024-07-20 00:00:00.0", "kot_time":"2024-07-20 09:54:44.667", "Table_No":"101T", "Room_No":10, "Status":0}, {"Kot_No":"AT1", "kot_Date":"2024-07-20 00:00:00.0", "kot_time":"2024-07-20 09:52:55.043", "Table_No":"101T", "Room_No":102, "Status":1}];
    notifyListeners();
  }

////////////////////////////////////////////////////////////////////////
  searchTable(String val) {
    filteredlist.clear();
    notifyListeners();
    filteredlist = tabllistCAT;
    if (val.isNotEmpty) {
      isSearch = true;
      notifyListeners();

      filteredlist = tabllistCAT
          .where((e) => e["Table_Name"]
              .toString()
              .trimLeft()
              .toLowerCase()
              .contains(val.toLowerCase()))
          .toList();
    } else {
      isSearch = false;
      notifyListeners();
      filteredlist = tabllistCAT;
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

  searchRoom(String val) {
    filteredroomlist = roomlist;
    print("searchroom----$val--");
    if (val.isNotEmpty) {
      isRoomSearch = true;

      filteredroomlist = roomlist
          .where((e) => e["Room_Name"]
              .toString()
              .trimLeft()
              .toLowerCase()
              .contains(val.toLowerCase()))
          .toList();
    } else {
      isRoomSearch = false;

      filteredroomlist = roomlist;
      notifyListeners();
    }
    print("filtered_Roomm_List----------------$filteredroomlist");
    notifyListeners();
  }
  // searchRoom(String val) {
  //   filteredroomlist = roomlist;
  //   if (val.isNotEmpty) {
  //     isRoomSearch = true;
  //     notifyListeners();

  //     filteredroomlist = roomlist
  //         .where((e) => e["Room_Name"]
  //             .toString()
  //             .trimLeft()
  //             .toLowerCase()
  //             .contains(val.toLowerCase()))
  //         .toList();
  //   } else {
  //     isRoomSearch = false;
  //     notifyListeners();
  //     filteredroomlist = roomlist;
  //   }
  //   // qty =
  //   //     List.generate(filteredlist.length, (index) => TextEditingController());
  //   // isAdded = List.generate(filteredlist.length, (index) => false);
  //   // response = List.generate(filteredlist.length, (index) => 0);
  //   // for (int i = 0; i < filteredlist.length; i++) {
  //   //   qty[i].text = "1.0";
  //   //   response[i] = 0;
  //   // }
  //   print("filtered_Roomm_List----------------$filteredroomlist");
  //   notifyListeners();
  // }

  searchItem(String val) {
    filteredlist = itemlist;
    if (val.isNotEmpty) {
      isSearch = true;
      notifyListeners();

      filteredlist = itemlist
          .where((e) => e["Product"]
              .toString()
              .trimLeft()
              .toLowerCase()
              .contains(val.toLowerCase()))
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
  setTableID(String id, String tbNM, BuildContext context) async {
    tablID = id;
    tablname = tbNM;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("table_id", id);
    prefs.setString("table_nm", tbNM);

    print("tablID----$id");
    notifyListeners();
  }

  setRoomID(String id, String rmnm, String gst, BuildContext context) async {
    roomID = id;
    roomnm = rmnm;
    guestnm = gst;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("room_id", id);
    prefs.setString("room_nm", rmnm);
    prefs.setString("gst_nm", gst);
    print("RoomID----$id, Nmae: $rmnm, gust -$gst");
    notifyListeners();
  }

  updateSm_id() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("Sm_id", selectedItemStaff!['Sm_id']);
    await prefs.setInt("Sm_Tbl_catid", selectedItemStaff!['Tbl_catid']);
    if (selectedItemStaff!['Tbl_catid'] != 0) {
      await selectcatname(selectedItemStaff!['Tbl_catid']);
    } else {
      await prefs.setString("Sm_Tbl_catName", "ALL");
    }
    notifyListeners();
  }

  selectcatname(int catid) async {
    print("catID===$catid");
    print("tableCategoryList===$tableCategoryList");
    for (int i = 0; i < tableCategoryList.length; i++) {
      if (tableCategoryList[i]["cate_id"] == catid) {
        print("-----${tableCategoryList[i]["cate_id"]}");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("Sm_Tbl_catName",
            tableCategoryList[i]["Table_Category"].toString());
      }
    }
    notifyListeners();
  }

  updateTableCAT(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("Sm_Tbl_catName", selectedItemTablecat!['Table_Category']);
    print("tableCAT Updated----${selectedItemTablecat!['Table_Category']}");
    notifyListeners();
    getTableList(context);
  }

  ///////////////........................../////////////////////////////
  // setCatID(String id, BuildContext context) {
  //   catlID = id;
  //   print("catlID----$catlID");
  //   notifyListeners();
  // }
  setCatID(String id, String nm, BuildContext context) async {
    // catlID = id;
    // catNM=nm;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("CAT_id", id);
    prefs.setString("CAT_nm", nm);
    print("cat_ID----$id,  cat_nm---$nm");
    notifyListeners();
  }

  /////////////////////////////////////////////////////////////////////
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
    table_catID = await prefs.getInt("Sm_Tbl_catid");
    table_catNM = await prefs.getString("Sm_Tbl_catName");
    cartNum = prefs.getInt("cartNo");
    notifyListeners();
  }

  Future<void> showConnectionDialog(
      BuildContext context, String from, String er) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Not Connected.!",
                style: TextStyle(fontSize: 13),
              ),
              SpinKitCircle(
                color: Colors.green,
              ),
            ],
          ),
          actions: [
            InkWell(
              child: Text('Connect'),
              onLongPress: () async {
                await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(er),
                      );
                    });
              },
              onTap: () async {
                await initYearsDb(context, from);
                Navigator.of(context).pop();
              },
            )
            // TextButton(
            //   onPressed: () async {
            //     await initYearsDb(context, from);
            //     Navigator.of(context).pop();
            //   },
            //   child: Text('Connect'),
            // ),
          ],
        );
      },
    );
  }

  Future<void> showINITConnectionDialog(
      BuildContext context, String from, String er) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Not Connected..!",
                style: TextStyle(fontSize: 13),
              ),
              SpinKitCircle(
                color: Colors.green,
              ),
            ],
          ),
          actions: [
            InkWell(
              child: Text('Connect'),
              onLongPress: () async {
                TextEditingController dbc = TextEditingController();
                TextEditingController ipc = TextEditingController();
                TextEditingController usrc = TextEditingController();
                TextEditingController portc = TextEditingController();
                TextEditingController pwdc = TextEditingController();
                bool pressed = false;
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? db = prefs.getString("db_name");
                String? ip = prefs.getString("ip");
                String? port = prefs.getString("port");
                String? un = prefs.getString("usern");
                String? pw = prefs.getString("pass_w");
                await showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (BuildContext context,
                                void Function(void Function()) setState) =>
                            AlertDialog(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  onLongPress: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(er),
                                          );
                                        });
                                  },
                                  child: Icon(
                                    Icons.error_outline,
                                    color: Colors.redAccent,
                                  )),
                              IconButton(
                                  style: ButtonStyle(),
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop(false);
                                  },
                                  icon: Icon(Icons.close))
                            ],
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('DB Deatails'),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 90, child: Text("DB")),
                                  pressed
                                      ? SizedBox(
                                          width: 150,
                                          child: TextFormField(
                                            controller: dbc,
                                          ))
                                      : Text(" :  ${db.toString()}")
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 90, child: Text("IP")),
                                  pressed
                                      ? SizedBox(
                                          width: 140,
                                          child: TextFormField(
                                            controller: ipc,
                                          ))
                                      : Text(" :  ${ip.toString()}")
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 90, child: Text("PORT")),
                                  pressed
                                      ? SizedBox(
                                          width: 150,
                                          child: TextFormField(
                                            controller: portc,
                                          ))
                                      : Text(" :  ${port.toString()}")
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 90, child: Text("USERNAME")),
                                  pressed
                                      ? SizedBox(
                                          width: 150,
                                          child: TextFormField(
                                            controller: usrc,
                                          ))
                                      : Text(" :  ${un.toString()}")
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 90, child: Text("PASSWORD")),
                                  pressed
                                      ? SizedBox(
                                          width: 150,
                                          child: TextFormField(
                                            controller: pwdc,
                                          ))
                                      : Text(" :  ${pw.toString()}")
                                ],
                              )
                            ],
                          ),
                          actions: <Widget>[
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    pressed = true;
                                  });

                                  dbc.text = db.toString();
                                  ipc.text = ip.toString();
                                  portc.text = port.toString();
                                  usrc.text = un.toString();
                                  pwdc.text = pw.toString();
                                  print("pressed---$pressed");
                                },
                                icon: Icon(Icons.edit)),
                            TextButton(
                              onPressed: () {
                                prefs.setString(
                                    "old_db_name", dbc.text.toString());
                                prefs.setString("db_name", dbc.text.toString());
                                prefs.setString("ip", ipc.text.toString());
                                prefs.setString("port", portc.text.toString());
                                prefs.setString("usern", usrc.text.toString());
                                prefs.setString("pass_w", pwdc.text.toString());
                                // setState(() {});
                                Navigator.of(context, rootNavigator: true).pop(
                                    false); // dismisses only the dialog and returns false
                              },
                              child: Text('UPDATE'),
                            ),
                          ],
                        ),
                      );
                    });
              },
              onTap: () async {
                await initDb(context, "");
                Navigator.of(context).pop();
              },
            )
            // TextButton(
            //   onPressed: () async {
            //     await initDb(context,"");
            //     Navigator.of(context).pop();
            //   },
            //   child: Text('Connect'),
            // ),
          ],
        );
      },
    );
  }
}
