//this class handles all the calls to the login API whether it's an individual or corporate.
import 'dart:convert';
import 'package:fluttersipay/corporate/global_data.dart';
import 'package:fluttersipay/base_main_repo.dart';
import 'package:fluttersipay/main_api_data_model.dart';
import 'package:fluttersipay/utils/api_endpoints.dart';
import 'package:fluttersipay/utils/network_utils.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  //Individual login API methods.

  //Individual login
  Future<MainApiModel> individualLogin(String cCode, String phone) async {
    Map<String, String> values = {'phone': cCode + phone, 'app_lang': translator.currentLanguage.toString()};
    print(values);
    String result = await NetworkHelper.makePostRequest(
        APIEndPoints.kAPIIndividualLoginEndPoint, values, null);

/*  print("xxxxxxx"+result.toString());
      var map=json.decode(result);

    userName=map["data"]["user"]["name"].toString(); */

    return MainApiModel.mapJsonToModel(result);
  }

  //Individual login next time
  Future<MainApiModel> individualLoginNextTime(
      String phone, String pass, String appLang, String token) async {
    Map<String, dynamic> values = {
      'phone': phone,
      'password': pass,
      'app_lang': appLang
    };
    print(values);
    String result = await NetworkHelper.makePostRequest(
        APIEndPoints.kAPIIndividualLoginNextTimeEndPoint, values, token);

/*  print("xxxxxxx"+result.toString());
      var map=json.decode(result);

    userName=map["data"]["user"]["name"].toString(); */
    return MainApiModel.mapJsonToModel(result);
  }

  //Individual verify SMS OTP
  Future<MainApiModel> verifyIndividualSMSOTP(String otp, String userID) async {
    Map<String, String> values = {'OTP': otp, 'user_id': userID, 'app_lang': translator.currentLanguage.toString()};
    String result = await NetworkHelper.makePostRequest(
        APIEndPoints.kApiIndividualVerifySMSEndPoint, values, null);
    //   print("login repo .dart line 23 =>>>>>> "+result);
    return MainApiModel.mapJsonToModel(result);
  }

  //Individual resend SMS OTP
  Future<MainApiModel> resendIndividualSMSOTP(String userID) async {
    Map<String, String> values = {'user_id': userID, 'app_lang': translator.currentLanguage.toString()};
    String result = await NetworkHelper.makePostRequest(
        APIEndPoints.kApiIndividualResendOTPEndPoint, values, null);
    return MainApiModel.mapJsonToModel(result);
  }

  //Individual Password login
  Future<MainApiModel> loginVerifiedIndividualWithPassword(
      String phone, String password) async {
    print("zzzzzzzzz");
    Map<String, String> values = {'phone': phone, 'password': password, 'app_lang': translator.currentLanguage.toString()};
    String result = await NetworkHelper.makePostRequest(
        APIEndPoints.kAPIIndividualLoginEndPoint, values, null);

    var map = json.decode(result);
    print("xxxxxxx" + result.toString());
    SharedPreferences prefs =
    await SharedPreferences.getInstance();
    if (map["statuscode"] == 100) {
      userName = map["data"]["user"]["name"].toString();
      prefs.setString("userName", userName);
    } else {
      userName = "";
    }

    return MainApiModel.mapJsonToModel(result);
  }

  //Individual register
  Future<MainApiModel> registerIndividual(String phoneNumber) async {
    Map<String, String> values = {'phone': phoneNumber, 'app_lang': translator.currentLanguage.toString()};
    String result = await NetworkHelper.makePostRequest(
        APIEndPoints.kApiIndividualRegisterEndPoint, values, null);
    return MainApiModel.mapJsonToModel(result);
  }

  //Individual register user verification KYC OTP
  Future<MainApiModel> smsVerifyRegisterIndividual(
      String phoneNumber, String otp) async {
    Map<String, String> values = {'phone': phoneNumber, 'OTP': otp, 'app_lang': translator.currentLanguage.toString()};
    String result = await NetworkHelper.makePostRequest(
        APIEndPoints.kApiIndividualSMSVerifyRegisterEndPoint, values, null);
    return MainApiModel.mapJsonToModel(result);
  }

  //Individual register user verification KYC OTP
  Future<String> testRegisterOTP() async {
    String result = await NetworkHelper.makeGetRequest(
        APIEndPoints.kApiIndividualOTPTestEndPoint, null);
    return result;
  }

  //Individual register user verification KYC resend OTP
  Future<MainApiModel> resendSMSVerifyRegisterIndividual(
      String phoneNumber) async {
    Map<String, String> values = {'phone': phoneNumber, 'app_lang': translator.currentLanguage.toString()};
    String result = await NetworkHelper.makePostRequest(
        APIEndPoints.kApiIndividualResendSMSVerifyRegisterEndPoint,
        values,
        null);
    return MainApiModel.mapJsonToModel(result);
  }

  //Individual reset password
  Future<MainApiModel> resetIndividualPassword(String email) async {
    Map<String, String> values = {'email': email, 'app_lang': translator.currentLanguage.toString()};
    String result = await NetworkHelper.makePostRequest(
        APIEndPoints.kApiIndividualResetPasswordEndPoint, values, null);
    return MainApiModel.mapJsonToModel(result);
  }

  //Corporate reset password
  Future<MainApiModel> resetCorporatePassword(String email) async {
    Map<String, String> values = {'email': email, 'app_lang': translator.currentLanguage.toString()};
    String result = await NetworkHelper.makePostRequest(
        APIEndPoints.kApiCorporateForgotPasswordEndPoint, values, null);
    return MainApiModel.mapJsonToModel(result);
  }

  //https://provisioning.sipay.com.tr/merchant/password/reset/357e761677ae2a88912aabe18a9db7a5a2a145af54c07af5fc3e8766e597beb3
  //Individual user verification (KYC)

  Future<MainApiModel> userVerificationKYC2(
      String name,
      String surName,
      String tckn,
      // String email,
      // String password,
      // String confirmPassword,
      String yearOfBirth,
      var bearerToken,
      String question,
      String answer) async {
    print("## " + name + surName + tckn + yearOfBirth + question + answer);

    var header = {
      "Authorization": "Bearer " + bearerToken.toString(),
      "Accept": "application/json"
    };

    Map<String, String> values = {
      'name': name,
      'surname': surName,
      'tckn': tckn,
      'date_of_birth': yearOfBirth,
      'sector': '5',
      'other_sector': null,
      'question_one': question.toString(),
      'answer_one': answer.toString(),
      /*'email': email,
      'password': password,*/
      'app_lang': translator.currentLanguage.toString(),
      // 'verify_password': confirmPassword
    };
    print(values);
    String result = await NetworkHelper.makePostRequestJsonHeaders(
        APIEndPoints.kApiIndividualUserVerificationEndPoint,
        json.encode(values),
        bearerToken);

    /* Dio dio=Dio();

 var res =await http.post(

    APIEndPoints.kApiIndividualUserVerificationEndPoint,
    headers: header,
  body: values,
  )
  ;*/

    print("=====================>>>>" + result.toString() + "");

    return MainApiModel.mapJsonToModel(result);
    print(bearerToken);
  }

  Future<MainApiModel> userVerificationKYC(
      String name,
      String surName,
      String tckn,
      // String email,
      // String password,
      // String confirmPassword,
      String yearOfBirth,
      var bearerToken,
      String question,
      String answer) async {
    Map<String, dynamic> values = {
      'name': name,
      'surname': surName,
      'tckn': tckn,
      'date_of_birth': yearOfBirth,
      'sector': '5',
      'other_sector': null,
      'question_one': question,
      'answer_one': answer,
      /*'email': email,
      'password': password,*/
      'app_lang': translator.currentLanguage.toString(),
      // 'verify_password': confirmPassword
    };
    String result = await NetworkHelper.makePostRequest(
        APIEndPoints.kApiIndividualUserVerificationEndPoint,
        values,
        bearerToken);
    return MainApiModel.mapJsonToModel(result);
  }

  //Corporate login API methods.

  //Corporate login
  Future<MainApiModel> corporateLogin(String email, String password) async {
    Map<String, String> values = {'email': email, 'password': password, 'app_lang': translator.currentLanguage.toString()};
    String result = await NetworkHelper.makePostRequest(
        APIEndPoints.kAPICorporateLoginEndPoint, values, null);
    print("COR login res=> " + result.toString());
    var map = json.decode(result);
    print(map.toString());
    if (map["statuscode"] == 100) {
      userName = map["data"]["user"]["name"].toString();
    } else {
      userName = "";
    }
    return MainApiModel.mapJsonToModel(result);
  }

  //Corporate verify SMS OTP
  Future<MainApiModel> verifyCorporateSMSOTP(String otp, String userID) async {
    Map<String, String> values = {'OTP': otp, 'user_id': userID, 'app_lang': translator.currentLanguage.toString()};
    String result = await NetworkHelper.makePostRequest(
        APIEndPoints.kApiCorporateVerifySMSEndPoint, values, null);
    return MainApiModel.mapJsonToModel(result);
  }

  //Corporate resend SMS OTP
  Future<MainApiModel> resendCorporateSMSOTP(String userID) async {
    Map<String, String> values = {'user_id': userID, 'app_lang': translator.currentLanguage.toString()};
    String result = await NetworkHelper.makePostRequest(
        APIEndPoints.kApiCorporateResendOTPEndPoint, values, null);
    return MainApiModel.mapJsonToModel(result);
  }

  //Corporate reset password
  Future<MainApiModel> changeCorporatePassword(
    String currentPassword,
    String newPassword,
    String confirmNewPassword,
  ) async {
    Map<String, String> values = {
      'current_password': currentPassword,
      'new_password': newPassword,
      'confirm_new_password': confirmNewPassword
    };
    String result = await NetworkHelper.makePostRequest(
        APIEndPoints.kApiCorporateChangePasswordEndPoint, values, null);
    return MainApiModel.mapJsonToModel(result);
  }

  //Renew password
  Future<MainApiModel> renewPassword(
      String password, String confirmPassword, String token) async {
    Map<String, String> values = {
      'new_password': password,
      'verify_password': confirmPassword
    };
    String result = await NetworkHelper.makePostRequest(
        APIEndPoints.kApiPasswordRenew, values, token);
    return MainApiModel.mapJsonToModel(result);
  }

  //Get security questions
  Future<MainApiModel> getSecurityQuestion(String token) async {
    String result = await NetworkHelper.makeGetRequest(
        APIEndPoints.kApiSecretQuestion, token);
    return MainApiModel.mapJsonToModel(result);
  }

  //Save security questions/answer
  Future<MainApiModel> setSecurityQuestion(
      String qId, String ans, String token) async {
    Map<String, String> values = {'question_one': qId, 'answer_one': ans};
    String result = await NetworkHelper.makePostRequest(
        APIEndPoints.kApiSecretQuestion, values, token);
    return MainApiModel.mapJsonToModel(result);
  }
}
