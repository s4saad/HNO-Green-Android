import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttersipay/corporate/dashboard/merchant_repo.dart';
import 'package:fluttersipay/main_api_data_model.dart';
import 'package:fluttersipay/utils/app_utils.dart';
import 'package:fluttersipay/utils/constants.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../base_main_repo.dart';

class TransactionsHistoryProvider with ChangeNotifier {
  BaseMainRepository _baseRepo;
  List _userTransactionsList;
  var startDate;
  var endDate;
  String _selectedCurrency;
  UserTypes _userType;
  String searchKey;
  String minAmount;
  String maxAmount;
  String selectedTransactionType;
  String _searchType;
  String selectedTransactionState;
  bool _showLoad;
  bool _initalTransactionsList;

  List userTransactionsList() {
    if (_userTransactionsList != null) {
      return _userTransactionsList;
    }
    return List();
  }

  TransactionsHistoryProvider(this._baseRepo, this._userType) {
    _initalTransactionsList = true;
    _selectedCurrency = 'CURRENCY';
    selectedTransactionType = "Purchase";
    // getDashboardDataFromApi();
    searchUserTransactionList();
  }

  void getDashboardDataFromApi() async {
    _getUserActivityList();
  }

  get selectedCurrency => _selectedCurrency;

  set selectedCurrency(String currency) {
    _selectedCurrency = currency;
    notifyListeners();
  }

  set transactionType(String value) {
    selectedTransactionType = value;
  }

  dynamic getDataFromTransactionsList(TransactionData data, int index) {
  dynamic net;
if(data == TransactionData.Value){
 net=double.parse(_userTransactionsList[index]['gross'].toString()).toStringAsFixed(2).toString();

}
  print("payment>>"+_userTransactionsList[index]['payment_type_id'].toString());
    switch (_initalTransactionsList) {
      case true:
        switch (data) {
          case TransactionData.Title:
            return _userType == UserTypes.Individual
                ? AppUtils.getTransactionableType(
                    _userTransactionsList[index]['transactionable_type'])
                : translator.translate(AppUtils.mapMerchantPaymentTypeToText(
                        _userTransactionsList[index]['payment_type_id']).toString());
            break;
          case TransactionData.ID:
            return translator.translate("transactionsList1")+': #${_userType == UserTypes.Individual ? _userTransactionsList[index]['transactionable_id'] : _userTransactionsList[index]['id']}';
            break;
          case TransactionData.Value:
            return _userType == UserTypes.Individual
           /* ${_userTransactionsList[index]['net'].toString()} */     ? '${_userTransactionsList[index]['money_flow'].toString()} ${net}  ${AppUtils.mapCurrencyIDToCurrencySign(_userTransactionsList[index]['currency_id'])}'
         /**${_userTransactionsList[index]['money_flow'].toString()??""} */       : ' ${net} ${AppUtils.mapCurrencyIDToCurrencySign(_userTransactionsList[index]['currency_id'])}';
            break;
          case TransactionData.Date:
            return _userTransactionsList[index]['created_at'].toString().substring(0,16);
            break;
          case TransactionData.Type:
            return _userType == UserTypes.Individual
                ? '${AppUtils.mapMoneyFlowToColorType(_userTransactionsList[index]['money_flow'])}'
                : '';
            break;
        }
        break;
      case false:
        switch (data) {
          case TransactionData.Title:
            return _userType == UserTypes.Individual
                ? _searchType
                : translator.translate(AppUtils.mapMerchantPaymentTypeToText(
                        _userTransactionsList[index]['payment_type_id']).toString());
            break;
          case TransactionData.ID:
            return '${_userTransactionsList[index]['id']}';
            break;
          case TransactionData.Value:
            return '${_userTransactionsList[index]['gross'].toString()} ${AppUtils.mapCurrencyIDToCurrencySign(_userTransactionsList[index]['currency_id'])}';
            break;
          case TransactionData.Date:
            return _userTransactionsList[index]['created_at'].toString().substring(0,16);
            break;
          case TransactionData.Type:
            AppUtils.mapMoneyFlowToColorType(null);
            break;
        }
    }
  }

  get showLoad => _showLoad;

  _load(bool load) {
    this._showLoad = load;
    notifyListeners();
  }

  void setSelectedTransactionType(String type) {
    selectedTransactionType = type;
    notifyListeners();
  }

  void _getUserActivityList() async {
    _load(true);
    MainApiModel userLastTransactionActivity;
    switch (_userType) {
      case UserTypes.Individual:
        userLastTransactionActivity =
            await _baseRepo.individualTransactionsListActivity('', '');
        if (userLastTransactionActivity.statusCode == 100)
          _userTransactionsList =
              userLastTransactionActivity.data['transactions']['data'];
        break;
      case UserTypes.Corporate:
        MerchantMainRepository merchantMainRepository = _baseRepo;
        userLastTransactionActivity =
            await merchantMainRepository.corporateTransactionsList(
          '',
          '',
          '',
          ''
        );
        if (userLastTransactionActivity.statusCode == 100)
          _userTransactionsList =
              userLastTransactionActivity.data['transactions'];
        break;
    }
    _load(false);
    notifyListeners();
  }

  void searchUserTransactionList() async {
    if(_userTransactionsList != null)_userTransactionsList.clear();
    String dateRange;
    if (startDate == null || endDate == null)
      dateRange = '';
    else
      dateRange = AppUtils.getDateRangeBetweenTwoDates(startDate, endDate);
    MainApiModel userLastTransactionActivity;
    _load(true);
    if (_userType == UserTypes.Individual) {
      userLastTransactionActivity =
          await _baseRepo.searchIndividualTransactionsList(
              searchKey ?? '',
              selectedTransactionState == 'STATES' ||
                      selectedTransactionState == null
                  ? ''
                  : AppUtils.mapTransactionStateToIndex(
                          selectedTransactionState)
                      .toString(),
              _selectedCurrency == 'CURRENCY' || _selectedCurrency == null
                  ? ''
                  : AppUtils.mapCurrencyTextToID(_selectedCurrency).toString(),
              selectedTransactionType == 'TYPES' ||
                      selectedTransactionType == null
                  ? ''
                  : selectedTransactionType.toLowerCase(),
              dateRange,
            minAmount ?? '',
            maxAmount ?? '');
    } else {
      MerchantMainRepository merchantMainRepository = _baseRepo;
      userLastTransactionActivity =
          await merchantMainRepository.corporateTransactionsList(
              _selectedCurrency == 'CURRENCY' || _selectedCurrency == null
                  ? ''
                  : AppUtils.mapCurrencyTextToID(_selectedCurrency).toString(),
              dateRange,
              minAmount ?? '',
              maxAmount ?? '');
    }

    _load(false);
    if (userLastTransactionActivity.statusCode == 100) {
      _userTransactionsList = _userType == UserTypes.Individual
          ? _userTransactionsList =
              userLastTransactionActivity.data['transactions']['data']
          : _userTransactionsList =
              userLastTransactionActivity.data['transactions'];
      _searchType = selectedTransactionType;
      _initalTransactionsList = false;
    }
  }
}
