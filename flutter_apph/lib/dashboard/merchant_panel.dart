import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttersipay/dashboard/biometric_login.dart';
import 'package:fluttersipay/dashboard/change_email.dart';
import 'package:fluttersipay/dashboard/change_password.dart';
import 'package:path_provider/path_provider.dart';
import 'package:device_info/device_info.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttersipay/LocalAuthservices/local_authentication_service.dart';
import 'package:fluttersipay/LocalAuthservices/service_locator.dart';
import 'package:fluttersipay/Money/Requset_money.dart';
import 'package:fluttersipay/Money/Send_money.dart';
import 'package:fluttersipay/Witdrawal/witdrawal.dart';
import 'package:fluttersipay/base_main_repo.dart';
import 'package:fluttersipay/corporate/global_data.dart';
import 'package:fluttersipay/corporate/money/money_panel.dart';
import 'package:fluttersipay/corporate/withdrawal/create_withdrawal.dart';
import 'package:fluttersipay/dashboard/providers/individual_panel_dashboard_provider.dart';
import 'package:fluttersipay/dashboard/repos/individual_repo.dart';
import 'package:fluttersipay/dashboard/security.dart';
import 'package:fluttersipay/deposit/deposit_panel.dart';
import 'package:fluttersipay/login_screens/kyc_verification_force.dart';
import 'package:fluttersipay/login_screens/login_main.dart';
import 'package:fluttersipay/main_api_data_model.dart';
import 'package:fluttersipay/src/custom_clipper.dart';
import 'package:fluttersipay/utils/app_utils.dart';
import 'package:fluttersipay/utils/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttersipay/utils/api_endpoints.dart' as points;
import './activity_details.dart';
import 'Bank_account.dart';
import 'Help_panel.dart';
import 'Live_support.dart';
import 'Notification_settings.dart';
import 'Profilesetting_panel.dart';
import 'Transaction_history.dart';
import 'Transfer_settins.dart';
import 'drawerMenu.dart';
import 'package:fluttersipay/corporate/global_data.dart' as gd;

class MerchantPanelScreen extends StatefulWidget {
  final MainApiModel loginModel;
  final String token;

  MerchantPanelScreen(this.loginModel, this.token);

  @override
  _MerchantPanelScreenState createState() => _MerchantPanelScreenState();
}

class _MerchantPanelScreenState extends State<MerchantPanelScreen> {
  String To2double(String val) {
    var s = double.parse(val).toStringAsFixed(2);
    return s;
  }

  final LocalAuthenticationService _localAuth =
      locator<LocalAuthenticationService>();
  String _language_value;

  String capitalize(String s) {
    if (s != null && s != "" && s != "Null" && s != "null") {
      var listOfWords = s.split(" ");
      String inCaps =
          ""; //='${listOfWords[0][0].toUpperCase()}${listOfWords[0].substring(1)}';
      for (int i = 0; i < listOfWords.length; i++) {
        inCaps = inCaps +
            ' ${listOfWords[i][0].toUpperCase()}${listOfWords[i].substring(1)}';
      }

      return inCaps;
    } else {
      return "";
    }
  }

  bool exp = false;
  SharedPreferences pref;
  final LocalAuthentication auth = LocalAuthentication();
  bool canCheckBiometrics = false;
  List<BiometricType> _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  String availableBiometric;
  String imageData;
  bool dataLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._language_value = translator.currentLanguage;
    loginModel2 = widget.loginModel;

