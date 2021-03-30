import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:fluttersipay/Witdrawal/json_models/withdrawal_bank_model.dart';
import 'package:fluttersipay/avaliable_banks_model.dart';
import 'package:fluttersipay/corporate/withdrawal/json_models/corporate_withdrawal_bank_model.dart';
import 'package:fluttersipay/deposit/json_models/bank_list_model.dart';
import 'package:intl/intl.dart';
import 'package:websafe_svg/websafe_svg.dart';
class AppUtils {


  static String getTransactionableType(String type) {
    List splittedString = type.split('\\');
    if (splittedString.length >= 3) {
      return splittedString[2];
    }
    return type;
  }

  static String mapCurrencyIDToText(int currencyID) {
    switch (currencyID) {
      case 1:
        return 'TRY';
        break;
      case 2:
        return 'USD';
        break;
      case 3:
        return 'EUR';
        break;
    }
    return '';
  }

  static String mapMerchantPaymentTypeToText(int paymentTypes) {
    switch (paymentTypes) {
      case 1:
        return 'Payment by Credit Card';
        break;
      case 2:
        return 'Payment by Mobile';
        break;
      case 3:
        return 'Payment by Wallet';
        break;
    }
    return '';
  }

  static String mapTransactionTypeToMoneyFlowSign(int transactionTypeID) {
    switch (transactionTypeID) {
      case 1:
        return '-';
        break;
      case 2:
        return '+';
        break;
      case 3:
        return '-';
        break;
      case 4:
        return '-';
        break;
      case 5:
        return '+';
        break;
      default:
        return '-';
        break;
    }
  }

  static List<int> getRoundedAndCentAmountFromDouble(double amount) {
    List<int> result = List();
    List split = amount.toString().split('.');
    if (split != null) {
      if (split.isNotEmpty && split.length >= 2) {
        result.add(int.parse(split[0]));
        result.add(int.parse(split[1]));
      }
    }
    return result;
  }

  static int mapCurrencyTextToID(String currency) {
    switch (currency) {
      case 'TRY':
        return 1;
        break;
      case 'USD':
        return 2;
        break;
      case 'EUR':
        return 3;
        break;
    }
    return 1;
  }

  static String mapCurrencyIDToCurrencySign(int currencyID) {
    switch (currencyID) {
      case 1:
        return '₺';
        break;
      case 2:
        return '\$';
        break;
      case 3:
        return '€';
        break;
    }
    return '';
  }

  static String mapMoneyFlowToColorType(String flowSign) {
    switch (flowSign) {
      case '+':
        return '1';
      case '-':
        return '0';
      default:
        return '2';
    }
  }

  static replaceNullItemsToEmptyValues(var item) =>
      item == null ? 'Not Found' : item;

  static String getDateRangeBetweenTwoDates(DateTime date1, DateTime date2) =>
      '${formatTimeOfDayToYYYYMMDD(date1)} - ${formatTimeOfDayToYYYYMMDD(date2)}';

  static String formatTimeOfDayToYYYYMMDD(DateTime date) =>
      DateFormat('yyyy/MM/dd').format(date);

  static int mapTransactionStateToIndex(String state) {
    switch (state) {
      case 'Completed':
        return 1;
      case 'Rejected':
        return 2;
      case 'Pending':
        return 3;
      case 'Stand By':
        return 4;
      case 'Refunded':
        return 5;
      case 'Awaiting':
        return 6;
      case 'Failed':
        return 14;
      default:
        return 0;
    }
  }

  static double calculateFee(double amount, List commissions, int index) {
    double total =
        (((amount / 100) * commissions[index]['commission_percentage']) +
            commissions[index]['commission_amount']);
    return total;
  }

  static List<DropdownMenuItem<CorporateWithdrawalBankModel>>
      mapCorporateWithdrawalBankListToDropdownMenuItems(List banks) {
    List<DropdownMenuItem<CorporateWithdrawalBankModel>> dropdownBanks = List();
    for (CorporateWithdrawalBankModel bank in banks) {
      if(bank.logo==null)bank.logo="";
      DropdownMenuItem dropdownMenuItem =
          DropdownMenuItem<CorporateWithdrawalBankModel>(
        value: bank,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
          Container(child:  bank.logo.contains("svg")?
              WebsafeSvg.network(bank.logo??"",width: 40,height: 25)
             :  Image.network(bank.logo) 
       ,   width: 40,
      ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                bank.bankName ?? '',
              ),
            )
          ],
        ),
      );
      dropdownBanks.add(dropdownMenuItem);
    }
    return dropdownBanks;
  }

  static List<DropdownMenuItem<WithdrawalBankModel>>
      mapWithdrawalBankListToDropdownMenuItems(List banks) {
    List<DropdownMenuItem<WithdrawalBankModel>> dropdownBanks = List();
    for (WithdrawalBankModel bank in banks) {
      if(bank.logo==null)bank.logo=""; 
      DropdownMenuItem dropdownMenuItem = DropdownMenuItem<WithdrawalBankModel>(
        value: bank,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
        //    Icon(Icons.note),
          Container(child:  bank.logo.contains("svg")?
              WebsafeSvg.network(bank.logo,width: 40,height: 25)
             :  Image.network(bank.logo) 
       ,   width: 40,
          ),
       // SvgPicture.network(bank.logo.toString() )
        
            SizedBox(width: 7),
            Expanded(
              child: Text(
             bank.name ?? '',
              ),
            )
          ],
        ),
      );
      dropdownBanks.add(dropdownMenuItem);
    }
    return dropdownBanks;
  }

  static List<DropdownMenuItem<AvailableBankModel>>
      mapAvailableBankListToDropdownMenuItems(List banks) {
    List<DropdownMenuItem<AvailableBankModel>> dropdownBanks = List();
    for (AvailableBankModel bank in banks) {
      if(bank.logo==null)bank.logo="";
      DropdownMenuItem dropdownMenuItem = DropdownMenuItem<AvailableBankModel>(
        value: bank,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
          //  Icon(Icons.note),
                 Container(child: bank.logo.contains("svg")?
              WebsafeSvg.network(bank.logo??"",width: 40,height: 25)
             :  Image.network(bank.logo) 
       ,   width: 40,
          ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
        bank.name,
              ),
            )
          ],
        ),
      );
      dropdownBanks.add(dropdownMenuItem);
    }
    return dropdownBanks;
  }

  static List<DropdownMenuItem<BankModel>> mapBankListToDropdownMenuItems(
      List<BankModel> banks) {
    List<DropdownMenuItem<BankModel>> dropdownBanks = List();
    for (BankModel bank in banks) {
          if(bank.logo==null)bank.logo="";
      DropdownMenuItem dropdownMenuItem = DropdownMenuItem<BankModel>(
        value: bank,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
              Container(child: bank.logo.contains("svg")?
              WebsafeSvg.network(bank.logo??"",width: 40,height: 25)
             :  Image.network(bank.logo) 
       ,   width: 40,
          ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                bank.bankName,
              ),
            )
          ],
        ),
      );
      dropdownBanks.add(dropdownMenuItem);
    }
    return dropdownBanks;
  }
}
