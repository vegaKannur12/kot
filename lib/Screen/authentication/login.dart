import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_kot/Screen/home.dart';
import 'package:restaurent_kot/components/custom_snackbar.dart';
import 'package:restaurent_kot/components/popup_unreg.dart';
import 'package:restaurent_kot/components/textfldCommon.dart';
import 'package:restaurent_kot/controller/controller.dart';
import 'package:restaurent_kot/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Unreg popup = Unreg();
  // List<LoginModel> res = [];

  // LoginModel? selectedLoginModel;
  @override
  void initState() {
    // TODO: implement initState
    //  res = parseLoginModel(Provider.of<Controller>(context, listen: false).logList);
    pageload = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pageload = false;
     Size size = MediaQuery.of(context).size;
    double topInsets = MediaQuery.of(context).viewInsets.top;
    Orientation ori = MediaQuery.of(context).orientation;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.yellow,
      //   elevation: 0,
      // ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: [
          PopupMenuButton(itemBuilder: (context) {
            return [
              PopupMenuItem<int>(
                value: 0,
                child: Text("Unregister"),
              ),
              // PopupMenuItem<int>(
              //   value: 1,
              //   child: Text("Exit"),
              // ),
            ];
          }, onSelected: (value) {
            if (value == 0) {
              popup.showAlertDialog(context);
            }
            //  else if (value == 1) {
            //   extPop.showAlertDialog(context);
            // }
          })
        ],
      ),
      body: pageload
          ? SpinKitCircle(
              color: Colors.black,
            )
          : Consumer<Controller>(
              builder: (BuildContext context, Controller value, Widget? child) {
                return SafeArea(
                  child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 18.0,
              right: 18,
            ),
            child: Form(
                key: _formKey,
                child: ori == Orientation.portrait
                    ? Column(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: size.height * 0.14,
                          ),
                          login_img(),
                          SizedBox(
                            height: size.height * 0.054,
                          ),
                          login_form(size, topInsets)
                        ],
                      )
                    : Column(
                      children: [
                         Container(
                            height: size.height * 0.14,
                          ),
                        Row(
                            children: [
                              
                              Expanded(child: login_img()),
                              Expanded(
                                flex: 1,
                                child: login_form(size, topInsets))
                            ],
                          ),
                      ],
                    )),
          ),
        ),
                );
              },
            ),
    );
  }

  login_form(Size size, double topInsets) {
   return  Consumer<Controller>(
      builder: (BuildContext context, Controller value, Widget? child) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width * 0.02,
                ),
                Text(
                  "Login To Your Account",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(shape: BoxShape.rectangle),
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text("Select Staff"),
                value: value.selectedSmName,
                underline: Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.0, style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    value.selectedSmName = newValue;
                    print(("object"));
                    print(("selected NAme==${value.selectedSmName}"));

                    //                          Text("Sm_id: ${selectedItem!['Sm_id']}"),
                    // Text("Us_Name: ${selectedItem!['Us_Name']}"),
                    // Text("PWD: ${selectedItem!['PWD']}"),
                    value.selectedItemStaff = value.logList.firstWhere(
                        (element) => element['Sm_Name'] == newValue);
                    print("${value.selectedItemStaff!['Sm_id']}");
                    Provider.of<Controller>(context, listen: false)
                        .updateSm_id();
                  });
                },
                items: value.logList
                    .map<DropdownMenuItem<String>>((Map<String, dynamic> item) {
                  return DropdownMenuItem<String>(
                    value: item['Sm_Name'],
                    child: Text(item['Sm_Name']),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Widget_TextField(
              controller: password,
              obscureNotifier: ValueNotifier<bool>(
                  true), // For password field, you can set any initial value
              hintText: 'Password',
              keytype: TextInputType.number,
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
                  onPressed: () async {
                    int i =
                        await Provider.of<Controller>(context, listen: false)
                            .verifyStaff(password.text, context);
                    print("$i");
                    if (i == 1) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    } else {
                      CustomSnackbar snackbar = CustomSnackbar();
                      // ignore: use_build_context_synchronously
                      snackbar.showSnackbar(context, "Incorrect Password", "");
                    }
                    //  Provider.of<Controller>(context, listen: false)
                    //     .getLogin(
                    //         'DHANUSH', '3804', context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 12),
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Theme.of(context).secondaryHeaderColor),
                    ),
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }

  Container login_img() {
    return Container(
        child: Image.asset(
      "assets/lock.png",
      fit: BoxFit.contain,
    ));
  }
}