    checkFirstTimeLogin();
    _getAvailableBiometrics();
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
print(availableBiometrics);
    setState(() {
      _availableBiometrics = availableBiometrics;
    });



//    if (Platform.isIOS) {
//      if (availableBiometrics.contains(BiometricType.face)) {
//        bool didAuthenticate =
//        await auth.authenticateWithBiometrics(
//            localizedReason: 'Please authenticate to show account balance');
//
//
//        const iosStrings = const IOSAuthMessages(
//            cancelButton: 'cancel',
//            goToSettingsButton: 'settings',
//            goToSettingsDescription: 'Please set up your Touch ID.',
//            lockOut: 'Please reenable your Touch ID');
//        await auth.authenticateWithBiometrics(
//            localizedReason: 'Please authenticate to show account balance',
//            useErrorDialogs: false,
//            iOSAuthStrings: iosStrings);
//        // Face ID.
//      } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
//        // Touch ID.
//      }
//    }
  }

  checkFirstTimeLogin() async {
     pref = await SharedPreferences.getInstance();
//     if(pref.getBool("dontshowpopup")==false){

    if (pref.getBool('isLoggedInFirst') == false ||
        pref.getBool('isLoggedInFirst') == null) {
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

  showDialougeBox4() {
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
                      "Unable to verify",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                    Text(
                      "Please check your fingerprint in phone settings and try again the next time you log in",
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
                          "LOGIN WITH PASSWORD",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  showDialougeBox3() {
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
                      "Unable to Verify Fingerprint",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                    Text(
                      "Please check your fingerprint in phone settings and try again the next time you log in",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.3), fontSize: 17),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: RaisedButton(
                              onPressed: () {},
                              child: Text(
                                "CLOSE",
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
                                showDialougeBox4();
                              },
                              child: Text(
                                "TRY AGAIN",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  showDialougeBox2() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
//                                                                              finger print pop up
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
                          showDialougeBox3();
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

  showDialougeBox1() {
//    showDialog(
//      context: context,
//      builder: (context) {
//        String contentText = "Content of Dialog";
//        return StatefulBuilder(
//          builder: (context, setState) {
//            return AlertDialog(
//              title: Text("Title of Dialog"),
//              content: Text(contentText),
//              actions: <Widget>[
//                FlatButton(
//                  onPressed: () => Navigator.pop(context),
//                  child: Text("Cancel"),
//                ),
//                FlatButton(
//                  onPressed: () {
//                    setState(() {
//                      contentText = "Changed Content of Dialog";
//                    });
//                  },
//                  child: Text("Change"),
//                ),
//              ],
//            );
//          },
//        );
//      },
//    );
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1304, allowFontScaling: true)
          ..init(context);
    final _media = MediaQuery.of(context).size;

    Future<Map<String, String>> loadJson() async {
      final jsonA = await DefaultAssetBundle.of(context)
          .loadString('assets/json/dashboard/merchant_panel.json');
      final jsonB = await DefaultAssetBundle.of(context)
          .loadString('assets/json/dashboard/footer_tab.json');
      return {
        'merchant': jsonA,
        'footer': jsonB,
      };
    }

    return ChangeNotifierProvider(
        create: (context) => IndividualPanelProvider(
            IndividualMainRepository(widget.token), widget.loginModel),
        child:
            /* FutureBuilder(
            future: loadJson(),
            builder: (context, snapshot) {
              print("#>#" + widget.token);
              var parsedJson;
              var footerJson;
              if (snapshot.hasData) {
                parsedJson = json.decode(snapshot.data['merchant'].toString());
                footerJson = json.decode(snapshot.data['footer'].toString());
                return */

            Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  title: Image.asset(
                    'assets/logo-dashboard.png',
                    height: ScreenUtil.getInstance().setHeight(40),
                    fit: BoxFit.fitHeight,
                  ),
                  leading: Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        icon: const Icon(Icons.dehaze),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      );
                    },
                  ),
                  actions: <Widget>[
                    Consumer<IndividualPanelProvider>(
                        builder: (context, snapshot, _) {
                      return IconButton(
                        icon: Icon(
                          Icons.notifications_none,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NotificationSettingsScreen(
                                        snapshot.baseMainRepository),
                              ));
                        },
                      );
                    })
                  ],
                ),
                drawer: Consumer<IndividualPanelProvider>(
                    builder: (context, snapshot, _) {
                      if(snapshot.userProfileImage != null)
                        {
//                          _asyncMethod(snapshot.userProfileImage.toString());
                        }
                  return Drawer(
                    child: ListView(
                      // Important: Remove any padding from the ListView.
                      children: <Widget>[
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(120),
                          child: Container(
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: IconButton(
                                      icon: const Icon(Icons.arrow_back_ios),
                                      color: Colors.white,
                                      iconSize: 16,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                  height:
                                      ScreenUtil.getInstance().setHeight(120),
                                ),
                                Container(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      translator.translate("menu"),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  height:
                                      ScreenUtil.getInstance().setHeight(120),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                image: DecorationImage(
                                    image: AssetImage("assets/appbar_bg.png"),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(20),
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Container(
                                      child: snapshot.userProfileImage == null
                                          ? Image.asset(
                                        'assets/user_avatar_two.png',
                                        height: ScreenUtil.getInstance()
                                            .setHeight(200),
                                      )
                                          : CachedNetworkImage(
                                        imageBuilder: (context, imageProvider) => Container(
                                          width: 100.0,
                                          height: 100.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: imageProvider, fit: BoxFit.cover),
                                          ),
                                        ),
                                        imageUrl: snapshot.userProfileImage,
                                        fit: BoxFit.contain,
                                      ),


                                      height: ScreenUtil.getInstance()
                                          .setHeight(100),
                                      width: ScreenUtil.getInstance()
                                          .setHeight(100),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 20,
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            snapshot.userName ?? "",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          width: ScreenUtil.getInstance()
                                              .setWidth(300),
                                        ),
                                        SizedBox(
                                          height: ScreenUtil.getInstance()
                                              .setHeight(10),
                                        ),
                                        Container(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                translator.translate('customerNumber').toUpperCase(),
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey,
                                                    fontStyle: FontStyle.italic
                                                ),
                                              ),
                                            ),
                                          width: ScreenUtil.getInstance()
                                              .setWidth(300),
                                        ),
                                        Container(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              snapshot.customerNumber.toString(),
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          width: ScreenUtil.getInstance()
                                              .setWidth(300),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(30),
                              ),
                              ListTile(
                                title: Container(
                                    child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        FontAwesomeIcons.chartBar,
                                        color: Colors.blue,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(translator.translate("dash")),
                                    ],
                                  ),
                                )),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              Divider(
                                color: Colors.black12,
                                height: 1.0,
                              ),
                              ListTile(
                                title: Container(
                                    child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.format_list_bulleted,
                                        color: Colors.blue,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(translator.translate("tranaction")),
                                    ],
                                  ),
                                )),
                                onTap: () {
                                  //Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TransactionHistoryScreen(
                                                  snapshot
                                                      .individualMainRepository,
                                                  snapshot.userWallets,
                                                  UserTypes.Individual)));
                                },
                              ),
                              Divider(
                                color: Colors.black12,
                                height: 1.0,
                              ),
                              ListTile(
                                title: Container(
                                    child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        FontAwesomeIcons.moneyBillWaveAlt,
                                        color: Colors.blue,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(translator.translate("deposit")),
                                    ],
                                  ),
                                )),
                                onTap: () async {
                                  if (!gd.isVerified) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context2) =>
                                              KYCUserVerificationForceScreen(
                                            token: snapshot
                                                .baseMainRepository.bearerToken,
                                          ),
                                        ));
                                    return;
                                  }
                                  Navigator.pop(context);
                                  await Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DepositPanelScreen(
                                                  snapshot
                                                      .individualMainRepository,
                                                  snapshot.userWallets,
                                                  UserTypes.Individual)));
                                  snapshot.getDashboardDataFromApi();
                                },
                              ),
                              Divider(
                                color: Colors.black12,
                                height: 1.0,
                              ),
                              ListTile(
                                title: Container(
                                    child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        FontAwesomeIcons.database,
                                        color: Colors.blue,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(translator.translate("withdraw")),
                                    ],
                                  ),
                                )),
                                onTap: () async {
                                  if (!gd.isVerified) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context2) =>
                                              KYCUserVerificationForceScreen(
                                            token: snapshot
                                                .baseMainRepository.bearerToken,
                                          ),
                                        ));
                                    return;
                                  }
                                  Navigator.pop(context);
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UserWithdrawalPanelScreen(
                                                snapshot
                                                    .individualMainRepository,
                                                snapshot.userWallets),
                                      ));
                                  snapshot.getDashboardDataFromApi();
                                },
                              ),
                              // Divider(
                              //   color: Colors.black12,
                              //   height: 1.0,
                              // ),
                              // ListTile(
                              //   title: Container(
                              //       child: Align(
                              //     alignment: Alignment.centerLeft,
                              //     child: Row(
                              //       children: <Widget>[
                              //         Icon(
                              //           FontAwesomeIcons.exchangeAlt,
                              //           color: Colors.blue,
                              //           size: 20,
                              //         ),
                              //         SizedBox(
                              //           width: 20,
                              //         ),
                              //         Text(translator.translate("exchange")),
                              //       ],
                              //     ),
                              //   )),
                              //   onTap: () async {
                              //     Navigator.pop(context);
                              //     await Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //           builder: (context) =>
                              //               ExchangePanelScreen(
                              //                   snapshot
                              //                       .individualMainRepository,
                              //                   snapshot.userWallets,
                              //                   UserTypes.Individual),
                              //         ));
                              //     snapshot.getDashboardDataFromApi();
                              //   },
                              // ),
                              Divider(
                                color: Colors.black12,
                                height: 1.0,
                              ),
                              ExpansionTile(
                                  title: Container(
                                      child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.paperPlane,
                                          color: Colors.blue,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                            translator.translate("moneytrans")),
                                      ],
                                    ),
                                  )),
                                  backgroundColor: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.025),
                                  children: <Widget>[
                                    Divider(
                                      color: Colors.black12,
                                      height: 1.0,
                                    ),
                                    new ListTile(
                                      title: Container(
                                          child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Icon(
                                              FontAwesomeIcons.userEdit,
                                              color: Colors.blue,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(translator
                                                .translate("sendmoney")),
                                          ],
                                        ),
                                      )),
                                      onTap: () async {
                                        if (!gd.isVerified) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context2) =>
                                                    KYCUserVerificationForceScreen(
                                                  token: snapshot
                                                      .baseMainRepository
                                                      .bearerToken,
                                                ),
                                              ));
                                          return;
                                        }
                                        Navigator.pop(context);
                                        await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MoneyTransferSendScreen(
                                                      snapshot
                                                          .baseMainRepository,
                                                      snapshot.userWallets),
                                            ));
                                        snapshot.getDashboardDataFromApi();
                                      },
                                    ),
                                    Divider(
                                      color: Colors.black12,
                                      height: 1.0,
                                    ),
                                    new ListTile(
                                      title: Container(
                                          child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Icon(
                                              FontAwesomeIcons.university,
                                              color: Colors.blue,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(translator
                                                .translate("requestMoney")),
                                          ],
                                        ),
                                      )),
                                      onTap: () async {
                                        if (!gd.isVerified) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context2) =>
                                                    KYCUserVerificationForceScreen(
                                                  token: snapshot
                                                      .baseMainRepository
                                                      .bearerToken,
                                                ),
                                              ));
                                          return;
                                        }
                                        Navigator.pop(context);
                                        await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  RequestMoneyScreen(
                                                      snapshot
                                                          .baseMainRepository,
                                                      snapshot.userWallets),
                                            ));
                                        snapshot.getDashboardDataFromApi();
                                      },
                                    ),
                                  ]),
                              Divider(
                                color: Colors.black12,
                                height: 1.0,
                              ),
                              ExpansionTile(
                                  title: Container(
                                      child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.settings,
                                          color: Colors.blue,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(translator.translate("setting")),
                                      ],
                                    ),
                                  )),
                                  backgroundColor: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.025),
                                  children: <Widget>[
                                    Divider(
                                      color: Colors.black12,
                                      height: 1.0,
                                    ),
                                    new ListTile(
                                      title: Container(
                                          child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Icon(
                                              FontAwesomeIcons.userEdit,
                                              color: Colors.blue,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(translator
                                                .translate("profile")),
                                          ],
                                        ),
                                      )),
                                      onTap: () async {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        String tckn = prefs.getString("token");

                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProfileSettingsScreen(
                                                snapshot
                                                    .individualMainRepository,
                                                widget.loginModel,
                                              ),
                                            ));
                                      },
                                    ),
                                    Divider(
                                      color: Colors.black12,
                                      height: 1.0,
                                    ),
                                    new ListTile(
                                      title: Container(
                                          child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Icon(
                                              FontAwesomeIcons.university,
                                              color: Colors.blue,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(translator
                                                .translate("accounts")),
                                          ],
                                        ),
                                      )),
                                      onTap: () {
                                        if (!gd.isVerified) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context2) =>
                                                    KYCUserVerificationForceScreen(
                                                  token: snapshot
                                                      .baseMainRepository
                                                      .bearerToken,
                                                ),
                                              ));
                                          return;
                                        }
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BankAccountScreen(snapshot
                                                      .baseMainRepository),
                                            ));
                                      },
                                    ),
                                    Divider(
                                      color: Colors.black12,
                                      height: 1.0,
                                    ),
                                    new ListTile(
                                      title: Container(
                                          child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Icon(
                                              FontAwesomeIcons.commentDollar,
                                              color: Colors.blue,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(translator
                                                .translate("moneytrans")),
                                          ],
                                        ),
                                      )),
                                      onTap: () {
                                        if (!gd.isVerified) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context2) =>
                                                    KYCUserVerificationForceScreen(
                                                  token: snapshot
                                                      .baseMainRepository
                                                      .bearerToken,
                                                ),
                                              ));
                                          return;
                                        }
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TransferSettingsScreen(
                                                baseRepo:
                                                    snapshot.baseMainRepository,
                                              ),
                                            ));
                                      },
                                    ),
                                    Divider(
                                      color: Colors.black12,
                                      height: 1.0,
                                    ),
                                    new ListTile(
                                      title: Container(
                                          child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Icon(
                                              Icons.notifications,
                                              color: Colors.blue,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(translator.translate("Noti")),
                                          ],
                                        ),
                                      )),
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  NotificationSettingsScreen(
                                                      snapshot
                                                          .baseMainRepository),
                                            ));
                                      },
                                    ),
                                  ]),
                              Divider(
                                color: Colors.black12,
                                height: 1.0,
                              ),
                              ExpansionTile(
                                title: Container(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.security,
                                            color: Colors.blue,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(translator.translate("security")),
                                        ],
                                      ),
                                )),

