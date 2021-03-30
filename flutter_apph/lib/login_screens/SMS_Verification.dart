import 'dart:convert';
import 'dart:io';
import 'package:fluttersipay/corporate/global_data.dart' as global;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersipay/corporate/dashboard/merchant.dart';
import 'package:fluttersipay/dashboard/merchant_panel.dart';
import 'package:fluttersipay/loading_widget.dart';
import 'package:fluttersipay/login_screens/login_repo.dart';
import 'package:fluttersipay/login_screens/providers/sms_verification_provider.dart';
import 'package:fluttersipay/login_screens/renew_password.dart';
import 'package:fluttersipay/utils/constants.dart';
import 'package:fluttersipay/utils/custom_text_style.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:quiver/async.dart';
import 'package:fluttersipay/dashboard/drawerMenu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_timer/simple_timer.dart';

//import 'package:timer_builder/timer_builder.dart';
//import 'package:timer_count_down/timer_count_down.dart';
import '../main_api_data_model.dart';
import 'email_pass_notVerified.dart';
import 'json_models/sms_verification_ui_model.dart';
import 'package:fluttersipay/corporate/datas.dart';

class SMSVerificationScreen extends StatefulWidget {
  final MainApiModel loginModel;
  final NavigationToSMSTypes navigationToSMSType;
  final UserTypes userType;
  var verified = true;
  var newUnverified = false;

  SMSVerificationScreen(this.loginModel, this.navigationToSMSType,
      {this.userType, this.verified, this.newUnverified});

  @override
  SMSVerificationScreenState createState() => SMSVerificationScreenState();
}

