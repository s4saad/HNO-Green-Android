import 'package:flutter/material.dart';
import 'package:fluttersipay/corporate/global_data.dart';
import 'package:fluttersipay/main_api_data_model.dart';
import 'package:fluttersipay/utils/app_utils.dart';
import 'package:fluttersipay/utils/constants.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../base_main_repo.dart';
import 'base_money_transfer_provider.dart';

class SendMoneyToIndividualProvider extends BaseMoneyTransferProvider {
  String _receiverName;
  bool _phoneLoading;
  final UserTypes _userType;
String countryCode;

  SendMoneyToIndividualProvider(
      BaseMainRepository repo,
      List wallets,
      TextEditingController receiverController,
      TextEditingController receiverCustomerController,
      TextEditingController amountController,
      TextEditingController descriptionController,

      this._userType)
      : super(repo, wallets, receiverController,receiverCustomerController, amountController,
            descriptionController, _userType) {
    _phoneLoading = false;
  }

  String get receiverData => _receiverName;

  bool get phoneLoading => _phoneLoading;

  set receiverData(String value) {
    _receiverName = value;
    notifyListeners();
  }

  set phoneLoading(bool load) {
    _phoneLoading = load;
    notifyListeners();
  }

  onReceiverPhoneSubmitted(value,customerNumber) async {
   // receiverData = translator.translate("NonsiUser");
   // if (value != null) {
   //   if (value.toString().trim().isNotEmpty) {

        phoneLoading = true;
        receiverData = null;
        MainApiModel moneyReceiverInfo =
            await mainRepo.moneyTransferReceiverInfo(null, value,customerNumber);

        phoneLoading = false;
if(isIndividual) {
  if (moneyReceiverInfo.statusCode == 100) {
    isASiPayUser = true;
    receiverData = moneyReceiverInfo.data['receiver_info']['name'];
  }
  else {
    isASiPayUser = false;
    receiverData = translator.translate("NonsiUser");
  }

}else{

  if (moneyReceiverInfo.statusCode == 100) {
    isASiPayUser = true;
    receiverData = moneyReceiverInfo.data['receiver']['name'];
  }
  else {
    isASiPayUser = false;
    receiverData = translator.translate("NonsiUser");
  }



}

    //  }
    //}
  }

  void moneyTransfer(Function onSendToOTP, Function onFailure) async {

    if ((receiverController.text.trim().isNotEmpty || receiverCustomerController.text.trim().isNotEmpty) &&
        amountController.text.trim().isNotEmpty) {
      double amount = double.parse(amountController.text.trim());
      if (amount > 0.0) {
        if (receiverData != null) {
          if (receiverData != 'Non SiPay User') {
            showLoad = true;
            MainApiModel sendToUserModel =
                await mainRepo.createMoneySendToUserValidate(
                   receiverCustomerController.text.trim(),
                   this.countryCode+receiverController.text.trim(),
                    amountController.text.trim(),
                    AppUtils.mapCurrencyTextToID(selectedCurrencyDropDownValue),
                    descriptionController.text.trim() ?? '');
            print("MAP API MPDEL "+sendToUserModel.data.toString());
            showLoad = false;
            if (sendToUserModel != null)
              sendToUserModel.statusCode == 100
                  ? onSendToOTP(sendToUserModel.data['inputs']['sender_phone'],
                      sendToUserModel, mainRepo, UserTypes.Individual)
                  : onFailure(sendToUserModel.description);
          }
        } else
          onReceiverPhoneSubmitted(receiverController.text.trim(),receiverCustomerController.text.trim());
      }
    }
  }














  void moneyTransfer2(Function onSendToOTP, Function onFailure) async {

    if (receiverController.text.trim().isNotEmpty &&
        amountController.text.trim().isNotEmpty) {
      double amount = double.parse(amountController.text.trim());
      if (amount > 0.0) {
        if (receiverData != null) {
          if (receiverData != 'Non SiPay User') {
            showLoad = true;
            MainApiModel sendToUserModel =



            await mainRepo.createMoneySendMerchantToUserValidate(
                receiverController.text.trim(),
                amountController.text.trim(),
                AppUtils.mapCurrencyTextToID(selectedCurrencyDropDownValue),
                descriptionController.text.trim() ?? '');



            print("MAP API MPDEL "+sendToUserModel.data.toString());
            showLoad = false;
            if (sendToUserModel != null)
              sendToUserModel.statusCode == 100
                  ? onSendToOTP(sendToUserModel.data['inputs']['sender_phone'],
                  sendToUserModel, mainRepo, UserTypes.Individual)
                  : onFailure(sendToUserModel.description);
          }
        } else
          onReceiverPhoneSubmitted(receiverController.text.trim(),'');
      }
    }
  }




}
