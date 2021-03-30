import 'package:country_pickers/country_pickers.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttersipay/LocalAuthservices/local_authentication_service.dart';
import 'package:fluttersipay/LocalAuthservices/service_locator.dart';
import 'package:fluttersipay/login_screens/ErrorDialog.dart';
import 'package:fluttersipay/login_screens/SMS_Verification.dart';
import 'package:fluttersipay/login_screens/login_repo.dart';
import 'package:fluttersipay/login_screens/login_widgets.dart';
import 'package:fluttersipay/login_screens/password_verify.dart';
import 'package:fluttersipay/login_screens/providers/login_provider.dart';
import 'package:fluttersipay/login_screens/renew_password.dart';
import 'package:fluttersipay/login_screens/reset_password.dart';
import 'package:fluttersipay/login_screens/reset_password_webview.dart';
import 'package:fluttersipay/utils/api_endpoints.dart';
import 'package:fluttersipay/utils/constants.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:ola_like_country_picker/ola_like_country_picker.dart' as ola;
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import 'Dart:io';
import 'package:fluttersipay/corporate/global_data.dart';
import 'package:country_provider/country_provider.dart' as pc;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';
import 'login_registration.dart';
import 'login_slide.dart';
import 'package:flutter/services.dart';
import '../login_screens/providers/verify_password_provider.dart';

class MyLoginPage extends StatefulWidget {
  MyLoginPage(
      [this.remem,
      this.email,
      this.pass,
      this.phone,
      this.type,
      this.passCor,
      this.countryCode,
      this.countryFlagUri]);

  var remem, email, pass, phone, type, passCor, countryCode, countryFlagUri;

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  ola.CountryPicker countryPicker;

  var local = ui.window.locale.countryCode;

  final LocalAuthenticationService _localAuth = locator<LocalAuthenticationService>();

  initSetup(LoginProvider snapshot) {
    if (local == null) local = 'tr';

    for (var element in ola.countryCodes) {
      if (local.toLowerCase() == element["ISO"]) {
        // setState(() {
        snapshot.country = ola.Country.fromJson(element);
        snapshot.countrycode = snapshot.country.dialCode;
        //   });
      }
    }

    for (var element in ola.countryCodes) {
      var dialCode = ola.Country.fromJson(element).dialCode;
      if (widget.countryCode == '+$dialCode') {
        snapshot.country = ola.Country.fromJson(element);
        snapshot.countrycode = snapshot.country.dialCode;
        //    setState(() {});
      }
    }

    countryPicker = ola.CountryPicker(onCountrySelected: (country) {
      print(country);
      setState(() {
        snapshot.country = country as ola.Country;
        snapshot.countrycode = country.dialCode;
      });
    });

    if (widget.remem == null) widget.remem = false;
  }

  void resetGame() {
    if (Navigator.canPop(context)) Navigator.pop(context);
  }

  bool isShowen = false;

  Future<bool> popCallback() async {
    // await get("dxfgchjbn");
    if (isShowen) {
      print(">>>>>>>>>>>>>>>>>>>>>>> Dismis");
      FocusScope.of(context).unfocus();
      countryPicker.dismiss();
      isShowen = false;
    } else {
      print(">>>>>>>>>>>>>>>>>>>>>>> POP");
      // Navigator.pop(context);
      exit(0);
    }
  }

