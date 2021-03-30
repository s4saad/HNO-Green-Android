import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttersipay/deposit/json_models/bank_list_model.dart';
import 'package:fluttersipay/main_api_data_model.dart';
import 'package:fluttersipay/utils/app_utils.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../avaliable_banks_model.dart';
import '../../base_main_repo.dart';

class AddBankAccountProvider with ChangeNotifier {
  var _bankModel;
  BaseMainRepository _baseMainRepository;
  List<BankModel> _bankList;
  TextEditingController _accountNameTextController;
  TextEditingController _accountHolderNameController;
  TextEditingController _ibanController;
  BankModel _selectedBankDropDownValue;
  List<DropdownMenuItem<BankModel>> _banksDropDown;
  var _currenciesList = ['TRY', 'USD', 'EUR'];
  String _selectedCurrencyDropDownValue = translator.translate("try");
  var _activeList = [translator.translate("act"), translator.translate("notact")];

  TextEditingController get accountNameTextController =>
      _accountNameTextController;
  String _selectedActiveDropDownValue = translator.translate("act");
  bool _showLoading = false;
  String _addBankErrorText;

  List get bankList => _bankList != null ? _bankList : List();

  List<DropdownMenuItem<BankModel>> get banksDropDown =>
      _banksDropDown;

  BankModel get selectedBankDropDownValue =>
      _selectedBankDropDownValue;

  String get selectedCurrencyDropDownValue => _selectedCurrencyDropDownValue;

  String get selectedActiveDropDownValue => _selectedActiveDropDownValue;

  String get addBankErrorText => _addBankErrorText;

  get currenciesList => _currenciesList;

  get showLoad => _showLoading;

  get activeList => _activeList;

  TextEditingController get accountHolderNameController =>
      _accountHolderNameController;

  TextEditingController get ibanController => _ibanController;

  set selectedBankDropDownValue(BankModel value) {
    _selectedBankDropDownValue = value;
    notifyListeners();
  }

  set selectedCurrencyDropDownValue(String value) {
    _selectedCurrencyDropDownValue = value;
    notifyListeners();
  }

  set selectedActiveDropDownValue(String value) {
    _selectedActiveDropDownValue = value;
    notifyListeners();
  }

  void _setAddBankErrorText(String errorText) {
    this._addBankErrorText = errorText;
    notifyListeners();
  }

  void _setShowLoading(bool load) {
    this._showLoading = load;
    notifyListeners();
  }

  AddBankAccountProvider(
      this._baseMainRepository,
      this._accountNameTextController,
      this._accountHolderNameController,
      this._ibanController,
      this._bankModel) {
    bankAccountForm();
  }

  bankAccountForm() async {
    if (_bankModel != null) {
      _accountNameTextController.text = _bankModel['account_no'];
      _accountHolderNameController.text = _bankModel['account_holder_name'];
      _ibanController.text = _bankModel['iban'];
      _selectedActiveDropDownValue =
          _bankModel['status'] == 1 ? translator.translate("act") : translator.translate("notact");
      _selectedCurrencyDropDownValue =
          AppUtils.mapCurrencyIDToText(_bankModel['currency_id']);
    }
    MainApiModel availableBanks =
        await _baseMainRepository.bankAccountSettingsForm();
    print("bank Maps : "+availableBanks.data.toString());
    if (availableBanks.statusCode == 100) {
      List bankMaps = availableBanks.data['banks'];
      _bankList = List();
      for (Map bank in bankMaps)
        _bankList.add(BankModel.fromMap(bank));
      _banksDropDown =
          AppUtils.mapBankListToDropdownMenuItems(_bankList);
      _selectedBankDropDownValue = null;

      notifyListeners();
    }
  }

  deleteBankAccount(Function onSuccess, Function onFailure) async {
    _setShowLoading(true);
    try {
      MainApiModel deleteModel =
          await _baseMainRepository.bankAccountDelete(_bankModel['id']);
      deleteModel.statusCode == 100
          ? onSuccess()
          : onFailure(deleteModel.description);
      _setShowLoading(false);
    } catch (e) {
      _setShowLoading(false);
      onFailure(translator.translate("codnotdelete"));
    }
  }

  addNewBankAccount(Function onSuccess, Function onFailure) async {
    this._addBankErrorText = null;
    notifyListeners();
    if (_accountNameTextController.text.trim().isNotEmpty &&
        _ibanController.text.trim().isNotEmpty &&
        _accountHolderNameController.text.trim().isNotEmpty) {
      _setShowLoading(true);
      MainApiModel addBankModel = await _baseMainRepository.addNewBankAccount(
          _selectedBankDropDownValue.bankName,
          _selectedBankDropDownValue.logo,
          _selectedBankDropDownValue.id.toString(),
          AppUtils.mapCurrencyTextToID(_selectedCurrencyDropDownValue),
          _ibanController.text.trim(),
          _accountHolderNameController.text.trim(),
          _accountNameTextController.text.trim(),
          '',
          _selectedActiveDropDownValue == translator.translate("active") ? '1' : '0');
      _setShowLoading(false);
      addBankModel.statusCode == 100
          ? onSuccess()
          : onFailure(addBankModel.description);
    } else {
      _setShowLoading(true);
      Future.delayed(Duration(seconds: 1));
      _setShowLoading(false);
      _setAddBankErrorText(translator.translate("depositError"));
    }
  }

  editBankAccount(Function onSuccess, Function onFailure) async {
    this._addBankErrorText = null;
    notifyListeners();
    if (_accountNameTextController.text.trim().isNotEmpty &&
        _ibanController.text.trim().isNotEmpty &&
        _accountHolderNameController.text.trim().isNotEmpty) {
      _setShowLoading(true);
      try {
        MainApiModel addBankModel = await _baseMainRepository.updateBankAccount(
            _bankModel['id'].toString(),
            _selectedBankDropDownValue.bankName,
            _selectedBankDropDownValue.logo,
            _selectedBankDropDownValue.id.toString(),
            AppUtils.mapCurrencyTextToID(_selectedCurrencyDropDownValue),
            _ibanController.text.trim(),
            _accountHolderNameController.text.trim(),
            _accountNameTextController.text.trim(),
            '',
            _selectedActiveDropDownValue == translator.translate("act") ? '1' : '0');
        _setShowLoading(false);
        print("@#@#@ "+addBankModel.data.toString());
        addBankModel.statusCode == 100
            ? onSuccess(addBankModel.description)
            : onFailure(addBankModel.description);





            
      } catch (e) {
        _setShowLoading(false);
        onFailure(translator.translate("failedtoupdate"));

        print(translator.translate("failedtoupdate"));
      }
    } else {
      _setShowLoading(true);
      Future.delayed(Duration(seconds: 1));
      _setShowLoading(false);
      _setAddBankErrorText(translator.translate("depositError"));
    }
  }
}
