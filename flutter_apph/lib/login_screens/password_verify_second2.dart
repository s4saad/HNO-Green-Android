import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fluttersipay/base_main_repo.dart';
import 'package:fluttersipay/corporate/global_data.dart';
import 'package:fluttersipay/dashboard/merchant_panel.dart';
import 'package:fluttersipay/main_api_data_model.dart';
import 'package:fluttersipay/utils/api_endpoints.dart';
import 'package:local_auth/local_auth.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:fluttersipay/dashboard/drawerMenu.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersipay/loading_widget.dart';
import 'package:fluttersipay/login_screens/login_repo.dart';
import 'package:fluttersipay/login_screens/reset_password.dart';
import 'package:flushbar/flushbar.dart';
import 'package:fluttersipay/utils/constants.dart';
import 'package:fluttersipay/utils/custom_text_style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'SMS_Verification.dart';
import 'json_models/password_verification_ui_model.dart';
import 'providers/verify_password_provider.dart';
import 'package:translator/translator.dart';
import 'package:fluttersipay/corporate/datas.dart';
import 'package:fluttersipay/corporate/global_data.dart' as gd;
import 'login_main.dart';
class VerifyPasswordSecondScreen2 extends StatefulWidget {
  final String userPhoneNumber;
  final String pass,lang;
bool exit =false;
String token;
  VerifyPasswordSecondScreen2(this.userPhoneNumber, this.pass,this.lang
  ,{this.exit,this.token}
      );

  @override
  VerifyPasswordScreenState createState() => VerifyPasswordScreenState();
}

class VerifyPasswordScreenState extends State<VerifyPasswordSecondScreen2> {