//                                onTap: () {
//                                  if (!gd.isVerified) {
//                                    Navigator.push(
//                                        context,
//                                        MaterialPageRoute(
//                                          builder: (context2) =>
//                                              KYCUserVerificationForceScreen(
//                                            token: snapshot
//                                                .baseMainRepository.bearerToken,
//                                          ),
//                                        ));
//                                    return;
//                                  }
//                                  Navigator.pop(context);
//                                  Navigator.push(
//                                      context,
//                                      MaterialPageRoute(
//                                        builder: (context) => SecurityScreen(
//                                            snapshot.baseMainRepository),
//                                      ));
//                                },
                              children: [
                                Divider(
                                  color: Colors.black12,
                                  height: 1.0,
                                ),
                                new ListTile(
                                  title: Container(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Icon(
                                              FontAwesomeIcons.lock,
                                              color: Colors.blue,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(translator
                                                .translate("changePassword")),
                                          ],
                                        ),
                                      )),
                                  onTap: () async {


                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              change_Password(snapshot.baseMainRepository)
                                        ));
                                  },
                                ),
                                Divider(
                                  color: Colors.black12,
                                  height: 1.0,
                                ),
                                new ListTile(
                                  title: Container(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Icon(
                                              Icons.mail,
                                              color: Colors.blue,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(translator
                                                .translate("changeMail")),
                                          ],
                                        ),
                                      )),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => change_email(snapshot.baseMainRepository),
                                        ));
                                  },
                                ),
                                Divider(
                                  color: Colors.black12,
                                  height: 1.0,
                                ),
                                new ListTile(
                                  title: Container(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Icon(
                                              FontAwesomeIcons.fingerprint,
                                              color: Colors.blue,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(translator
                                                .translate("biometricLogin")),
                                          ],
                                        ),
                                      )),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context2) =>
                                              biometric_Login(),
                                        ));

