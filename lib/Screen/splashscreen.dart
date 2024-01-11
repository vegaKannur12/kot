import 'package:flutter/material.dart';
import 'package:restaurent_kot/Screen/authentication/login.dart';
import 'package:restaurent_kot/Screen/authentication/registration.dart';
import 'package:restaurent_kot/Screen/db_selection.dart';
import 'package:restaurent_kot/Screen/home.dart';
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
    await Future.delayed(Duration(seconds: 3), () async {
      isLoggedIn = await checkLogin();
      isRegistered = await checkRegistration();
      Navigator.push(
          context,
          PageRouteBuilder(
              opaque: false, // set to false
              pageBuilder: (_, __, ___) {
                if (isRegistered) {
                  if (isLoggedIn) {
                  
                    return DBSelection();
                  } else 
                  {
                    return LoginPage();
                  }
                }
                else 
                {
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
      body: InkWell(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Center(
            child: Column(
          children: [
            Expanded(
              child: Container(
                  height: 150,
                  width: 150,
                  child: Image.asset(
                    "assets/logo_black_bg.png",
                  ),
                  ),
            ),
          ],
        )),
      ),
    );
  }
}
