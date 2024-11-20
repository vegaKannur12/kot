import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_kot/Screen/authentication/login.dart';
import 'package:restaurent_kot/Screen/authentication/registration.dart';
import 'package:restaurent_kot/Screen/db_selection.dart';
import 'package:restaurent_kot/Screen/home.dart';
import 'package:restaurent_kot/controller/controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false;
  bool isRegistered = false;

  checkLogin() async {
    bool isAuthenticated = false;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final stUname = prefs.getString("st_uname");
    final stPwd = prefs.getString("st_pwd");

    if (stUname != null && stPwd != null) {
      isAuthenticated = true;
    } else {
      isAuthenticated = false;
    }
    return isAuthenticated;
  }

  checkRegistration() async {
    bool isAuthenticated = false;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString("st_uname", "anu");
    // prefs.setString("st_pwd", "anu");
    final cid = prefs.getString("cid");
    if (cid != null) {
      isAuthenticated = true;
    } else {
      isAuthenticated = false;
    }
    return isAuthenticated;
  }

  navigate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? m_db = prefs.getString("multi_db");
    await Future.delayed(Duration(seconds: 3), () async {
      isLoggedIn = await checkLogin();
      isRegistered = await checkRegistration();
      Navigator.push(
          context,
          PageRouteBuilder(
              opaque: false, // set to false
              pageBuilder: (_, __, ___) {
                if (isRegistered) {
                  if (m_db != "1") {
                    Provider.of<Controller>(context, listen: false)
                        .initDb(context, "");
                    return const LoginPage();
                  } 
                  else 
                  {
                    return const DBSelection();
                  }
                } else {
                  return Registration();
                }
              }));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: Container( decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                // Color.fromARGB(255, 253, 192, 123),
                //                   Color.fromARGB(255, 50, 71, 190),
                Color.fromARGB(255, 48, 54, 90),
                Colors.indigo,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        child: InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Center(
              child: Column(
            children: [
              Expanded(
                child: Animate(
                  child: Container(
                    height: 150,
                    width: 150,
                    child: Image.asset(
                      "assets/logo_black_bg.png",
                    ),
                  ),
                ).fadeIn(duration: Duration(seconds: 2)),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