  initPlatformStateForStringUniLinks() async {
    // Attach a listener to the links stream
    getLinksStream().listen((String link) {
      if (!mounted) return;
    }, onError: (err) {
      if (!mounted) return;
    });

    // Attach a second listener to the stream
    getLinksStream().listen((String link) {
      print('got link: $link');
      checkAndOpenResetPasswordWebView(link);
    }, onError: (err) {
      print('got err: $err');
    });

    // Get the latest link
    String initialLink;
    Uri initialUri;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      initialLink = await getInitialLink();
      print('initial link: $initialLink');
      checkAndOpenResetPasswordWebView(initialLink);
      if (initialLink != null) initialUri = Uri.parse(initialLink);
    } on PlatformException {
      initialLink = 'Failed to get initial link.';
      initialUri = null;
    } on FormatException {
      initialLink = 'Failed to parse the initial link as Uri.';
      initialUri = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  checkAndOpenResetPasswordWebView(String url) async {
    if (url != null) {
      if (url.contains(
          'https://${APIEndPoints.server}.sipay.com.tr/merchant/password/reset/')) {
        bool isValid = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ResetPasswordWebView(url)));
        if (isValid != null && isValid) {
          Flushbar(
              title: translator.translate("successful"),
              duration: Duration(seconds: 5))
            ..show(context);
        }
      }
    }
  }

  @override
  void initState() {
    initPlatformStateForStringUniLinks();
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3),(){
      _localAuth.authenticate;
    });


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
      child: ChangeNotifierProvider<LoginProvider>(create: (context) {
        LoginProvider loginProvider = LoginProvider(
            LoginRepository(),
            TextEditingController(text: widget.remem ? widget.email : ""),
            TextEditingController(
                //PASSWORD
/*       text:widget.remem==true?widget.passCor:"" */

                ),
            TextEditingController(
                text: widget.remem ? widget.phone.toString() : ""),
            widget.remem);
        initSetup(loginProvider);
        return loginProvider;
      }, child: Scaffold(body: SingleChildScrollView(
        child: Consumer<LoginProvider>(builder: (context, snapshot, _) {
          print("......................................." +
              snapshot.countrycode1);
          // snapshot.initRemem();
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: SingleChildScrollView(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/home_logo.png',
                              width: ScreenUtil.getInstance().setWidth(300),
                              height: ScreenUtil.getInstance().setHeight(190)),
                        ],
                      )),
                    ),
                    width: ScreenUtil.getInstance().setWidth(750),
                    height: ScreenUtil.getInstance().setHeight(190),
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(60),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 30.0, right: 30.0),
                      child: IntrinsicWidth(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                  decoration: new BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: snapshot.customerOrCorporate
                                            ? Colors.blue
                                            : Colors.black26,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                        width: ScreenUtil.getInstance()
                                            .setWidth(345),
                                        child: OutlineButton(
                                          onPressed: () {
                                            snapshot.toggleCustomerCorporate();
                                          },
                                          borderSide: new BorderSide(
                                            style: BorderStyle.none,
                                          ),
                                          child: new Text(
                                            translator.translate("individual"),
                                            //     'INDIVIDUAL',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color:
                                                    snapshot.customerOrCorporate
                                                        ? Colors.blue
                                                        : Colors.black26,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                  )),
                            ),
                            Expanded(
                              child: Container(
                                  decoration: new BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: snapshot.customerOrCorporate
                                            ? Colors.black26
                                            : Colors.blue,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                      width: ScreenUtil.getInstance()
                                          .setWidth(345),
                                      child: OutlineButton(
                                        onPressed: () {
                                          snapshot.toggleCustomerCorporate();
                                        },
                                        borderSide: new BorderSide(
                                          style: BorderStyle.none,
                                        ),
                                        child: new Text(
                                          translator.translate("corp"),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color:
                                                  snapshot.customerOrCorporate
                                                      ? Colors.black26
                                                      : Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                    width: ScreenUtil.getInstance().setWidth(750),
                    height: ScreenUtil.getInstance().setHeight(90),
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(0),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          snapshot.customerOrCorporate
                              ? Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 15, left: 0.0, right: 10.0),
                                    child: !snapshot
                                            .showIndividualLoginErrorMessage
                                        ? Container(
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                color: Colors.black38,
                                              ),
                                            ),
                                            height: 0,
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                translator
                                                    .translate("phoneValidate"),
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              UserRegistrationScreen()));
                                                },
                                                child: Text(
                                                  translator
                                                      .translate("register"),
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                translator.translate(
                                                    "phoneValidate2"),
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                )
                              : Container(),
                          Container(
                            child: snapshot.customerOrCorporate
                                ? Container(
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      //     crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
/////////////////////////////////////////////////////////////////////////////////

                                        GestureDetector(
                                          child: Container(
                                            margin: EdgeInsets.only(top: 10),
                                            width: 80,
                                            height: 30,
                                            child: Row(
                                              children: <Widget>[
                                                Image.asset(
                                                  snapshot.country.flagUri,
                                                  package:
                                                      'ola_like_country_picker',
                                                  width: 30,
                                                  height: 27,
                                                ),
                                                Expanded(
                                                    child: Text(
                                                  "  +" +
                                                      snapshot
                                                          .country.dialCode +
                                                      " ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ))
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            FocusScope.of(context).requestFocus(FocusNode());
                                            countryPicker.launch(context);
                                            setState(() {
                                              isShowen = true;
                                            });

                                            if (snapshot
                                                .telephoneController.text
                                                .contains("+")) {
                                              snapshot.telephoneController
                                                  .text = "";
                                            }
                                          },
                                        ),

                                        Expanded(
                                            child: IndividualWidget(snapshot,
                                                snapshot.countrycode1)),
                                      ],
                                    ))
                                : CorporateWidget(snapshot),
                          ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(20),
                          ),
                          Container(
                            child: Row(
                              //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Checkbox(
                                          value: snapshot.rememberPassword,
                                          onChanged: (bool value) {
                                            snapshot.setRememberPassword(value);
                                          }),
                                      Text(translator.translate("remember")),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ResetPasswordScreen(!snapshot
                                                      .customerOrCorporate)),
                                        );
                                      },
                                      child: Text(
                                        translator.translate("forgetPass"),
                                        style: TextStyle(
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(30),
                          ),
                          Container(
                            width: ScreenUtil.getInstance().setWidth(690),
                            child: FlatButton(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                translator.translate("login"),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              color: Colors.blue,
                              onPressed: () async {
                                /*Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => RenewPassword()));
                                return;*/
                                /*    if (snapshot.userType != UserTypes.Corporate) {
                                  if (!snapshot.telephoneController.text
                                      .contains("+")) {
                                    isIndividual = true;
                                  }
                                }*/

//print(snapshot.userType.toString()+"-3-------*");
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();

                                prefs.setBool(
                                    "remember", snapshot.rememberPassword);

                                snapshot.login(

//not verified()
                                    /*                    (loginData){
                                      //new Unverified
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => VerifyPasswordScreen(
                                              "+"+ snapshot.countrycode+ snapshot.telephoneController.text,

                                              //   ,pass: snapshot.rememberPassword?widget.pass:"",

                                              snapshot.customerOrCorporate
                                          ,newUnverified: true,
                                          )));


                                    },*/

                                    (loginData) {
                                  prefs.setString(
                                      "phone2",
                                      "+" +
                                          snapshot.countrycode1 +
                                          snapshot.telephoneController.text);
                                  print("!!!!!" + loginData.toString());
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          SMSVerificationScreen(
                                            loginData,
                                            NavigationToSMSTypes.Login,
                                            userType: snapshot.userType,
                                            verified: false,
                                            /*       ,
                                                    passCor:widget.passCor,pass: widget.pass,
                                                    */
                                          )));
                                }, (loginData) {
                                  print("########" + loginData.toString());
                                  print("individua entred ................");
                                  prefs.setString("phone2",
                                      "+" + snapshot.countrycode1 + loginData);
                                  if (snapshot.rememberPassword == true) {
                                    prefs.setString("phone",
                                        snapshot.telephoneController.text);
                                    // prefs.setString("Type", "indi");
                                    prefs.setString('country_code',
                                        '+${snapshot.countrycode}');
                                    prefs.setString('country_flagUri',
                                        snapshot.country.flagUri);
                                  }

                                  print(
                                      "SUCCUSS .........individual.................." +
                                          snapshot.countrycode1);
                                  isIndividual = true;
                                  prefs.setString("phone2",
                                      "+" + snapshot.countrycode1 + loginData);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => VerifyPasswordScreen(
                                          "+" + snapshot.countrycode1 + loginData
                                          //snapshot.telephoneController.text
                                          //   ,pass: snapshot.rememberPassword?widget.pass:"",
                                          ,
                                          snapshot.customerOrCorporate)));

                                  //NAvigate to otp then page to change password
                                }, (loginData) {
                                  print(
                                      "NOT VERIFIED ........merchant..................");
                                  isIndividual = false;

                                  if (snapshot.rememberPassword == true) {
                                    prefs.setString(
                                        "email", snapshot.emailController.text);

                                    //   prefs.setString("Type", "cor");
                                  }
                                  prefs.setString("password",
                                      snapshot.passwordController.text);

                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SMSVerificationScreen(
                                          loginData, NavigationToSMSTypes.Login,
                                          userType: snapshot.userType
                                          /*       ,
                                                    passCor:widget.passCor,pass: widget.pass,
                                                    */
                                          )));
                                }, (errorMsg) {
                                  print("ERROR ...........................");

                                  showDialog(
                                      context: context,
                                      child: ErrorDialog(() {
                                        Navigator.of(context).pop();
                                      }));
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(10),
                          ),
                          Container(
                            child: snapshot.customerOrCorporate
                                ? NoAccountWidget()
                                : null,
                          ),
                        ],
                      ),
                    ),
                    width: ScreenUtil.getInstance().setWidth(750),
                    height: ScreenUtil.getInstance().setHeight(610),
                  ),