//                                    if (!gd.isVerified) {
//                                      Navigator.push(
//                                          context,
//                                          MaterialPageRoute(
//                                            builder: (context2) =>
//                                                KYCUserVerificationForceScreen(
//                                                  token: snapshot
//                                                      .baseMainRepository.bearerToken,
//                                                ),
//                                          ));
//                                      return;
//                                    }
//                                    Navigator.pop(context);
//                                    Navigator.push(
//                                        context,
//                                        MaterialPageRoute(
//                                          builder: (context) => SecurityScreen(
//                                              snapshot.baseMainRepository),
//                                        ));
                                  },
                                ),
                                Divider(
                                  color: Colors.black12,
                                  height: 1.0,
                                ),
                              ],
                              ),
                              Divider(
                                color: Colors.black12,
                                height: 1.0,
                              ),
                              ListTile(
                                title: Container(
                                    child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.headset_mic,
                                        color: Colors.blue,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(translator.translate("help")),
                                    ],
                                  ),
                                )),
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Help_detail(
                                            snapshot.baseMainRepository,
                                            snapshot.userWallets,
                                            UserTypes.Individual),
                                      ));
                                },
                              ),
                              Divider(
                                color: Colors.black12,
                                height: 1.0,
                              ),
                              ListTile(
                                title: Container(
                                    child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.chat_bubble,
                                        color: Colors.blue,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(translator.translate("support")),
                                    ],
                                  ),
                                )),
                                onTap: () {
                                  //////////////////////////////////////////
                                  //////////////////////////////////////////
                                  ////////////////////////////////////////////

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Live_Support(),
                                      ));
                                },
                              ),
                              Divider(
                                color: Colors.black12,
                                height: 1.0,
                              ),
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(60),
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Container(
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  width: 1.0,
                                                  style: BorderStyle.solid,
                                                  color: Colors.black45),
                                            ),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              icon: Icon(
                                                  Icons.keyboard_arrow_down),
                                              items: [
                                                DropdownMenuItem(
                                                  value: 'en',
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      SizedBox(width: 10),
                                                      SizedBox(
                                                        child: Image.asset(
                                                          'icons/flags/png/gb.png',
                                                          package:
                                                              'country_icons',
                                                          width: 20,
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Expanded(
                                                        child: Text(
                                                          "English",
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                DropdownMenuItem(
                                                  value: 'tr',
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      SizedBox(width: 10),
                                                      SizedBox(
                                                        child: Image.asset(
                                                          'icons/flags/png/tr.png',
                                                          package:
                                                              'country_icons',
                                                          width: 20,
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Expanded(
                                                        child: Text(
                                                          "Türkçe",
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                              onChanged: (value) async {
                                                print(value.toString());

                                                if (value == "tr") {
                                                  await translator
                                                      .setNewLanguage(context,
                                                          newLanguage: "tr",
                                                          restart: false,
                                                          remember: true)
                                                      .then((value) {
                                                    translator.init("tr");
                                                    setState(() {
                                                      _language_value = "tr";
                                                    });
                                                  });
                                                }
                                                if (value == "en") {
                                                  await translator
                                                      .setNewLanguage(context,
                                                          newLanguage: "en",
                                                          restart: false,
                                                          remember: true)
                                                      .then((value) {
                                                    translator.init("en");

                                                    setState(() {
                                                      _language_value = "en";
                                                    });
                                                  });
                                                }

                                                http.post(
                                                    points.APIEndPoints
                                                        .LangIndividualAPIEndPoint,
                                                    headers: {
                                                      "Accept":
                                                          "application/json",
                                                      "Authorization": userToken
                                                    },
                                                    body: {
                                                      "new_language": translator
                                                          .currentLanguage
                                                          .toString()
                                                    }).then((value) => print(
                                                    value.body.toString()));
                                              },
                                              value: _language_value,
                                              isExpanded: true,
                                            ),
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Container(
                                        child: FlatButton(
                                          onPressed: () {
                                            var remem = false,
                                                email = "",
                                                pass = "",
                                                phone = "",
                                                passCor = "",
                                                countryCode = "",
                                                countryFlagUri = "";
                                            pref.setBool("FingerPrintIsOk", false);
                                            pref.setBool("isLoggedInFirst", false);
                                            pref.setString("userName", "");

                                            SharedPreferences.getInstance()
                                                .then((prefs) {
                                              setState(() {
                                                remem =
                                                    prefs.getBool("remember");
                                              });

                                              if (remem == true) {
                                                phone =
                                                    prefs.getString("phone");
                                                pass = prefs.getString("pass");
                                                email =
                                                    prefs.getString("email");
                                                passCor =
                                                    prefs.getString("passCor");

                                                countryCode = prefs.getString(
                                                        "country_code") ??
                                                    "";
                                                countryFlagUri = prefs.getString(
                                                        "country_flagUri") ??
                                                    "";
                                              }
                                              prefs.setString('token', '');
                                            });


                                            snapshot.logoutUser(() {
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                builder: (context) =>
                                                    MyLoginPage(
                                                        remem ?? false,
                                                        email ?? "",
                                                        "",
                                                        phone ?? "",
                                                        false,
                                                        "",
                                                        countryCode,
                                                        countryFlagUri),
                                              ));

                                              Flushbar(
                                                title: "",
                                                message: translator
                                                    .translate("logoutSuccess"),
                                                duration: Duration(seconds: 3),
                                              )..show(context);
                                            }, () {
                                              Flushbar(
                                                title: "",
                                                message: translator
                                                    .translate("failedlogout"),
                                                duration: Duration(seconds: 3),
                                              )..show(context);
                                            });
                                          },
                                          color: Colors.blue,
                                          disabledColor: Colors.blue,
                                          padding: EdgeInsets.all(16.0),
                                          child: Text(
                                            translator.translate("logout"),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(50),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
                backgroundColor: Colors.white,
                body: Consumer<IndividualPanelProvider>(
                  builder: (context, snapshot, _) {
                    return Stack(
                      children: <Widget>[
                        Container(
                            child: Stack(
                          children: <Widget>[
                            new Transform.translate(
                              offset: Offset(0.0, -56.0),
                              child: new Container(
                                child: new ClipPath(
                                  clipper: new MyClipper(),
                                  child: new Stack(
                                    children: [
                                      Container(
                                        decoration: new BoxDecoration(
                                          image: new DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  'assets/dash_back.png')),
                                        ),
                                      ),
                                      new Opacity(
                                        opacity: 0.2,
                                        child:
                                            new Container(color: Colors.blue),
                                      ),
                                      new Transform.translate(
                                        offset: Offset(0.0, 50.0),
                                        child: Container(
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10.0,
                                                  right: 10.0,
                                                  top: 30),
                                              child: new Swiper.children(
                                                  autoplay: false,
                                                  loop: false,
                                                  pagination:
                                                      new SwiperPagination(
                                                          margin: new EdgeInsets
                                                                  .fromLTRB(
                                                              0.0, 0.0, 0.0, 0.0),
                                                          builder:
                                                              new DotSwiperPaginationBuilder(
                                                            color:
                                                                Colors.white54,
                                                            activeColor:
                                                                Colors.white,
                                                            size: 7.0,
                                                            activeSize: 7.0,
                                                          )),
                                                  children: snapshot
                                                              .userWallets ==
                                                          null
                                                      ? <Widget>[Container()]
                                                      : snapshot.userWallets
                                                                  .length ==
                                                              1
                                                          ? <Widget>[
                                                              _getSlide(null, 0)
                                                            ]
                                                          : snapshot.userWallets
                                                                      .length ==
                                                                  2
                                                              ? <Widget>[
                                                                  _getSlide(
                                                                      null, 0),
                                                                  _getSlide(
                                                                      null, 1)
                                                                ]
                                                              : snapshot.userWallets
                                                                          .length ==
                                                                      3
                                                                  ? <Widget>[_getSlide(null, 0), _getSlide(null, 1), _getSlide(null, 2)]
                                                                  : <Widget>[Container()])),
                                          height: 130,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            /*     new Transform.translate(
                                offset: Offset(0.0, 130.0),
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 0),
                                    child: Container(
                                        decoration: new BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 0.5,
                                            ),
                                          ],
                                          color: Colors.white,
                                        ),
                                        child: new Swiper.children(
                                          autoplay: false,
                                          pagination: new SwiperPagination(
                                              margin: new EdgeInsets.fromLTRB(
                                                  0.0, 0.0, 0.0, 10.0),
                                              builder:
                                                  new DotSwiperPaginationBuilder(
                                                color: Colors.blueGrey,
                                                activeColor: Colors.blueAccent,
                                                size: 7.0,
                                                activeSize: 7.0,
                                              )),
                                          children: <Widget>[
                                            _getSlideS(users),
                                            _getSlideS(users),
                                            _getSlideS(users),
                                          ],
                                        )),
                                  ),
                                  height: _media.height / 4.0,
                                ),
                              ),  */

                            new Transform.translate(
                                offset:
                                    Offset(0.0, 130.0 + _media.height / 12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 30.0, right: 30.0),
                                        child: InkWell(
                                          onTap: () {
//                                            Navigator.push(context, MaterialPageRoute(
//                                                builder: (context)=> nine_one()
//                                            ));
                                            //showDialougeBox1();
                                          },
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              translator
                                                  .translate("lastActivity"),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                              ),
                                            ),
                                          ),
                                        )),
                                    Consumer<IndividualPanelProvider>(
                                        builder: (context, snapshot, _) {
                                      //             print("     "+snapshot.getTransactionsListActivity()[0].toString());
                                      return SingleChildScrollView(
                                        child: Container(
                                          child: RefreshIndicator(
                                            onRefresh: snapshot
                                                .getDashboardDataFromApi,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: snapshot
                                                  .getTransactionsListActivity()
                                                  .length,
                                              itemBuilder:
                                                  (BuildContext content,
                                                      int index) {
                                                //    print(snapshot.userLastTransactionsActivity[
                                                ///                           index].toString());
                                                return lastActivityList(
                                                    title: AppUtils.getTransactionableType(
                                                        snapshot.userLastTransactionsActivity[index]
                                                            [
                                                            'transactionable_type']),
                                                    value:
                                                        '${snapshot.userLastTransactionsActivity[index]['money_flow']} ${To2double(snapshot.userLastTransactionsActivity[index]['gross'].toString())} ${snapshot.userLastTransactionsActivity[index]['currency_symbol']}',
                                                    description: this
                                                        .capitalize(snapshot
                                                            .userLastTransactionsActivity[index]
                                                                ['entity_name']
                                                            .toString()),

                                                    ///(#${snapshot.userLastTransactionsActivity[index]['id']})
                                                    dates: snapshot
                                                        .userLastTransactionsActivity[
                                                            index]['created_at']
                                                        .toString()
                                                        .substring(0, 16),
                                                    body: {
                                                      "id": snapshot
                                                              .userLastTransactionsActivity[
                                                          index]["id"],
                                                      "transactionable_id":
                                                          snapshot.userLastTransactionsActivity[
                                                                  index][
                                                              "transactionable_id"],
                                                      "payment_id": snapshot
                                                              .userLastTransactionsActivity[
                                                          index]["payment_id"],
                                                      "entity_name": snapshot
                                                              .userLastTransactionsActivity[
                                                          index]["entity_name"],
                                                      "money_flow": snapshot
                                                              .userLastTransactionsActivity[
                                                          index]["money_flow"],
                                                      "net": snapshot
                                                              .userLastTransactionsActivity[
                                                          index]["net"],
                                                      "currency_symbol": snapshot
                                                              .userLastTransactionsActivity[
                                                          index]["currency_symbol"],
                                                      "created_at": snapshot
                                                              .userLastTransactionsActivity[
                                                          index]["created_at"],
                                                      "updated_at": snapshot
                                                              .userLastTransactionsActivity[
                                                          index]["updated_at"],
                                                      "transactionable_type":
                                                          snapshot.userLastTransactionsActivity[
                                                                  index][
                                                              "transactionable_type"]
                                                    });
                                              },
                                            ),
                                          ),
                                          height: _media.height * 0.5 - 45,
                                        ),
                                      );
                                    })
                                  ],
                                )),
                          ],
                        )),
                        Consumer<IndividualPanelProvider>(
                            builder: (context, snapshot, _) {
                          return Dashboardbottom(
                              context,
                              snapshot.baseMainRepository,
                              snapshot.userWallets,
                              UserTypes.Individual);
                        }),
                      ],
                    );
                  },
                )));
    /*    } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            }) //);
            */
  }

  Widget _getSlide(users, index) {
    return Consumer<IndividualPanelProvider>(builder: (context, snapshot, _) {
      return Padding(
        padding: EdgeInsets.only(left: 30.0, right: 30.0),
        child: new Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        translator.translate("balance"),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    Container(
                      child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                              // set the default style for the children TextSpans
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                  text: snapshot.getTotalWalletAmount(index),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0 -
                                          snapshot
                                              .getAvailableWalletAmount(index)
                                              .toString()
                                              .length,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                    text:
                                        snapshot.getWalletCurrencyCode2(index),
                                    style: TextStyle(
                                        fontSize: 23.0 -
                                            snapshot
                                                .getAvailableWalletAmount(index)
                                                .toString()
                                                .length,
                                        color: Colors.white)),
                              ])),
                      alignment: Alignment.bottomLeft,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
                height: 100,
              ),
              flex: 3,
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        translator.translate("availableBalance"),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      alignment: Alignment.centerRight,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                              // set the default style for the children TextSpans
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                  text:
                                      snapshot.getAvailableWalletAmount(index),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0 -
                                          snapshot
                                              .getAvailableWalletAmount(index)
                                              .toString()
                                              .length,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                    text:
                                        snapshot.getWalletCurrencyCode2(index),
                                    style: TextStyle(
                                        fontSize: 23.0 -
                                            snapshot
                                                .getAvailableWalletAmount(index)
                                                .toString()
                                                .length,
                                        color: Colors.white)),
                              ])),
                      alignment: Alignment.bottomLeft,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
                height: 100,
              ),
              flex: 2,
            ),
          ],
        ),
      );
    });
  }

