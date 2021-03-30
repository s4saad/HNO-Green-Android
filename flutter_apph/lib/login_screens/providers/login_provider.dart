import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:fluttersipay/login_screens/login_repo.dart';
import 'package:fluttersipay/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main_api_data_model.dart';
import 'package:ola_like_country_picker/ola_like_country_picker.dart' as ola;
import 'package:fluttersipay/corporate/global_data.dart' as gd;
class LoginProvider with ChangeNotifier {
  LoginRepository _loginRepo;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _telephoneController;
  bool _showLoad = false;
  bool _showIndividualLoginErrorMessage = false;
  bool _showCorporateLoginErrorMessage = false;
  bool _rememberPassword;

  bool _customerOrCorporate = true;
  String _phoneNumberErrorText;
  String _emailAddressErrorText;
  String _passwordErrorText;
  ola.Country _country; // se
  String countrycode1;
  GlobalKey<FormState> formKey = GlobalKey();

  ola.Country get country => _country;

  set country(ola.Country value) {
    _country = value;
    notifyListeners();
  }

  TextEditingController get emailController => _emailController;

  TextEditingController get passwordController => _passwordController;

  TextEditingController get telephoneController => _telephoneController;

  String get phoneNumberErrorText => _phoneNumberErrorText;

  String get emailAddressErrorText => _emailAddressErrorText;

  String get passwordErrorText => _passwordErrorText;

  bool get showLoad => _showLoad;

  bool get showIndividualLoginErrorMessage => _showIndividualLoginErrorMessage;

  bool get showCorporateLoginErrorMessage => _showCorporateLoginErrorMessage;

  bool get rememberPassword => _rememberPassword;

  UserTypes get userType =>
      _customerOrCorporate ? UserTypes.Individual : UserTypes.Corporate;

  bool get customerOrCorporate => _customerOrCorporate;

  LoginProvider(
      this._loginRepo,
      this._emailController,
      this._passwordController,
      this._telephoneController,
      this._rememberPassword);

  void login(Function onOldnotverivied, Function onSuccess,
      Function onNotVerified, Function onFailure) {
    print("#################################### " +
        _customerOrCorporate.toString());
    _customerOrCorporate
        ? _loginIndividual(
            onOldnotverivied, onSuccess, onNotVerified, onFailure)
        : _loginCorporate(onSuccess, onNotVerified, onFailure);
  }

  void _loginIndividual(Function onOldnotverivied, Function onSuccess,
      Function onNotVerified, Function onFailure) async {
    print("#######LOGIN  INDIVIDUAL ######");

    if (_telephoneController.text != null) {
      if (_telephoneController.text.isNotEmpty) {
        _setIndividualLoginErrorText(false);
        _setShowLoading(true);
        print("befor main api model");
        MainApiModel individualLoginResult = await _loginRepo.individualLogin(
            "+$countrycode", '${_telephoneController.text.trim()}');
        // print("##after main api model = "+individualLoginResult.data.toString()+" state "+individualLoginResult.statusCode.toString());
        _setShowLoading(false);

        if (individualLoginResult.statusCode.toString() == "100") {
          //   var x = json.decode(individualLoginResult.data.toString());
//print(individualLoginResult.data["user"]["verified"].toString());
          if (individualLoginResult.data["user"] != null) {
            if (individualLoginResult.data["user"]["verified"] == false &&
                individualLoginResult.data["user"]["email"] == null) {
              gd.isVerified = false;
                  print("-------------------------Un verified old ");
              onOldnotverivied(individualLoginResult);
            } else {
              if(!individualLoginResult.data["user"]["verified"]){
                gd.isVerified = false;
              }
              print("##############################_____#########22");
              individualLoginResult.statusCode.toString() == '100'
                  ? onSuccess('${_telephoneController.text.trim()}')
                  : onNotVerified('${_telephoneController.text.trim()}');
            }
          } else {
            print("##############################_____Verified");
            individualLoginResult.statusCode.toString() == '100'
                ? onSuccess('${_telephoneController.text.trim()}')
                : onNotVerified('${_telephoneController.text.trim()}');
          }
        } else
          _setIndividualLoginErrorText(true);
      }
    }
  }

  initRemem() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    this._rememberPassword = prefs.getBool("remember");
    notifyListeners();
  }

  void _loginCorporate(Function onSuccess, Function onNotVerified,
      Function(String errorMsg) onFailure) async {
    print("#######LOGIN  CORPORATE ######");
    _setCorporateLoginErrorText(false);
    formKey.currentState.validate();
    if (_emailController.text != null && _passwordController.text != null) {
      if (_emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        _setCorporateLoginErrorText(false);
        _setShowLoading(true);
        MainApiModel corporateLoginResult = await _loginRepo.corporateLogin(
            _emailController.text.trim(), _passwordController.text.trim());
        _setShowLoading(false);
        // int verified = corporateLoginResult.data['user']['verified'];
        if (corporateLoginResult.statusCode == 100)
          // verified == 1
          // ? onSuccess(corporateLoginResult)
          // :
          onNotVerified(corporateLoginResult);
        else {
          _setCorporateLoginErrorText(true);
          onFailure('');
        }
      } else {
        // _setCorporateLoginErrorText(true);
      }
    }
  }

  void _setShowLoading(bool load) {
    _showLoad = load;
    notifyListeners();
  }

  void setRememberPassword(bool remember) {
    _rememberPassword = remember;
    notifyListeners();
  }

  void toggleCustomerCorporate() {
    _customerOrCorporate = !_customerOrCorporate;
    notifyListeners();
  }

  void _setIndividualLoginErrorText(bool isError) {
    _showIndividualLoginErrorMessage = isError;
    notifyListeners();
  }

  void _setCorporateLoginErrorText(bool isError) {
    _showCorporateLoginErrorMessage = isError;
    notifyListeners();
  }

  String get countrycode => countrycode1;

  set countrycode(String value) {
    countrycode1 = value;
    notifyListeners();
  }

//  void _setPhoneNumberErrorText(bool isError) {
//    isError
//        ? _phoneNumberErrorText = 'User not found. Please Register.'
//        : _phoneNumberErrorText = null;
//    notifyListeners();
//  }
//
//  void _setEmailAddressErrorText(bool isError) {
//    isError
//        ? _emailAddressErrorText =
//            'Email address is not correct. Please try again.'
//        : _emailAddressErrorText = null;
//    notifyListeners();
//  }
//
//  void _setPasswordErrorText(bool isError) {}

}
