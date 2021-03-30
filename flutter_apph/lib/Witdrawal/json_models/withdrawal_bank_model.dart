import 'package:localize_and_translate/localize_and_translate.dart';

class WithdrawalBankModel {
  int id;
  String name;
  var code;
  var symbol;
  var issuerName;
  var address;
  var country;
  var logo;
  int status;
var myiban;
  WithdrawalBankModel(this.id, this.name, this.code, this.symbol,
      this.issuerName, this.address, this.country, this.logo, this.status,{this.myiban});

  factory WithdrawalBankModel.empty() {
    return WithdrawalBankModel(
        0, translator.translate("accountNotFound"), '', '', '', '', '', '', 0);
  }

  factory WithdrawalBankModel.fromMap(Map values, bool saved) {
    return WithdrawalBankModel(
        values['id'],
        saved ? values['bank_name'] : values['name'],
        saved ? values['iban'] : values['code'],
        values['symbol'],
        values['issuer_name'],
        values['address'],
        values['country'],
        values['logo'],
        values['status'],
        myiban: values['iban']
        );
      
  }
}
