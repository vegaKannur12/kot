import 'package:flutter/material.dart';
import 'package:restaurent_kot/Screen/authentication/registration.dart';
import 'package:restaurent_kot/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Unreg {
  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Yes"),
      onPressed: () async {
        await KOT.instance
            .deleteFromTableCommonQuery("companyRegistrationTable", "");
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('cid');
        await prefs.remove('st_uname');
        await prefs.remove('st_pwd');
        await prefs.remove('multi_db');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Registration()));
      },
    );
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop(false);
        // Navigator.pushReplacement(context,
        //     MaterialPageRoute(builder: (context) => HomeFloorBill()));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Do you want to unregister!!",
        style: TextStyle(fontSize: 20),
      ),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
