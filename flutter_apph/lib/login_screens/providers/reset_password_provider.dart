import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttersipay/login_screens/login_repo.dart';
import 'package:fluttersipay/utils/validator.dart';

// import 'package:translator/translator.dart' as translator;
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../main_api_data_model.dart';

class ResetPasswordProvider with ChangeNotifier {
  LoginRepository _loginRepo;
  TextEditingController _emailController;
  bool _showLoad = false;
  String _emailErrorText = '';

  TextEditingController get emailController => _emailController;

  String get emailErrorText => _emailErrorText;

  bool get showLoad => _showLoad;

  ResetPasswordProvider(this._loginRepo, this._emailController) {
    _emailController.addListener(_emailValidator);
  }

  _emailValidator() {
    _setEmailErrorText(false, '');
    if (_emailController.text.isNotEmpty) {
      if (!Validator.checkIfEmailIsValid(_emailController.text.trim())) {
        _setEmailErrorText(true, translator.translate('emailVerify'));
      } else {
        _setEmailErrorText(false, '');
      }
    }
  }

  void _setShowLoading(bool load) {
    _showLoad = load;
    notifyListeners();
  }

  void _setEmailErrorText(bool isError, String errorMsg) {
    isError ? _emailErrorText = errorMsg : _emailErrorText = "";
    notifyListeners();
  }

  void resetPassword(
      bool isMerchant, Function onSuccess, Function onFailure) async {
    if (_emailController.text != null) {
      if (_emailController.text.isNotEmpty && _emailErrorText == '') {
        _setEmailErrorText(false, '');
        _setShowLoading(true);
        MainApiModel resetPasswordResult;
        if (isMerchant) {
          resetPasswordResult = await _loginRepo
              .resetCorporatePassword(_emailController.text.trim());
        } else {
          resetPasswordResult = await _loginRepo
              .resetIndividualPassword(_emailController.text.trim());
        }

        print(resetPasswordResult.description.toString());
        _setShowLoading(false);

        if (resetPasswordResult.statusCode == 100) {
          onSuccess(
              translator.translate(resetPasswordResult.description.toString()));
        } else {
          _setEmailErrorText(true,
              translator.translate(resetPasswordResult.description.toString()));
          onFailure();
        }

        //  translator.GoogleTranslator().translate(
        //    resetPasswordResult.description.toString(), to: 'en',from: 'tr')
        // .then((s){resetPasswordResult.description=s.toString();

        // resetPasswordResult.statusCode == 100
        //       ? onSuccess(resetPasswordResult.description)
        //       : _setEmailErrorText(true, resetPasswordResult.description);
        // }
        // );

      }
    }
  }
}