/*   Widget _getSlideS(users) {
    return new Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Text(
            users.welcome,
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Image.asset(
              'assets/welcome.png',
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  } */

  Widget lastActivityList(
      {String title,
      String value,
      String description,
      String dates,
      dynamic body}) {
    return InkWell(
      onTap: () {
//print(map2.toString());
//print(title+"  "+body["id"].toString());

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ActivityDetailsScreen(
                      body: body,
                    )));
      },
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 30.0, right: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      translator.translate(title),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Expanded(
                      child: Text(
                        //    double.parse(value.replaceAll("+","").
                        value,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        description.splitMapJoin(RegExp(r'\w+'),
                            onMatch: (m) =>
                                '${m.group(0)}'.substring(0, 1) +
                                '${m.group(0)}'.substring(1).toLowerCase()),
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        dates,
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 12),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Divider(
            height: 1.0,
            color: Colors.black12,
          )
        ],
      ),
    );
  }

  _asyncMethod(String userProfileImage) async {
    //comment out the next two lines to prevent the device from getting
    // the image from the web in order to prove that the picture is
    // coming from the device instead of the web.
    var url = userProfileImage; // <-- 1
    var response = await get(url); // <--2
    var documentDirectory = await getApplicationDocumentsDirectory();
    var firstPath = documentDirectory.path + "/images";
    var filePathAndName = documentDirectory.path + '/images/pic.jpg';
    //comment out the next three lines to prevent the image from being saved
    //to the device to show that it's coming from the internet
    await Directory(firstPath).create(recursive: true); // <-- 1
    File file2 = new File(filePathAndName);             // <-- 2
    file2.writeAsBytesSync(response.bodyBytes); // <-- 3
    print(">>>download");
    setState(() {
      imageData = filePathAndName;
      dataLoaded = true;
    });
  }

