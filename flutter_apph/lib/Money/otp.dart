
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:simple_timer/simple_timer.dart';
import 'package:translator/translator.dart' as translator1;
import 'package:http/http.dart'as http;
import 'package:fluttersipay/utils/api_endpoints.dart' as points;
import 'package:fluttersipay/corporate/global_data.dart' ;
import 'package:dio/dio.dart';
class otp extends StatefulWidget {
  var map;
  otp(this.map);

  @override
  _otpState createState() => _otpState(this.map);
}

class _otpState extends State<otp>  {

  _otpState(this.map);

  AnimationController _controller;

TextEditingController smsController2;
var map;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        child: Column(

          children: <Widget>[

            SizedBox(
              height: 100,

            )












            ,Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.number,
                maxLength: 6,
                controller: smsController2,
                decoration: InputDecoration(
                  errorStyle: TextStyle(

                      fontSize: 10
                  ),

                  //  errorText: errorText,//errorText,

               //   hintStyle: CustomTextStyle.formField(context),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.black12, width: 1.0)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.black12, width: 1.0)),
                  prefixIcon: const Icon(
                    Icons.message,
                    color: Colors.black38,
                  ),
                ),
              ),
            ),







            SizedBox(
              height: 50,//ScreenUtil.getInstance().setHeight(20),
            ),
            Container(
              child: FlatButton(
                onPressed: () async{


                  Dio dio=new Dio();

              dio.post(

                    points.APIEndPoints.kApiIndividualSendMoneyToUserOrMerchantCreateEndPoint,
data:

{

  "action":"VERIFYOTP",
  "sender_name":map["data"]["inputs"]["sender_name"],
  "sender_phone":map["data"]["inputs"]["sender_phone"].toString(),
  "sender_id":map["data"]["inputs"]["sender_id"].toString(),
  "sender_user_category":map["data"]["inputs"]["sender_user_category"].toString(),
  "receiver_phone":map["data"]["inputs"]["receiver_phone"].toString(),
  "amount":map["data"]["inputs"]["amount"].toString(),
  "currency_id":map["data"]["inputs"]["currency_id"].toString(),
  "description":map["data"]["inputs"]["description"],
  "send_type":map["data"]["inputs"]["send_type"].toString(),
  "user_type":map["data"]["inputs"]["user_type"].toString(),
  "receiver_email":map["data"]["inputs"]["receiver_email"],
  "request_money_id":map["data"]["inputs"]["request_money_id"].toString(),
  "otp_code":"682172",





},
                options: Options(headers:
                {


                  "Authorization":userToken,
                  "Accept":"application/json",


                }


                )
                  ).then((value) => print(value.data.toString()));






         /*

                  http.post(
                      points.APIEndPoints.kApiIndividualSendMoneyToUserOrMerchantCreateEndPoint,
                      headers: {

                        "Authorization":userToken,
                        "Accept":"application/json",

                      },
                      body:{

                        "action":"VERIFYOTP",
                        "sender_name":map["data"]["inputs"]["sender_name"],
                        "sender_phone":map["data"]["inputs"]["sender_phone"].toString(),
                        "sender_id":map["data"]["inputs"]["sender_id"].toString(),
                        "sender_user_category":map["data"]["inputs"]["sender_user_category"].toString(),
                        "receiver_phone":map["data"]["inputs"]["receiver_phone"].toString(),
                        "amount":map["data"]["inputs"]["amount"].toString(),
                        "currency_id":map["data"]["inputs"]["currency_id"].toString(),
                        "description":map["data"]["inputs"]["description"],
                        "send_type":map["data"]["inputs"]["send_type"].toString(),
                        "user_type":map["data"]["inputs"]["user_type"].toString(),
                        "receiver_email":map["data"]["inputs"]["receiver_email"],
                        "request_money_id":map["data"]["inputs"]["request_money_id"].toString(),
                        "otp_code":"335143",





                      }


                  ).then((val){



                    print("OTP Response "+val.body.toString());


                  });*/






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
              width:300, //ScreenUtil.getInstance().setWidth(690),
            )
          ],


        ),


      ),
    );
  }
}
