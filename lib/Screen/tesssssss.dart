// import 'package:flutter/material.dart';

// class MyTextFieldScreen extends StatefulWidget {
//   @override
//   _MyTextFieldScreenState createState() => _MyTextFieldScreenState();
// }

// class _MyTextFieldScreenState extends State<MyTextFieldScreen> {
//   String inputValue = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('TextField Example'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: TextField(
//           onChanged: (value) {
//             setState(() {
//               inputValue = value;
//             });
//           },
//           decoration: const InputDecoration(
//             labelText: 'Enter text',
//           ),
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Text('Input Value: $inputValue'),
//       ),
//     );
//   }
// }
