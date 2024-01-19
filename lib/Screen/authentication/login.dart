import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_kot/components/textfldCommon.dart';
import 'package:restaurent_kot/controller/controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ValueNotifier<bool> _isObscure = ValueNotifier(true);
  final _formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool pageload = false;
  @override
  void initState() {
    // TODO: implement initState
    pageload = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pageload = false;
    Size size = MediaQuery.of(context).size;
    double topInsets = MediaQuery.of(context).viewInsets.top;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.yellow,
      //   elevation: 0,
      // ),
      body: pageload
          ? SpinKitCircle(
              color: Colors.black,
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 18.0,
                    right: 18,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: size.height * 0.14,
                        ),
                        Container(
                            child: Image.asset(
                          "assets/lock.png",
                          fit: BoxFit.contain,
                          width: 300,
                          height: 300,
                        )),
                        SizedBox(
                          height: size.height * 0.054,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Text(
                                  "Login To Your Account",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Widget_TextField(
                              controller: username,
                              obscureNotifier: ValueNotifier<bool>(
                                  false), // For non-password field, you can set any initial value
                              hintText: 'Username',
                              prefixIcon: Icons.person,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Please Enter Username';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Widget_TextField(
                              controller: password,
                              obscureNotifier: ValueNotifier<bool>(
                                  true), // For password field, you can set any initial value
                              hintText: 'Password',
                              prefixIcon: Icons.lock,
                              isPassword: true,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Please Enter Password';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .getLogin(username.text, password.text,
                                            context);
                                    //  Provider.of<Controller>(context, listen: false)
                                    //     .getLogin(
                                    //         'DHANUSH', '3804', context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12.0, bottom: 12),
                                    child: Text(
                                      "LOGIN",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          color: Theme.of(context)
                                              .secondaryHeaderColor),
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
