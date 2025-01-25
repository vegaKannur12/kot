import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast {
  Future<bool?> toast(String message) {
    Fluttertoast.cancel();
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        // timeInSecForIos: 4,
        backgroundColor: const Color.fromARGB(255, 175, 99, 76),
        textColor: Colors.white,
        fontSize: 15.0);
  }
}
