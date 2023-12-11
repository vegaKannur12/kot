// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:sql_conn/sql_conn.dart';
// import 'package:trafiqpro/db_helper.dart';
// import 'package:trafiqpro/screen/db_selection_page.dart';
// import 'package:trafiqpro/screen/home_page.dart';
// import '../components/common_data.dart';
// import '../components/custom_snackbar.dart';
// import '../components/external_dir.dart';
// import '../components/network_connectivity.dart';
// import '../model/registration_model.dart';
// import '../screen/authentication/login.dart';

// class RegistrationController extends ChangeNotifier {
//   String? userName;
//   bool scheduleOpend = false;
//   bool isMenuLoading = false;
//   bool isAdminLoading = false;
//   bool isServSchedulelIstLoadind = false;
//   int scheduleListCount = 0;
//   String? pendingEnq;
//   String? pendingQtn;
//   bool isdbLoading = false;
//   List<Map<String, dynamic>> db_list = [];
//   String? cnfQut;
//   String? pendingSer;
//   String? cust_id;
//   String? cust_name;
//   String? name;
//   List<String> servceScheduldate = [];
//   bool isProdLoding = false;
//   DateTime now = DateTime.now();
//   String? dateToday;
//   int servicescheduleListCount = 0;
//   List<Map<String, dynamic>> todyscheduleList = [];
//   List<Map<String, dynamic>> tomarwscheduleList = [];

//   List<Map<String, dynamic>> servicescheduleList = [];
//   List<Map<String, dynamic>> servicesProdList = [];
//   List<bool> showComplaint = [];
//   bool isSchedulelIstLoadind = false;
//   String? staffName;
//   bool isLoading = false;
//   bool isLoginLoading = false;

//   ExternalDir externalDir = ExternalDir();
//   String? menuIndex;
//   String? fp;
//   String? cid;
//   String? cname;

//   String? sof;
//   int? qtyinc;
//   String? uid;
//   List<Map<String, dynamic>> menuList = [];
//   List<Map<String, dynamic>> confrmedQuotGraph = [];
//   List<Map<String, dynamic>> userservDone = [];
//   String? appType;
//   String? bId;
//   // ignore: non_constant_identifier_names
//   List<CD> c_d = [];
//   String? firstMenu;
// ///////////////////////////////////////////////////////////////////
//   Future<RegistrationData?> postRegistration(
//       String companyCode,
//       String? fingerprints,
//       String phoneno,
//       String deviceinfo,
//       BuildContext context) async {
//     NetConnection.networkConnection(context).then((value) async {
//       print("Text fp...$fingerprints---$companyCode---$phoneno---$deviceinfo");
//       // ignore: prefer_is_empty
//       if (companyCode.length >= 0) {
//         appType = companyCode.substring(10, 12);
//       }
//       if (value == true) {
//         try {
//           Uri url =
//               Uri.parse("https://trafiqerp.in/order/fj/get_registration.php");
//           Map body = {
//             'company_code': companyCode,
//             'fcode': fingerprints,
//             'deviceinfo': deviceinfo,
//             'phoneno': phoneno
//           };
//           // ignore: avoid_print
//           print("register body----$body");
//           isLoading = true;
//           notifyListeners();
//           http.Response response = await http.post(
//             url,
//             body: body,
//           );
//           // print("body $body");
//           var map = jsonDecode(response.body);
//           // ignore: avoid_print
//           print("regsiter map----$map");
//           RegistrationData regModel = RegistrationData.fromJson(map);

//           sof = regModel.sof;
//           fp = regModel.fp;
//           String? msg = regModel.msg;

//           if (sof == "1") {
//             if (appType == 'TQ') {
//               SharedPreferences prefs = await SharedPreferences.getInstance();
//               /////////////// insert into local db /////////////////////
//               String? fp1 = regModel.fp;

//               // ignore: avoid_print
//               print("fingerprint......$fp1");
//               prefs.setString("fp", fp!);

//               cid = regModel.cid;
//               prefs.setString("cid", cid!);

//               cname = regModel.c_d![0].cnme;

//               prefs.setString("cname", cname!);

//               print("cid----cname-----$cid---$cname");
//               notifyListeners();

//               await externalDir.fileWrite(fp1!);

//               // ignore: duplicate_ignore
//               for (var item in regModel.c_d!) {
//                 print("ciddddddddd......$item");
//                 c_d.add(item);
//               }
//               // verifyRegistration(context, "");

