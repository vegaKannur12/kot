// ignore: file_names
import 'package:flutter/material.dart';

Future<void> showCommonErrorDialog(String message,Widget gotoPage, BuildContext context) async {
  showDialog(barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Error'),
        content: Text(message,style: const TextStyle(fontSize: 16),),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              // Within the `FirstRoute` widget
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => gotoPage),
              );
            },
            child: const Text('Try Again'),
          ),
        ],
      );
    },
  );
}
