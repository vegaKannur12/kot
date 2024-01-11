import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_kot/controller/controller.dart';
import 'package:restaurent_kot/components/external_dir.dart';
import 'package:device_info_plus/device_info_plus.dart';
class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  ExternalDir externalDir = ExternalDir();

  TextEditingController company = TextEditingController();
  TextEditingController phone = TextEditingController();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  late String uniqId;
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  String? manufacturer;
  String? model;
  String? fp;
  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        manufacturer = deviceData["manufacturer"];
        model = deviceData["model"];
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'manufacturer': build.manufacturer,
      'model': build.model,
    };
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    deletemenu();
    initPlatformState();
  }

  deletemenu() async {
    print("delete");
    // await OrderAppDB.instance.deleteFromTableCommonQuery('menuTable', "");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double topInsets = MediaQuery.of(context).viewInsets.top;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 18.0,
            right: 18,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: size.height * 0.16,
                ),
                Container(
                    height: size.height * 0.34,
                    width: size.width * 0.8,
                    child: Image.asset(
                      "assets/login.png",
                      fit: BoxFit.contain,
                    )),
                // Container(height: size.height*0.16,),
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
                          "Company Registration",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    TextFormField(
                      controller: company,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please Enter Company key';
                        }
                        return null;
                      },
                      scrollPadding: EdgeInsets.only(
                          bottom: topInsets + size.height * 0.18),
                      decoration: InputDecoration(
                          // border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 10.0, top: 15.0, bottom: 15.0),
                          // fillColor: Color.fromARGB(255, 235, 232, 232),
                          // filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 119, 119, 119),
                                width: 1),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.red, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 119, 119, 119),
                                width: 1),
                          ),
                          prefixIcon: const Icon(Icons.business, size: 16),
                          hintText: 'Company Key',
                          hintStyle: const TextStyle(fontSize: 14)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: phone,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please Enter Phone Number';
                        } else if (text.length != 10) {
                          return 'Please Enter Valid Phone No ';
                        }
                        return null;
                      },
                      scrollPadding: EdgeInsets.only(
                          bottom: topInsets + size.height * 0.18),
                      // obscureText: _isObscure.value,
                      decoration: const InputDecoration(
                          // border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 10.0, top: 15.0, bottom: 15.0),

                          // filled: true,
                          // fillColor: Color.fromARGB(255, 235, 232, 232),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 119, 119, 119),
                                width: 1),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.red, width: 1),
                          ),
                          // errorBorder: OutlineInputBorder(
                          //   borderRadius:
                          //       BorderRadius.all(Radius.circular(20.0)),
                          //   borderSide:
                          //       BorderSide(color: Colors.red, width: 1),
                          // ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 119, 119, 119),
                                width: 1),
                          ),
                          prefixIcon: Icon(Icons.phone, size: 16),
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(fontSize: 14)),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      ElevatedButton(
                        onPressed: ()async {
                          String deviceInfo =
                                      "$manufacturer" + '' + "$model";
                                  if (_formKey.currentState!.validate()) {
                                    String tempFp1 =
                                        await externalDir.fileRead();

                                    print("tempFp---${tempFp1}");

                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .postRegistration(company.text, tempFp1,
                                            phone.text, deviceInfo, context);
                                  }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12.0, bottom: 12),
                          child: Text(
                            "REGISTER",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Theme.of(context).secondaryHeaderColor),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      )
                    ])
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