//               isLoading = false;
//               notifyListeners();
//               prefs.setString("user_type", appType!);
//               prefs.setString("db_name", map["mssql_arr"][0]["db_name"]);
//               prefs.setString("old_db_name", map["mssql_arr"][0]["db_name"]);

//               prefs.setString("ip", map["mssql_arr"][0]["ip"]);
//               prefs.setString("port", map["mssql_arr"][0]["port"]);
//               prefs.setString("usern", map["mssql_arr"][0]["username"]);
//               prefs.setString("pass_w", map["mssql_arr"][0]["password"]);
//               String? user = prefs.getString("userType");
//               await TrafiqProDB.instance
//                   .deleteFromTableCommonQuery("companyRegistrationTable", "");
//               // ignore: use_build_context_synchronously
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => LoginPage()),
//               );
//             } else {
//               CustomSnackbar snackbar = CustomSnackbar();
//               // ignore: use_build_context_synchronously
//               snackbar.showSnackbar(context, "Invalid Apk Key", "");
//             }
//           }
//           /////////////////////////////////////////////////////
//           if (sof == "0") {
//             CustomSnackbar snackbar = CustomSnackbar();
//             // ignore: use_build_context_synchronously
//             snackbar.showSnackbar(context, msg.toString(), "");
//           }

//           notifyListeners();
//         } catch (e) {
//           // ignore: avoid_print
//           print(e);
//           return null;
//         }
//       }
//     });
//     return null;
//   }

//   //////////////////////////////////////////////////////////
//   getLogin(String user_name, String password, BuildContext context) async {
//     try {
//       isLoginLoading = true;
//       notifyListeners();
//       SharedPreferences prefs = await SharedPreferences.getInstance();

//       if (user_name.toLowerCase() != "vega" ||
//           password.toLowerCase() != "vega") {
//         CustomSnackbar snackbar = CustomSnackbar();
//         snackbar.showSnackbar(context, "Incorrect Username or Password", "");
//         isLoginLoading = false;
//         notifyListeners();
//       } else {
//         prefs.setString("st_uname", user_name);
//         prefs.setString("st_pwd", password);
//         initDb(context, "from login");
//       }
//       isLoginLoading = false;
//       notifyListeners();
//     } catch (e) {
//       // ignore: avoid_print
//       print(e);
//       return null;
//     }
//   }

// //////////////////////////////////////////////////////////
//   getUserData() async {
//     isLoading = true;
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     cname = prefs.getString("cname");
//     userName = prefs.getString("name");
//     print("haiii ----$cname");
//     isLoading = false;
//     notifyListeners();
//   }

// ////////////////////////////////////////////////////////
//   initDb(BuildContext context, String type) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? db = prefs.getString("old_db_name");
//     String? ip = prefs.getString("ip");
//     String? port = prefs.getString("port");
//     String? un = prefs.getString("usern");
//     String? pw = prefs.getString("pass_w");
//     debugPrint("Connecting...");
//     try {
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Please wait",
//                   style: TextStyle(fontSize: 13),
//                 ),
//                 SpinKitCircle(
//                   color: Colors.green,
//                 )
//               ],
//             ),
//           );
//         },
//       );
//       await SqlConn.connect(
//           ip: ip!, port: port!, databaseName: db!, username: un!, password: pw!
//           // ip:"192.168.18.37",
//           // port: "1433", 
//           // databaseName: "epulze",
//           // username: "sa",
//           // password: "1"

//           );
//       debugPrint("Connected!");

//       getDatabasename(context, type);

//       // getDatabasename(context);
//     } catch (e) {
//       debugPrint(e.toString());
//     } finally {
//       Navigator.pop(context);
//     }
//   }

//   //////////////////////////////////////////////////////////////////////////
//   getDatabasename(BuildContext context, String type) async {
//     isdbLoading = true;
//     notifyListeners();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? db = prefs.getString("db_name");
//     String? cid = await prefs.getString("cid");
//     print("cid dbname---------$cid---$db");
//     var res = await SqlConn.readData("Flt_LoadYears '$db','$cid'");
//     var map = jsonDecode(res);
//     db_list.clear();
//     if (map != null) {
//       for (var item in map) {
//         db_list.add(item);
//       }
//     }
//     print("years res-$res");
//     isdbLoading = false;
//     notifyListeners();
//     if (db_list.length > 0) {
//       if (type == "from login") {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => DbSelection()),
//         );
//       }
//     } else {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => HomePage()),
//       );
//     }

//     // notifyListeners();
//   }
// }
