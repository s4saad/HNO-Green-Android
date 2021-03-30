import 'package:flutter/cupertino.dart';
import 'package:fluttersipay/transactions_screen_base_provider.dart';
import 'package:dio/dio.dart';
import 'package:fluttersipay/corporate/global_data.dart' ;
import 'package:fluttersipay/utils/api_endpoints.dart'as points;
import 'package:http/http.dart' as http;
import '../../../base_main_repo.dart';

class TransferMoneyProvider with ChangeNotifier {
  TransferMoneyProvider(this.merchantId,this.description,this.amount,this.currencyId);
 TextEditingController merchantId,amount,description,currencyId;
 String receiverName;
 bool error=false;
 var showLoad;
 String errorText="",errorUser="";
  setMerchantID(String val){

    merchantId.text=val;
    notifyListeners();

  }
  setDescription(val){

    description.text=val;
    notifyListeners();
  }

 setAmount(int val){

    amount.text=val.toString();
    notifyListeners();
 }

 setCurrencyID(int val){

    currencyId.text=val.toString();

notifyListeners();
 }




 getReceiverData(){



Dio dio=new Dio();


dio.get(
points.APIEndPoints.kAPICorporateB2BPaymentReceiverEndPoint,
  options: Options(headers: {

    "Authorization":userToken,
    "Accept":"application/json"

  }
  ,
  extra: {

    "action":"check-receiver-merchant",

    "receiver_merchant_id":merchantId.text,

  }

  ),

).then((value) => print(value.toString()));


 }












  sendMoney(){


    http.post(
      points.APIEndPoints.kAPICorporateB2BPaymentEndPoint,


      headers: {

        "Authorization":userToken,
        "Accept":"application/json"

      },
      body: {

        "action":"send-otp-for-b2b",
        "merchant_id":"15808",
        "merchant_name":userName,
        "receiver_merchant_id":merchantId.text,
        "amount":amount.text,
        "currency_id":currencyId.text,
        "recevier_merchant_name":receiverName ,
        "description":description.text


      }


    ).then((value)=> print(value.toString()));


notifyListeners();
  }








}