//                 RaisedButton(
//                   child: Text(
//                     "Authenticate",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                     ),
//                   ),
//                   color: Colors.blue,
//                    onPressed: _localAuth.authenticate,
//                  ),
                  Container(
                    width: 250,
                    height: 100,
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () async {
                            await translator.setNewLanguage(context,
                                newLanguage: "tr",
                                restart: false,
                                remember: true);

                            await translator.init('tr');
                            setState(() {});
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(width: 10),
                              SizedBox(
                                child: Image.asset(
                                  'icons/flags/png/tr.png',
                                  package: 'country_icons',
                                  width: 30,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text("Türkçe",
                                  style: TextStyle(
                                      decoration:
                                          translator.currentLanguage == "tr"
                                              ? TextDecoration.underline
                                              : TextDecoration.none,
                                      fontWeight:
                                          translator.currentLanguage == "tr"
                                              ? FontWeight.bold
                                              : FontWeight.normal))
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        InkWell(
                          onTap: () async {
                            await translator.setNewLanguage(context,
                                newLanguage: "en",
                                restart: false,
                                remember: true);

                            await translator.init('en');

                            setState(() {});
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(width: 10),
                              SizedBox(
                                child: Image.asset(
                                  'icons/flags/png/gb.png',
                                  package: 'country_icons',
                                  width: 30,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text("English",
                                  style: TextStyle(
                                      decoration:
                                          translator.currentLanguage == "en"
                                              ? TextDecoration.underline
                                              : TextDecoration.none,
                                      fontWeight:
                                          translator.currentLanguage == "en"
                                              ? FontWeight.bold
                                              : FontWeight.normal))
                            ],
                          ),
                        ),
                      ],
                    ),
                  )

                  /*        Container(
                        padding: EdgeInsets.only(left: 40.0, right: 40.0),
                        child: Text(
                          '%10 OFF SHOPPING IN JUNE!',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        width: ScreenUtil.getInstance().setWidth(750),
                        height: ScreenUtil.getInstance().setHeight(80),
                      ), */
                  /*        Container(
                        child: LoginPage(),
                        width: ScreenUtil.getInstance().setWidth(750),
                        height: ScreenUtil.getInstance().setHeight(270),
                      ) */
                ],
              ),
              Visibility(
                visible: snapshot.showLoad,
                child: SpinKitChasingDots(
                  color: Colors.blue,
                ),
              )
            ],
          );
        }),
      ))),
    );
  }
}