Widget Dashboardbottom(BuildContext context, BaseMainRepository baseRepo,
    var wallets, UserTypes userType) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: SizedBox(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.blue,
              child: FlatButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.moneyBillWaveAlt,
                      color: Colors.white,
                      size: 15,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      translator.translate("deposit"),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                onPressed: () async {
                  if (!gd.isVerified) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context2) => KYCUserVerificationForceScreen(
                              token: baseRepo.bearerToken),
                        ));
                    return;
                  }
                  baseRepo.depositForm().then((x) {
                    print("111111111111111111=>" + x.data.toString());
                    print(
                        "222222222222222222=>" + "/////" + wallets.toString());
                    print("33333333333333333=>" + userType.toString());
                  });
//print("NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN");
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          DepositPanelScreen(baseRepo, wallets, userType)));
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.blue,
              child: FlatButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.paperPlane,
                      color: Colors.white,
                      size: 15,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      translator.translate("moneytrans"),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
                onPressed: () {
                  if (!gd.isVerified) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context2) => KYCUserVerificationForceScreen(
                              token: baseRepo.bearerToken),
                        ));
                    return;
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => userType == UserTypes.Individual
                              ? MoneyTransferSendScreen(baseRepo, wallets)
                              : MoneyPanelScreen(baseRepo, wallets)));
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.blue,
              child: FlatButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.database,
                      color: Colors.white,
                      size: 15,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      translator.translate("withdraw"),
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
                onPressed: () {
                  if (userType == UserTypes.Individual) {
                    if (!gd.isVerified) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context2) =>
                                KYCUserVerificationForceScreen(
                                    token: baseRepo.bearerToken),
                          ));
                      return;
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context2) =>
                              UserWithdrawalPanelScreen(baseRepo, wallets),
                        ));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context2) =>
                              CreateCorporateWithdrawalsPanelScreen(
                                  baseRepo, wallets),
                        ));
                  }
                },
              ),
            ),
          ),

          // Expanded(
          //   flex: 1,
          //   child: Container(
          //     color: Colors.blue,
          //     child: FlatButton(
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: <Widget>[
          //           Icon(
          //             FontAwesomeIcons.exchangeAlt,
          //             color: Colors.white,
          //             size: 15,
          //           ),
          //           SizedBox(
          //             height: 5,
          //           ),
          //           Text(
          //        translator.translate("exchange"),
          //             style: TextStyle(color: Colors.white, fontSize: 12),
          //           ),
          //         ],
          //       ),
          //       onPressed: () {
          //         Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => ExchangePanelScreen(
          //                   baseRepo, wallets, UserTypes.Individual),
          //             ));
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
      height: 60,
      width: double.infinity,
    ),
  );
}}
