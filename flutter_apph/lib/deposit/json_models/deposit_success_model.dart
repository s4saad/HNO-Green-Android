class DepositSuccessModel {
  String status;
  String message;
  String bankName;
  String siPayBankName;
  var iban;
  var pnr;
  String amount;
  var currencyText;
var iD;

DepositSuccessModel(this.status, this.message, this.bankName,
      this.siPayBankName, this.iban, this.pnr, this.amount, this.currencyText,this.iD);


}