  Future<bool> popCallback() async {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      SystemNavigator.pop();
    }
  }

  getName(value)async {
    print("###########################################################################################:");
      Dio dio = new Dio();
      await dio.post(
          APIEndPoints.kApiIndividualGetMerchantReceiverInfoEndPoint,
          options: Options(
              headers: {
                "Accept": "application/json",
                //   "gsm_number":"+905343343819",
                "Authorization": userToken
              }
          ), queryParameters: {
        "phone": value,
      }

      ).then((res) {
        print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& "+res.data.toString());

       // MainApiModel k = MainApiModel.mapJsonToModel2(res);
        userName = res.data["data"]['receiver_info']['name'];

      });




  }
  SharedPreferences pref;
  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics;
  List<BiometricType> _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  String pas;
  VerifyPasswordProvider mysnapShot;

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
      print(e);
    }
    if (!mounted) return;

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });

    if(authenticated){
      print(authenticated);
      loginwithFingerPrint();

    }
  }

  loginwithFingerPrint()async{
    {

      getName(widget.userPhoneNumber);

      print(
          ".........pin....SUCCESS.."+widget.userPhoneNumber+pas);
      SharedPreferences prefs =
      await SharedPreferences.getInstance();
//      mysnapShot.passwordController.text=pas;
      String token = prefs.getString('token');
      setState(() {

      });
      mysnapShot.verifyPasswordNextFingerPrint(widget.userPhoneNumber,pas
          ,widget.lang,token,(MainApiModel loginData) {
//prefs.setString("pass"F, snapshot.passwordController.text);
          print("login");
            print(
                "SUCCESS...."+loginData.data.toString()+".....indi pass saved........" +
                    prefs
                        .getString("pass")
                        .toString());
            prefs.setString("password", pas);
            datas.loginModel = loginData;
            datas.tokens = loginData.data['token'];
            prefs.setString('token',loginData.data['token']);
            gd.userToken="Bearer "+loginData.data['token'];
            gd.isVerified = loginData.data['user']['user_category'] > 1;

            print("trueeeee");
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => MerchantPanelScreen(
                        loginData, loginData.data['token'])
                ),
                    (route) => false);
          }, () {
            return Flushbar(
              title: translator.translate("fail"),
              //////////////////////////////////////////////////
              message:
              "Invalid or incorrect password !!",
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
              duration: Duration(seconds: 4),
            )..show(context);
          });

  }}

  void _cancelAuthentication() {
    auth.stopAuthentication();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 1),
            () =>checkFirstTimeLogin() );
  }
  checkFirstTimeLogin() async {
    pref = await SharedPreferences.getInstance();
    if (pref.getBool('FingerPrintIsOk') == true)
      _isAuthenticating
          ? _cancelAuthentication()
          : _authenticate();


    pas= pref.get("password");
   print(pas);

  }
  showFingerDialouge(){
    showDialog(
        context: context,
        builder: (BuildContext context) {
//          finger print pop up
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(0)), //this right here
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Confirm your fingerprint",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                    Container(
                      height: 80,
                      child: Image.asset("assets/splash/fingerprint.png"),
                    ),
                    Container(
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
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

  @override
  Widget build(BuildContext context) {
//    showFingerDialouge();
    print("User Data from mainlogin " + widget.userPhoneNumber);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1304, allowFontScaling: true)
          ..init(context);
    return WillPopScope(
      onWillPop: popCallback,
      child:  FutureBuilder(
          future: DefaultAssetBundle.of(context).loadString(
              'assets/json/register/2.3registerSMSverification1.json'),
          builder: (context, snapshot) {

            //PasswordSMSVerificationModel users;
            //  var parsedJson;
            if (snapshot.hasData) {

              //  parsedJson = json.decode(snapshot.data.toString());
              //    users = PasswordSMSVerificationModel.fromJson(parsedJson);
              return Scaffold(
                // drawer: DrawerMenu().getDrawer,
                appBar: AppBar(
                  leading: Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          popCallback();
                        },
                      );
                    },
                  ),
                  centerTitle: true,
                  title: Text(
                    translator.translate("pass"),
                  ),
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
                      },
                    )
                  ],
                ),

                body: ChangeNotifierProvider(
                    create: (context) => VerifyPasswordProvider(
                        LoginRepository(),
                        TextEditingController(text: ""),
                        widget.userPhoneNumber),
                    child: SingleChildScrollView(
                      child: Consumer<VerifyPasswordProvider>(
                          builder: (context, snapshot, _) {
                             mysnapShot=snapshot;
                        return Container(
                            child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                SizedBox(
                                  height: ScreenUtil.getInstance().setWidth(60),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 30.0, right: 30.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      translator.translate("pass"),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil.getInstance().setWidth(30),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 30.0, right: 30.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      translator.translate("passInfo"),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil.getInstance().setHeight(30),
                                ),
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: ScreenUtil.getInstance()
                                            .setHeight(80),
                                      ),
                                      Image.asset(
                                        'assets/password.png',
                                        height: ScreenUtil.getInstance()
                                            .setHeight(300),
                                      ),
                                      SizedBox(
                                        height: ScreenUtil.getInstance()
                                            .setHeight(80),
                                      ),
                                    ],
                                  ),
//                          height: ScreenUtil.getInstance().setHeight(380),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 30.0, right: 30.0),
                                  child: TextField(
                                    style: TextStyle(color: Colors.black),
                                    controller: snapshot.passwordController,
                                    decoration: InputDecoration(
                                      hintStyle:
                                          CustomTextStyle.formField(context),
                                      errorMaxLines: 50,
                                      errorText: snapshot.passwordErrorText,
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black12, width: 1.0)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black12, width: 1.0)),
                                      prefixIcon: const Icon(
                                        Icons.lock,
                                        color: Colors.black38,
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    obscureText: true,
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil.getInstance().setHeight(30),
                                ),
                                Row(
//                          padding: EdgeInsets.only(right: 40),
                                  children: <Widget>[
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: FlatButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ResetPasswordScreen(
                                                            false)));
                                          },
                                          child: Text(
                                            translator.translate("forgetPass"),
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 15,
                                                height: 1.6),
                                          ),
                                        ),
                                      ),
                                    ),
                                   Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                              builder: (context) =>
                                                  MyLoginPage(
                                                      false,
                                                      "",
                                                      "",
                                                      "",
                                                      false,
                                                      "",
                                                      "",
                                                      ""),
                                            ));
                                          },
                                          child: Text(
                                            translator.translate("diffrenAcc"),
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 15,
                                                height: 1.6),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: ScreenUtil.getInstance().setHeight(100),
                                ),
                                Container(
                                  child: FlatButton(
                                    onPressed: () async {
                                      getName(widget.userPhoneNumber);

                                      print(
                                          ".........pin....SUCCESS..");
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      print("number>>"+widget.userPhoneNumber+"pass>>"+snapshot.passwordController.text);
                                      String token = prefs.getString('token');
                                      snapshot.verifyPasswordNext(widget.userPhoneNumber,snapshot.passwordController.text
                                          ,widget.lang,token,(MainApiModel loginData) {
//prefs.setString("pass"F, snapshot.passwordController.text);
                                        print(
                                            "SUCCESS...."+loginData.data.toString()+".....indi pass saved........" +
                                                prefs
                                                    .getString("pass")
                                                    .toString());
                                        prefs.setString("password", snapshot.passwordController.text);
                                        datas.loginModel = loginData;
                                        datas.tokens = loginData.data['token'];
                                        prefs.setString('token',loginData.data['token']);
                                        gd.userToken="Bearer "+loginData.data['token'];
                                        gd.isVerified = loginData.data['user']['user_category'] > 1;

                                        Navigator.of(context).pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) => MerchantPanelScreen(
                                                    loginData, loginData.data['token'])
                                                    ),
                                                (route) => false);
                                      }, () {
                                        return Flushbar(
                                          title: translator.translate("fail"),
                                          //////////////////////////////////////////////////
                                          message:
                                              "Invalid or incorrect password !!",
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                          duration: Duration(seconds: 4),
                                        )..show(context);
                                      });
                                    },
                                    color: Colors.blue,
                                    disabledColor: Colors.blue,
                                    padding: EdgeInsets.all(15.0),
                                    child: Text(
                                      translator.translate("verify"),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  width: ScreenUtil.getInstance().setWidth(660),
                                )
                              ],
                            ),
                            LoadingWidget(
                              isVisible: snapshot.showLoad,
                            )
                          ],
                        ));
                      }),
                    )),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