class SMSVerificationScreenState extends State<SMSVerificationScreen>
    with SingleTickerProviderStateMixin {
  bool isTimeEnd = false;
  TimerController timeController;
  static TimerStatus timerStatus = TimerStatus.start;
  Widget timer = Container();

  @override
  void initState() {
    timeController = TimerController(this);
    timer = SimpleTimer(
      controller: timeController,
      // status: timerStatus,
      duration: const Duration(seconds: 00, minutes: 3),
      backgroundColor: Colors.white,
      progressIndicatorDirection: TimerProgressIndicatorDirection.clockwise,
      progressIndicatorColor: Colors.blue,
      progressTextStyle: TextStyle(
          fontSize: 40, fontWeight: FontWeight.w800, color: Colors.blue[700]),
      strokeWidth: 12,
      onEnd: () {
        setState(() {
          isTimeEnd = true;
        });
      },
    );
    super.initState();
    Future.delayed(Duration(milliseconds: 200), () {
      timeController.start();
    });
  }

  Future<bool> popCallback() async {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.loginModel.data["user"]["updated_password_at"]);

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
      child: Scaffold(

          //   drawer: DrawerMenu().getDrawer,
          appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      SystemNavigator.pop();
                    }
                  },
                );
              },
            ),
            centerTitle: true,
            title: Text(translator.translate("smsverify")),
            flexibleSpace: Image(
              image: AssetImage('assets/appbar_bg.png'),
              height: 100,
              fit: BoxFit.fitWidth,
            ),
            actions: <Widget>[
              IconButton(
                padding: const EdgeInsets.only(right: 20.0),
                icon: Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.white,
                ),
                onPressed: () {
                  // do something
                },
              )
            ],
          ),
          body: ChangeNotifierProvider<SMSVerificationProvider>(
              create: (context) => SMSVerificationProvider(
                  widget.navigationToSMSType,
                  widget.loginModel,
                  LoginRepository(),
                  TextEditingController(),
                  CountdownTimer(Duration(seconds: 180), Duration(seconds: 1))),
              child: SingleChildScrollView(child: Container(child:
                  Consumer<SMSVerificationProvider>(
                      builder: (context, snapshot, _) {
                return Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: ScreenUtil.getInstance().setWidth(60),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30.0, right: 30.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              translator.translate("verifiyInfo"),
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
                            width: ScreenUtil.getInstance().setHeight(780),
                            height: ScreenUtil.getInstance().setHeight(100),
                            decoration: new BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black12,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 30.0, right: 30.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      translator.translate("urPhone"),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      snapshot.phoneNumber,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )),
                        Container(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(65),
                              ),
                              Container(width: 150, child: timer),
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(20),
                              ),
                              Text(
                                translator.translate("remainingTime"),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                          height: ScreenUtil.getInstance().setHeight(420),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30.0, right: 30.0),
                          child: TextField(
                            style: TextStyle(color: Colors.black),
                            keyboardType: TextInputType.number,
                            //maxLength: 6,
                            controller: snapshot.smsController,
                            decoration: InputDecoration(
                              errorText: snapshot.otpErrorText,
                              hintStyle: CustomTextStyle.formField(context),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black12, width: 1.0)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black12, width: 1.0)),
                              prefixIcon: const Icon(
                                Icons.message,
                                color: Colors.black38,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(5),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 40),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Visibility(
                              visible: isTimeEnd,
                              child: FlatButton(
                                onPressed: () {
                                  if (isTimeEnd) {
                                    setState(() {
                                      isTimeEnd = false;
                                    });
                                    timeController.restart();
                                    snapshot.resendLoginVerificationSMS(
                                        widget.userType, () {}, () {});
                                  }
                                },
                                child: Text(
                                  translator.translate("resend"),
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(10),
                        ),
//                        Container(
//                          child: RichText(
//                              textAlign: TextAlign.center,
//                              text: TextSpan(
//                                  // set the default style for the children TextSpans
//                                  style: TextStyle(
//                                    fontSize: 16,
//                                  ),
//                                  children: [
//                                    TextSpan(
//                                        text: translator.translate("hint") +
//                                            ' ', //users.byclicks,
//                                        style: TextStyle(color: Colors.black45)),
//                                    TextSpan(
//                                        text: translator.translate("user") +
//                                            " " +
//                                            translator.translate("agreement"),
//                                        style: TextStyle(color: Colors.blue)),
//                                    TextSpan(
//                                        text: " " +
//                                            translator.translate("and") +
//                                            " ",
//                                        style: TextStyle(color: Colors.black45)),
//                                    TextSpan(
//                                        text: translator.translate("PPplicy"),
//                                        style: TextStyle(color: Colors.blue)),
//                                  ])),
//                          width: ScreenUtil.getInstance().setWidth(660),
//                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(50),
                        ),
                        Container(
                          child: FlatButton(
                            onPressed: () {
                              snapshot.verifyLoginSMS(widget.userType,
                                  (MainApiModel userData, token) async {
                                datas.loginModel = userData;
                                datas.tokens = token;
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setBool("isIndividual",
                                    widget.userType == UserTypes.Individual);
                                prefs.setString("token", token).then((value) {
                                  global.setUserToken();
                                });

//                                print(userData.data["user"]["verified"]);
//                                if(!userData.data["user"]["verified"]){
//                                  print("Unverified");
//                                  Navigator.of(context).pushAndRemoveUntil(
//                                      MaterialPageRoute(
//                                          builder: (context) => emailPass(
//                                            userData,
//                                            token,
//                                            isKYC: true,
//                                          )),
//                                          (route) => false);
//                                }
                                    if(userData.data["user"]["verified"]!=null &&userData.data["user"]["verified"]==false){
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) => emailPass(
                                                userData,
                                                token,
                                                isKYC: true,
                                              )),
                                              (route) => false);
                                    }
                                    if(userData.data["user"]["user_category"]!=null &&userData.data["user"]["user_category"]==0){
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) => emailPass(
                                                userData,
                                                token,
                                                isKYC: true,
                                              )),
                                              (route) => false);
                                    }

                                global.isVerified = userData.data["user"]["user_category"] > 1;
                                print('=====here to check global isVerified=====');
                                print("....>>>"+global.isVerified.toString());


                                String password =
                                    await prefs.getString('password');

                                if (widget.userType == UserTypes.Individual) {
                                  //  print(userData.data["user"]["updated_password_at"].toString().replaceAll("-","").replaceAll(":", "").replaceAll(" ", "") );

//print("                                 date "+days.toString());

                                  if (userData.data["user"]["user_category"] == 1) {
                                    //  UNverifed

                                    if (userData.data["user"]["email"] == null) {
//old un

                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) => emailPass(
                                                    userData,
                                                    token,
                                                    isKYC: false,
                                                  )),
                                          (route) => false);
                                    } else {
                                      //  new UnVIRIFIED

                                      var date = userData.data["user"]
                                          ["updated_password_at"];

                                      DateTime datetime =
                                          DateFormat("yyyy-MM-dd HH:mm:ss")
                                              .parse(date);
                                      int days = DateTime.now()
                                          .difference(datetime)
                                          .inDays;
                                      print("Dsys   //    " + days.toString());
                                      if (days > 180) {
                                        return Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RenewPassword(
                                                            mainApiModel:
                                                                userData)),
                                                (route) => false);
                                      } else {
                                        print(
                                            "^^^^^^^^^^^^^^^^^^^^^^^################333^^^^^^^^^^^^^^^^^^^^^^^^^");
                                        if (isNumeric(password)) {
                                          print(
                                              "^^^^^^^^^^^^^^^^^^^^^^^##########2222^^^^^^^^^^^^^^^^^^^^^^^^^");
                                          return Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) => widget
                                                                  .userType ==
                                                              UserTypes.Individual
                                                          ? MerchantPanelScreen(
                                                              userData, token)
                                                          : CorporateMerchantPanelScreen(
                                                              userData, token)),
                                                  (route) => false);
                                        } else {
                                          return Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RenewPassword()),
                                                  (route) => false);
                                        }
                                      }
                                    }
                                  }
                                  // userData.data["user"]["verified"]==1   /// Verified
                                  else {
                                    if (userData.data["user"]["email"] == null) {
                                      print("//////////**");

                                      if (isNumeric(password)) {
                                        return Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) => widget
                                                                .userType ==
                                                            UserTypes.Individual
                                                        ? MerchantPanelScreen(
                                                            userData, token)
                                                        : CorporateMerchantPanelScreen(
                                                            userData, token)),
                                                (route) => false);
                                      } else {
                                        return Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RenewPassword()),
                                                (route) => false);
                                      }
                                    } else {
                                      ///  vfirivied

                                      var date = userData.data["user"]
                                          ["updated_password_at"];

                                      DateTime datetime =
                                          DateFormat("yyyy-MM-dd HH:mm:ss")
                                              .parse(date);
                                      int days = DateTime.now()
                                          .difference(datetime)
                                          .inDays;
                                      print("DAys    ****  " + days.toString());
                                      if (days > 180) {
                                        return Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RenewPassword(
                                                            mainApiModel:
                                                                userData)),
                                                (route) => false);
                                      } else {
                                        if (isNumeric(password)) {
                                          return Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) => widget
                                                                  .userType ==
                                                              UserTypes.Individual
                                                          ? MerchantPanelScreen(
                                                              userData, token)
                                                          : CorporateMerchantPanelScreen(
                                                              userData, token)),
                                                  (route) => false);
                                        } else {
                                          return Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RenewPassword()),
                                                  (route) => false);
                                        }
                                      }
                                    }
                                  }

                                  /*

             if(userData.data["user"]["verified"]==1&&userData.data["user"]["email"]!=null&&widget.userType == UserTypes.Individual){

               var date=userData.data["user"]["updated_password_at"];
               if(date!=null) {
                 DateTime datetime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(
                     date);
                 int days = datetime
                     .difference(DateTime.now())
                     .inDays;
print("DAys      "+days.toString());
                 if (days > 180) {
                   Navigator.of(context).pushAndRemoveUntil(
                       MaterialPageRoute(
                           builder: (context) =>
                               RenewPassword(mainApiModel: userData)),
                           (route) => false);
                 } else {
                   Navigator.of(context).pushAndRemoveUntil(
                       MaterialPageRoute(
                           builder: (context) =>
                           widget.userType ==
                               UserTypes.Individual
                               ? MerchantPanelScreen(
                               userData, token)
                               : CorporateMerchantPanelScreen(
                               userData, token)),
                           (route) => false);
                 }
               }else{


                 Navigator.of(context).pushAndRemoveUntil(
                     MaterialPageRoute(
                         builder: (context) =>
                         widget.userType ==
                             UserTypes.Individual
                             ? MerchantPanelScreen(
                             userData, token)
                             : CorporateMerchantPanelScreen(
                             userData, token)),
                         (route) => false);


               }
  print("new un verified");

}else
  if(userData.data["user"]["verified"]==0&&userData.data["user"]["email"]!=null&&widget.userType == UserTypes.Individual){

                                    print("old un verified");
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                emailPass( userData, token,isKYC: false,)),
                                            (route) => false);
                                  }else if(userData.data["user"]["verified"]==1&&userData.data["user"]["email"]!=null
        &&widget.userType == UserTypes.Individual){
////////////// new verivied
      var date=userData.data["user"]["updated_password_at"];
      if(date!=null) {
        DateTime datetime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(
            date);
        int days = datetime
            .difference(DateTime.now())
            .inDays;

        if (days > 180) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) =>
                      RenewPassword(mainApiModel: userData)),
                  (route) => false);
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) =>
                  widget.userType ==
                      UserTypes.Individual
                      ? MerchantPanelScreen(
                      userData, token)
                      : CorporateMerchantPanelScreen(
                      userData, token)),
                  (route) => false);
        }
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) =>
                widget.userType ==
                    UserTypes.Individual
                    ? MerchantPanelScreen(
                    userData, token)
                    : CorporateMerchantPanelScreen(
                    userData, token)),
                (route) => false);
      }


  }*/
                                  /*                             if (isNumeric(password)) {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => widget
                                                        .userType ==
                                                    UserTypes.Individual
                                                ? MerchantPanelScreen(
                                                    userData, token)
                                                : CorporateMerchantPanelScreen(
                                                    userData, token)),
                                        (route) => false);
                                  } else {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RenewPassword()),
                                        (route) => false);
                                  }*/
                                } else {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => widget.userType ==
                                                  UserTypes.Individual
                                              ? MerchantPanelScreen(
                                                  userData, token)
                                              : CorporateMerchantPanelScreen(
                                                  userData, token)),
                                      (route) => false);
                                }
                              }, () {});
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
                          width: ScreenUtil.getInstance().setWidth(690),
                        )
                      ],
                    ),
                    LoadingWidget(
                      isVisible: snapshot.showLoad,
                    )
                  ],
                );
              }))))),
    );
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}
