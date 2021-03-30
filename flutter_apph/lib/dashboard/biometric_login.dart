import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../DemoFaceFinger.dart';
import 'Live_support.dart';

class biometric_Login extends StatefulWidget {
  @override
  _biometric_LoginState createState() => _biometric_LoginState();
}

class _biometric_LoginState extends State<biometric_Login> {

  bool switchV = true;
  SharedPreferences pref;
  final LocalAuthentication auth = LocalAuthentication();
  bool canCheckBiometrics = false;
  bool exp = false;
  bool _isAuthenticating = false;
  String availableBiometric;
  String _authorized = 'Not Authorized';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkBioMectricStatus();
  }
  checkBioMectricStatus() async {
    pref = await SharedPreferences.getInstance();

    if (pref.getBool('isLoggedInFirst') == false ||
        pref.getBool('isLoggedInFirst') == null) {

      ///change togel button to off/on

      setState(() {
        switchV=false;
      });
      print("Biometric Status"+switchV.toString());


    }else{
      setState(() {
        switchV=true;
      });
      print("Biometric Status"+switchV.toString());
    }
  }
  enableBioMetric()async{
          if (Platform.isAndroid) {
        var androidInfo = await DeviceInfoPlugin().androidInfo;
        var release = androidInfo.version.release;
        var sdkInt = androidInfo.version.sdkInt;
        var manufacturer = androidInfo.manufacturer;
        var model = androidInfo.model;
        if(sdkInt<29){
          showDialougeBox1();
        }else{
          try {
            canCheckBiometrics = await auth.canCheckBiometrics;
            if(canCheckBiometrics){
              showDialougeBox1();
            }
          } catch (e) {
            print("error biome trics $e");
//      }

          }
        }
        print('Android $release (SDK $sdkInt), $manufacturer $model');
        // Android 9 (SDK 28), Xiaomi Redmi Note 7
      }
      else{
        try {
          canCheckBiometrics = await auth.canCheckBiometrics;
          if(canCheckBiometrics){
            showDialougeBox1();
          }
        } catch (e) {
          print("error biome trics $e");
//      }

        }
      }
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          useErrorDialogs: true,
          stickyAuth: true);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print("skdjfk"+e.toString());
    }
    if (!mounted) return;

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
    if(authenticated){
      showDialougeBoxOk();
      pref.setBool("FingerPrintIsOk", true);
      pref.setBool("isLoggedInFirst", true);

    }

  }

  void _cancelAuthentication() {
    auth.stopAuthentication();
  }
  showDialougeBoxOk() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
//                                                                              unable finger print pop up
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0)), //this right here
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Biometric Confirmation Enabled",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                    Text(
                      "Enabling Biometric will allow \nyou to login without password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.3), fontSize: 17),
                    ),
                    Container(
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "OK",
                          style: TextStyle(color: Colors.black),
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
  showDialougeBox1() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
//                                                  enable or not pop up
          return StatefulBuilder(
            builder: (context, setState){
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)), //this right here
                child: Container(
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Would you like to enable \nBiometric verification?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                          ),
                        ),
                        CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (bool) {
                            setState(() {
                              !exp? exp = true:exp = false;
                            });
                            pref.setBool("dontshowpopup", exp);
                          },
                          value: exp,
                          title: Text(
                            "Do not show this message again",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.3), fontSize: 15),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
//                                                              width: 320.0,
                                child: RaisedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    pref.setBool("FingerPrintIsOk", false);
                                    pref.setBool("isLoggedInFirst", false);
                                  },
                                  child: Text(
                                    "NO",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                child: RaisedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _isAuthenticating
                                        ? _cancelAuthentication()
                                        : _authenticate();
                                  },
                                  child: Text(
                                    "ENABLE",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },

          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        centerTitle: true,
        title:
        Text(translator.translate("biometricLogin").toUpperCase()),
        flexibleSpace: Image(
          image: AssetImage('assets/appbar_bg.png'),
          height: 100,
          fit: BoxFit.fitWidth,
        ),
        actions: <Widget>[
          IconButton(
            padding: const EdgeInsets.only(right: 20.0),
            icon: Icon(
              FontAwesomeIcons.commentAlt,
              color: Colors.white,
            ),
            onPressed: () {
              // do something

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Live_Support(),
                  ));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                translator
                    .translate("UseBiometricLoginInsteadOfPassword"),
                style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 17
                ),
              ),
              SizedBox(
                height:
                ScreenUtil.getInstance().setHeight(50),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                          hintText: "Biometric login",
                          icon: Icon(Icons.lock)
                      ),
                    ),
                  ),
                  Switch(
                    value: switchV,
                    onChanged: (val){
                      if(val){
                        enableBioMetric();
                      }
                      if(!val){
                        pref.setBool("FingerPrintIsOk", false);
                        pref.setBool("isLoggedInFirst", false);
                      }
                      setState(() {
                        switchV = val;
                      });
                    }
                  )
                ],
              ),
              SizedBox(
                height:
                ScreenUtil.getInstance().setHeight(20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
