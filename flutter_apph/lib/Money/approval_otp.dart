import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersipay/loading_widget.dart';
import 'package:fluttersipay/utils/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttersipay/utils/custom_text_style.dart';
import 'dart:async';
import 'package:gradient_text/gradient_text.dart';
import 'package:fluttersipay/dashboard/Live_support.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:simple_timer/simple_timer.dart';
import 'package:translator/translator.dart' as translator1;
import 'package:http/http.dart' as http;
import 'package:fluttersipay/utils/api_endpoints.dart' as points;
import 'package:fluttersipay/corporate/global_data.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flushbar/flushbar.dart';

class ApprovalOTPScreen extends StatefulWidget {
  var map;

  ApprovalOTPScreen(
    this.map,
  );

  @override
  _ApprovalOTPScreenState createState() => _ApprovalOTPScreenState();
}

class _ApprovalOTPScreenState extends State<ApprovalOTPScreen> {
  var showLoad;

  TextEditingController smsController2 = new TextEditingController();

  var load = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
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
            title: Text(translator.translate("moneyReq")),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Live_Support(),
                      ));

                  // do something
                },
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Stack(
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
                    Visibility(
                      visible: true,
                      //map["data"]["inputs"]["receiver_phone"]!= null ?? false,
                      child: Container(
                          width: ScreenUtil.getInstance().setHeight(1000),
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
                                    widget.map["data"]["inputs"]
                                            ["sender_phone"] ??
                                        '',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(50),
                          ),
                          Container(
                            width: 150,
                            height: 150,
                            child: SimpleTimer(
                              status: TimerStatus.start,
                              duration: Duration(seconds: 00, minutes: 3),
                              backgroundColor: Colors.white,
                              progressIndicatorDirection:
                                  TimerProgressIndicatorDirection.clockwise,
                              progressIndicatorColor: Colors.blue,
                              progressTextStyle: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.blue[700]),
                              strokeWidth: 12,
                            ),
                          ),

                          /*    CircularPercentIndicator(
                              radius: ScreenUtil.getInstance().setHeight(160),
                              lineWidth: 10.0,
                              percent: timerPercent != null ? timerPercent : 1.0,
                              backgroundColor: Colors.white10,
                              center: GradientText(secondsLeft,
                                  gradient: otpGradient,
                                  style: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center),
                              linearGradient: otpGradient), */

                          /*       Text(
                            translator.translate("resend"),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black45,
                            ),
                          ),*/
                        ],
                      ),
                      height: ScreenUtil.getInstance().setHeight(430),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        controller: smsController2,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(fontSize: 10),

                          //  errorText: errorText,//errorText,

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
                        child: FlatButton(
                          onPressed: () {
                            //        resendOTP(onSuccess, onFailure);
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
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(10),
                    ),
                    /* Container(
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            // set the default style for the children TextSpans
                              style: TextStyle(
                                fontSize: 16,
                              ),
                              children: [
                                TextSpan(
                                    text: translator.translate("hint")+" ",//users.byclicks,
                                    style: TextStyle(
                                        color: Colors.black45)),
                                TextSpan(
                                    text:        translator.translate("Userprivacy"),
                                    style: TextStyle(
                                        color: Colors.blue)),
                                TextSpan(
                                    text:  " "+translator.translate("and")+" " ,
                                    style: TextStyle(
                                        color: Colors.black45)),
                                TextSpan(
                                    text:   translator.translate("PPplicy"),
                                    style: TextStyle(
                                        color: Colors.blue)),
                              ])),              width: ScreenUtil.getInstance().setWidth(660),
                    ),*/
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(20),
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            load = true;
                          });

                          try {
                            Dio dio = new Dio();

                            dio
                                .post(
                                    points.APIEndPoints
                                        .kApiIndividualSendMoneyToUserOrMerchantCreateEndPoint,
                                    data: {
                                      "action": "VERIFYOTP",
                                      "sender_name": widget.map["data"]
                                          ["inputs"]["sender_name"],
                                      "sender_phone": widget.map["data"]
                                              ["inputs"]["sender_phone"]
                                          .toString(),
                                      "sender_id": widget.map["data"]["inputs"]
                                              ["sender_id"]
                                          .toString(),
                                      "sender_user_category": widget.map["data"]
                                              ["inputs"]["sender_user_category"]
                                          .toString(),
                                      "receiver_phone": widget.map["data"]
                                              ["inputs"]["receiver_phone"]
                                          .toString(),
                                      "amount": widget.map["data"]["inputs"]
                                              ["amount"]
                                          .toString(),
                                      "currency_id": widget.map["data"]
                                              ["inputs"]["currency_id"]
                                          .toString(),
                                      "description": widget.map["data"]
                                          ["inputs"]["description"],
                                      "send_type": widget.map["data"]["inputs"]
                                              ["send_type"]
                                          .toString(),
                                      "user_type": widget.map["data"]["inputs"]
                                              ["user_type"]
                                          .toString(),
                                      "receiver_email": widget.map["data"]
                                          ["inputs"]["receiver_email"],
                                      "request_money_id": widget.map["data"]
                                              ["inputs"]["request_money_id"]
                                          .toString(),
                                      "otp_code": smsController2.text,
                                    },
                                    options: Options(headers: {
                                      "Authorization": userToken,
                                      "Accept": "application/json",
                                    }))
                                .then((value) {
                              // print(value.data.toString());
                              //  Map mapp=json.decode(value.data.toString());
                              print("========desc is here========");
                              print(value.data['description'].toString());
                              Flushbar(
                                title: "Response",
                                message: value.data['description'].toString(),
                                duration: Duration(seconds: 2),
                              )..show(context);

                              setState(() {
                                load = false;
                              });
                              // Timer(Duration(seconds: 3), () {
                              //   Navigator.pop(context);
                              // });
                            });
                          } catch (e) {
                            Flushbar(
                              title: "Fail",
                              message: "Invalid or expired otp !!!!",
                              duration: Duration(seconds: 3),
                            )..show(context);
                          }
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
                /*LoadingWidget(
                  isVisible: showLoad,
                )*/
              ],
            ),
          ),
        ),
        load
            ? SpinKitChasingDots(
                color: Colors.blue,
                size: 100,
              )
            : Container()
      ],
    );
  }
}