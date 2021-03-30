import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttersipay/login_screens/login_repo.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../main_api_data_model.dart';


import 'package:localize_and_translate/localize_and_translate.dart' as tr;

class KYCForceProvider with ChangeNotifier {
  LoginRepository _loginRepo;
  TextEditingController _surnameController;
  TextEditingController _tokenController;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _confirmController;
  TextEditingController _dateController;
  TextEditingController _professionController;
  TextEditingController _nameController;
  bool _showLoad = false;
  String _kycVerificationErrorMessage;
  String _passwordErrorMessage;
  String _verifyPasswordErrorMessage;
  String _tcknErrorMessage;
  String _nameErrorMessage;
  String _surnameErrorMessage;
  String _emailErrorMessage;
  String _dateOfBirthErrorMessage;

  TextEditingController get tokenController => _tokenController;

  TextEditingController get emailController => _emailController;

  TextEditingController get passwordController => _passwordController;

  TextEditingController get confirmController => _confirmController;

  TextEditingController get dateController => _dateController;

  TextEditingController get professionController => _professionController;

  TextEditingController get nameController => _nameController;

  TextEditingController get surnameController => _surnameController;

  String get passwordErrorMessage => _passwordErrorMessage;

  String get verifyPasswordErrorMessage => _verifyPasswordErrorMessage;

  String get tcknErrorMessage => _tcknErrorMessage;

  String get surnameErrorMessage => _surnameErrorMessage;

  String get emailErrorMessage => _emailErrorMessage;

  String get dateOfBirthErrorMessage => _dateOfBirthErrorMessage;

  String get nameErrorMessage => _nameErrorMessage;

  bool get showLoad => _showLoad;

  String get kycVerificationErrorMessage => _kycVerificationErrorMessage;
int x;

String question,answer,bearerToken;

  KYCForceProvider.con(
 this.x
  );

  KYCForceProvider(
      this._loginRepo,
      this._surnameController,
      this._tokenController,
      this._emailController,
      this._passwordController,
      this._confirmController,
      this._dateController,
      this._professionController,
      this._nameController);

  void _setShowLoading(bool load) {
    _showLoad = load;
    notifyListeners();
  }
//
//  testKYC(Function onSuccess) async {
//    if (_registerData != null) {
//      String token = _registerData.data['token'];
//      MainApiModel testKYC = await _loginRepo.userVerificationKYC(
//          'İpek',
//          'Alan',
//          '36067901608',
//          'test@email.com',
//          'Nop@ss1234',
//          'Nop@ss1234',
//          '1993',
//          token);
//    }
//  }


String getToken(){

return this.tokenController.text;

}

  verifyKYCUser(Function onSuccess) async {

    if (nameController.text.isNotEmpty &&
        surnameController.text.isNotEmpty &&
        tokenController.text.isNotEmpty &&
        answer.isNotEmpty&&


    //    emailController.text.isNotEmpty &&
      //  passwordController.text.isNotEmpty &&
        //confirmController.text.isNotEmpty &&
        dateController.text.isNotEmpty) {
     this._resetKYCFieldsErrorText();

      this._setShowLoading(true);

      MainApiModel userKYCResult = await _loginRepo.userVerificationKYC2(
          nameController.text.trim(),
          surnameController.text.trim(),
          tokenController.text.trim(),
          dateController.text.trim(),
          bearerToken,
          question,
          answer
      );



      print("::::::::::::>"+userKYCResult.data.toString());
      _setShowLoading(false);
      if (userKYCResult.statusCode == 100) {
        print("---------------------- Reg  SUCCESS ");
        onSuccess(userKYCResult.description);
        this._dateController.text="";
     //   this._emailController.text="";
        this._nameController.text="";
        this._tokenController.text="";
        this._professionController.text="";
        //his._passwordController.text="";
       // this._confirmController.text="";
        notifyListeners();
      }
      //Some error has happened in the kyc fields
      else {
        print("---------------------- Reg  Failed ");

        _setKYCErrorText(true, userKYCResult.description);
        if (userKYCResult.statusCode == 1) {
          Map<String, dynamic> errors = userKYCResult.data['errors'];
          List<String> listOfErrorKeys = errors.keys.toList();
          for (String key in listOfErrorKeys) {
            _setKYCFieldErrorText(key, errors[key][0]);
          }
        }
      }
    } else {
      _setShowLoading(true);
      print("---------------------- Reg  REQUired ");

      Future.delayed(Duration(seconds: 1));
      _setShowLoading(false);
      _setKYCErrorText(true, translator.translate("requiredFieldMessage"));
    }
  }

  void _setKYCFieldErrorText(String field, String errorMessage) {

    switch (field) {
      case 'password':
        _passwordErrorMessage = errorMessage;
        break;
      case 'verify_password':
        _verifyPasswordErrorMessage = errorMessage;
        break;
      case 'tckn':
        _tcknErrorMessage = errorMessage;
        break;
      case 'name':
        _nameErrorMessage = errorMessage;
        break;
      case 'surname':
        _surnameErrorMessage = errorMessage;
        break;
      case 'email':
        if(!this.emailController.text.contains("@")&!this.emailController.text.contains(".")&!this.emailController.text.contains("com")){
          _emailErrorMessage="test@test.com";
        }else{
          _emailErrorMessage = errorMessage;

        }
        break;
      case 'date_of_birth':
        _dateOfBirthErrorMessage =tr.translator.currentLanguage=="en"?

        errorMessage:"Kayit olmak için 13 yaşından büyük olmslısınız";

        break;
    }

    notifyListeners();
  }

  void _resetKYCFieldsErrorText() {
    _kycVerificationErrorMessage = null;
    _passwordErrorMessage = null;
    _verifyPasswordErrorMessage = null;
    _tcknErrorMessage = null;
    notifyListeners();
  }

  void _setKYCErrorText(bool isError, String errorMsg) {
    isError
        ? _kycVerificationErrorMessage = errorMsg
        : _kycVerificationErrorMessage = null;
    notifyListeners();
  }
}
