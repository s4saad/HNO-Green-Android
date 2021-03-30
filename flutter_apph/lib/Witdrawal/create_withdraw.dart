import 'package:animated_dialog/animated_dialog.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttersipay/Witdrawal/json_models/withdrawal_bank_model.dart';
import 'package:fluttersipay/Witdrawal/providers/create_bank_withdrawal_provider.dart';
import 'package:fluttersipay/Witdrawal/withdrawal_otp.dart';
import 'package:fluttersipay/corporate/global_data.dart';
import 'package:fluttersipay/dashboard/Live_support.dart';
import 'package:fluttersipay/loading_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../base_main_repo.dart';

int button_set = 0;

class CreateWithdrawScreen extends StatefulWidget {
  final BaseMainRepository mainRepo;
  final List userWallets;
  final int data;

  CreateWithdrawScreen(this.mainRepo, this.userWallets, this.data);

  @override
  _CreateWithdrawScreenState createState() => _CreateWithdrawScreenState();
}

class _CreateWithdrawScreenState extends State<CreateWithdrawScreen> {
  var tryValue1;
  var tryValue2;
  var tryValue3;
  var tryValue4, snap;
  var savedAccount;
  var bankValue;

  TextEditingController bankName = TextEditingController(text: "Akban");
  bool load = false;
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1304, allowFontScaling: true)
          ..init(context);
    return ChangeNotifierProvider(
        create: (context) => CreateBankWithdrawProvider(
            widget.mainRepo,
            widget.userWallets,
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
            TextEditingController()),
        child: FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/json/Withdrawl/8.6Withdraw_request.json'),
            builder: (context, snapshot) {
              //   RequestWithdrawUiModel users;
              //  var parsedJson;
              if (snapshot.hasData) {
                //     parsedJson = json.decode(snapshot.data.toString());
                //   users = RequestWithdrawUiModel.fromJson(parsedJson);
                if (tryValue1 == null &&
                    tryValue2 == null &&
                    tryValue3 == null &&
                    tryValue4 == null &&
                    savedAccount == null &&
                    bankValue == null) {
                  tryValue1 = tryValue2 = tryValue3 = tryValue4 = "try";

                  ////////////////////////////////////////////////
                  /////////////////////////////////////////////////
                  savedAccount = "YAPIKREDI SAVINGS";
                  bankValue = "T.C.ZIRAAT BANKASI A.S.";

                  //////////////////////////////////////////////
                  ///////////////////////////////////////////////
                }
                return Stack(
                  children: <Widget>[
                    Scaffold(
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.centerFloat,
                      floatingActionButton: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          width: ScreenUtil.getInstance().setWidth(690),
                          child: FlatButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  child: AnimatedDialog(
                                    width:
                                        MediaQuery.of(context).size.width - 70,
                                    //final width of the dialog
                                    height:
                                        MediaQuery.of(context).size.width - 70,
                                    //final height of the dialog
                                    // durationTime: Duration(seconds: 1),

                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Center(
                                      child: Container(
                                          //width: 200,height: 200,
                                          child: Column(
                                        children: <Widget>[
                                          Image.asset(
                                            "assets/confirm.png",
                                          ),
                                          Text(
                                            translator.translate(
                                                    "withdrawHintDialog") +
                                                " " +
                                                snap.netAccountController.text +
                                                " " +
                                                snap.selectedCurrencyDropDownValue,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                            textScaleFactor: 1.2,
                                          ),
                                          Text(
                                            translator.translate(
                                                "withdrawHintDialog2"),
                                            textScaleFactor: 1.1,
                                            style:
                                                TextStyle(color: Colors.grey),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              FlatButton(
                                                  shape: Border.all(
                                                      width: 0.5,
                                                      color: Colors.grey),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    translator
                                                        .translate("cancel"),
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  )),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              FlatButton(
                                                  color: Colors.indigo,
                                                  onPressed: () {
                                                    setState(() {
                                                      load = true;
                                                    });
                                                    Navigator.pop(context);
                                                    snap.createWithdrawal(
                                                        (phoneNumber,
                                                            otpModel,
                                                            mainRepo,
                                                            userType) {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  WithdrawalOTPScreen(
                                                                      phoneNumber,
                                                                      otpModel,
                                                                      userType,
                                                                      mainRepo)));
                                                    }, (description) async {
                                                      // Navigator.pop(context);
                                                      /*Flushbar(
                                                        title: translator
                                                            .translate("fail"),
                                                        message: translator
                                                            .translate("faill"),
                                                        duration: Duration(
                                                            seconds: 5),
                                                      )..show(context);*/
                                                    });

                                                    setState(() {
                                                      load = false;
                                                    });
                                                  },
                                                  child: Text(
                                                    translator
                                                        .translate("conf"),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ))
                                            ],
                                          )
                                        ],
                                      )),
                                    ),
                                  ));
                            },
                            color: Colors.blue,
                            disabledColor: Colors.blue,
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              translator.translate("withdrawBtn"),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      appBar: AppBar(
                        centerTitle: true,
                        title: Text(translator.translate("withdraw")),
                        flexibleSpace: Image(
                          image: AssetImage('assets/appbar_bg.png'),
                          height: 100,
                          fit: BoxFit.fitWidth,
                        ),
                        leading: Builder(
                          builder: (BuildContext context) {
                            return IconButton(
                              icon: const Icon(Icons.arrow_back_ios),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                        actions: <Widget>[
                          IconButton(
                            padding: const EdgeInsets.only(right: 20.0),
                            icon: Icon(
                              FontAwesomeIcons.commentAlt,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Live_Support(),
                                  ));

                              // do something
                            },
                          )
                        ],
                      ),
                      body: Consumer<CreateBankWithdrawProvider>(
                          builder: (context, snapshot2, _) {
                        snap = snapshot2;
                        snapshot2.accountHolderController.text =
                            userName.toString() ?? "";
                        var bnkcontroller;
                        return Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(50),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 30, right: 30),
                                    child: Text(
                                      translator.translate("availableBalance"),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(50),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                            decoration: new BoxDecoration(
                                              border: Border(
                                                right: BorderSide(
                                                  color: Colors.black54,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                double.parse(snapshot2
                                                            .getAvailableWalletAmount(
                                                                0)
                                                            .toString())
                                                        .toStringAsFixed(2) +
                                                    '₺',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 16),
                                              ),
                                            )),
                                      ),
                                      Expanded(
                                        child: Container(
                                            decoration: new BoxDecoration(
                                              border: Border(
                                                right: BorderSide(
                                                  color: Colors.black54,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                double.parse(snapshot2
                                                            .getAvailableWalletAmount(
                                                                1)
                                                            .toString())
                                                        .toStringAsFixed(2) +
                                                    "\$",
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 16),
                                              ),
                                            )),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              double.parse(snapshot2
                                                          .getAvailableWalletAmount(
                                                              2)
                                                          .toString())
                                                      .toStringAsFixed(2) +
                                                  '€',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(50),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 30.0, right: 30.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          translator.translate("toBank"),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: ScreenUtil.getInstance()
                                              .setHeight(10),
                                        ),
                                        Text(
                                          translator.translate("withdrawInfo"),
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 15),
                                        ),
                                        SizedBox(
                                          height: ScreenUtil.getInstance()
                                              .setHeight(30),
                                        ),
                                        Text(
                                          translator.translate("chooseAcc"),
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 12),
                                        ),
                                        snapshot2.savedBanksDropdown != null
                                            ? DropdownButton<
                                                WithdrawalBankModel>(
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down),
                                                items: snapshot2
                                                    .savedBanksDropdown,
                                                onChanged: (value) async {
                                                  //         snapshot.selectedDropDownValue=value;

                                                  //snapshot.setSavedBankAccountDropdownValue(value);
                                                  //    snapshot.selectedBankDropDownValue.logo=value.logo;

                                                  //        snapshot.myBanks(value.name);
                                                  setState(() {
                                                    selected = true;
                                                  });
                                                  //
                                                  snapshot2.ibanController
                                                      .text = value.myiban;
                                                  snapshot2
                                                      .setSavedBankAccountDropdownValue(
                                                          value);

                                                  print(snapshot2
                                                      .savedAccountSelectedDropdownValue
                                                      .name);
                                                  print(snapshot2
                                                      .selectedBankDropDownValue
                                                      .name);
                                                },
                                                value: snapshot2
                                                    .savedAccountSelectedDropdownValue,
                                                isExpanded: true,
                                                hint: Text("Please Select"),
                                              )
                                            : snapshot2.isempty == true
                                                ? Center(
                                                    child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      TextFormField(
                                                        enabled: false,
                                                        decoration:
                                                            InputDecoration(
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10)),
                                                        controller:
                                                            TextEditingController(
                                                          text: translator
                                                              .translate(
                                                                  "savednotfound"),
                                                        ),
                                                      ),

                                                      //   Text(translator.translate("savednotfound"),)
                                                    ],
                                                  ))
                                                : Center(
                                                    child:
                                                        CupertinoActivityIndicator()),
                                        SizedBox(
                                          height: ScreenUtil.getInstance()
                                              .setHeight(30),
                                        ),
                                        Text(
                                          translator.translate("bank"),
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 12),
                                        ),
                                        snapshot2.savedBanksDropdown != null
                                            ? selected == true
                                                ? TextFormField(
                                                    enabled: false,
                                                    decoration: InputDecoration(
                                                        prefix: Container(
                                                            width: 100,
                                                            height: 30,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 10),
                                                            child: snapshot2
                                                                    .selectedBankDropDownValue
                                                                    .logo
                                                                    .contains(
                                                                        "svg")
                                                                ? WebsafeSvg.network(
                                                                    snapshot2
                                                                        .selectedBankDropDownValue
                                                                        .logo)
                                                                : Image.network(
                                                                    snapshot2
                                                                        .selectedBankDropDownValue
                                                                        .logo)),
                                                        contentPadding:
                                                            EdgeInsets.all(10)),
                                                    controller:
                                                        TextEditingController(
                                                            text: snapshot2
                                                                .selectedBankDropDownValue
                                                                .name),
                                                  )
                                                : DropdownButton<
                                                    WithdrawalBankModel>(
                                                    icon: Icon(Icons
                                                        .keyboard_arrow_down),
                                                    items:
                                                        snapshot2.banksDropdown,
                                                    onChanged: (value) async {
                                                      //         snapshot.selectedDropDownValue=value;

                                                      //    snapshot.setSavedBankAccountDropdownValue(value);
                                                      //    snapshot.selectedBankDropDownValue.logo=value.logo;

                                                      //        snapshot.myBanks(value.name);
                                                      snapshot2.ibanController
                                                          .text = value.myiban;
                                                      snapshot2
                                                          .setSavedBankAccountDropdownValue(
                                                              value);

                                                      print(snapshot2
                                                          .savedAccountSelectedDropdownValue
                                                          .name);
                                                      print(snapshot2
                                                          .selectedBankDropDownValue
                                                          .name);
                                                    },
                                                    value: snapshot2
                                                        .selectedBankDropDownValue,
                                                    isExpanded: true,
                                                  )
                                            : snapshot2.isempty == true
                                                ? Center(
                                                    child: DropdownButton<
                                                        WithdrawalBankModel>(
                                                    icon: Icon(Icons
                                                        .keyboard_arrow_down),
                                                    items:
                                                        snapshot2.banksDropdown,
                                                    onChanged: (value) async {
                                                      //         snapshot.selectedDropDownValue=value;

                                                      //    snapshot.setSavedBankAccountDropdownValue(value);
                                                      //    snapshot.selectedBankDropDownValue.logo=value.logo;

                                                      //        snapshot.myBanks(value.name);
                                                      snapshot2.ibanController
                                                          .text = value.myiban;
                                                      snapshot2
                                                          .setSavedBankAccountDropdownValue(
                                                              value);

                                                      print(snapshot2
                                                          .savedAccountSelectedDropdownValue
                                                          .name);
                                                      print(snapshot2
                                                          .selectedBankDropDownValue
                                                          .name);
                                                    },
                                                    value: snapshot2
                                                        .selectedBankDropDownValue,
                                                    isExpanded: true,
                                                  ))
                                                : Center(
                                                    child:
                                                        CupertinoActivityIndicator()),
                                        SizedBox(
                                          height: ScreenUtil.getInstance()
                                              .setHeight(30),
                                        ),
                                        SizedBox(
                                          height: ScreenUtil.getInstance()
                                              .setHeight(30),
                                        ),

                                        /*        TextFormField(
                          controller: bnkcontroller,
decoration: InputDecoration(
contentPadding: EdgeInsets.all(0),
hintText: 'Choose',
suffixIcon: Icon(Icons.keyboard_arrow_down)
),




) */

                                        Text(
                                          translator.translate("curr"),
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 12),
                                        ),
                                        Container(
                                          child: DropdownButton<String>(
                                            icon:
                                                Icon(Icons.keyboard_arrow_down),
                                            items: snapshot2.currenciesDropDown
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .moneyBillWaveAlt,
                                                      color: Colors.grey,
                                                    ),
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                      child: Text(
                                                        value,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              snapshot2
                                                  .setCurrencyDropDownValue(
                                                      value);
                                            },
                                            value: snapshot2
                                                .selectedCurrencyDropDownValue,
                                            isExpanded: true,
                                          ),
                                          width: ScreenUtil.getInstance()
                                              .setWidth(300),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              height: ScreenUtil.getInstance()
                                                  .setHeight(10),
                                            ),
                                            Text(
                                              translator.translate("accHolder"),
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 12),
                                            ),
                                            new TextFormField(
                                              style: TextStyle(
                                                  color: Colors.black),
                                              enabled: false,
                                              controller: snapshot2
                                                  .accountHolderController,
                                              decoration: InputDecoration(
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black45,
                                                            width: 1.0)),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black45,
                                                            width: 1.0)),
                                                prefixIcon: const Icon(
                                                  Icons.person,
                                                  size: 16,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return translator
                                                          .translate("error") +
                                                      translator.translate(
                                                          "accHolder");
                                                }
                                                return null;
                                              },
                                              obscureText: false,
                                            ),
                                            SizedBox(
                                              height: ScreenUtil.getInstance()
                                                  .setHeight(10),
                                            ),
                                            Text(
                                              translator.translate("iban"),
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 12),
                                            ),
                                            TextFormField(
                                              style: TextStyle(
                                                  color: Colors.black),
                                              controller:
                                                  snapshot2.ibanController,
                                              decoration: InputDecoration(
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black45,
                                                            width: 1.0)),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black45,
                                                            width: 1.0)),
                                                prefixIcon: const Icon(
                                                  FontAwesomeIcons.hashtag,
                                                  size: 16,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return translator
                                                          .translate("error") +
                                                      translator
                                                          .translate("iban")
                                                          .toLowerCase();
                                                }
                                                return null;
                                              },
                                              obscureText: false,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Visibility(
                                              visible:
                                                  snapshot2.showSwiftCode ??
                                                      false,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    translator
                                                        .translate("swift"),
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 12),
                                                  ),
                                                  TextFormField(
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                      controller: snapshot2
                                                          .swiftController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          InputDecoration(
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black45,
                                                                    width:
                                                                        1.0)),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black45,
                                                                    width:
                                                                        1.0)),
                                                        prefixIcon: const Icon(
                                                          FontAwesomeIcons
                                                              .hashtag,
                                                          size: 16,
                                                          color: Colors.black45,
                                                        ),
                                                      ),
                                                      validator: (value) => value
                                                              .isEmpty
                                                          ? translator
                                                                  .translate(
                                                                      "error") +
                                                              translator
                                                                  .translate(
                                                                      "swift")
                                                          : null),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              translator.translate("amount"),
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 12),
                                            ),
                                            Container(
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: TextFormField(
                                                      inputFormatters: <
                                                          TextInputFormatter>[
                                                        // FilteringTextInputFormatter
                                                        //   .allow(RegExp(
                                                        //     r'^\d+\.?\d{0,2}'))
                                                        WhitelistingTextInputFormatter
                                                            .digitsOnly
                                                      ],
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller: snapshot2
                                                          .amountController,
                                                      decoration:
                                                          InputDecoration(
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black45,
                                                                    width:
                                                                        1.0)),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black45,
                                                                    width:
                                                                        1.0)),
                                                        prefixIcon: const Icon(
                                                          FontAwesomeIcons
                                                              .moneyBillWaveAlt,
                                                          size: 16,
                                                          color: Colors.black45,
                                                        ),
                                                      ),
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          return translator
                                                                  .translate(
                                                                      "error") +
                                                              translator
                                                                  .translate(
                                                                      "withdraw")
                                                                  .toUpperCase() +
                                                              " " +
                                                              translator
                                                                  .translate(
                                                                      "amount")
                                                                  .toUpperCase();
                                                        }
                                                        return null;
                                                      },
                                                      obscureText: false,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Container(
                                                    decoration:
                                                        new BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                          color: Colors.black54,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                    ),
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child: DropdownButton<
                                                          String>(
                                                        icon: Icon(
                                                          Icons
                                                              .keyboard_arrow_down,
                                                          size: 16,
                                                        ),
                                                        items: snapshot2
                                                            .currencyDropDown
                                                            .map<
                                                                DropdownMenuItem<
                                                                    String>>((String
                                                                value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: <
                                                                  Widget>[
                                                                SizedBox(
                                                                    width: 10),
                                                                Expanded(
                                                                  child: Text(
                                                                    value,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black45),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged: (value) {
//                                                        setState(() {
//                                                          _try_value_2 = value;
//                                                        });
                                                        },
                                                        value: snapshot2
                                                            .currencyDropDown[0],
                                                        isExpanded: true,
                                                      ),
                                                    ),
                                                    width: 100,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              translator.translate("TransFee"),
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 12),
                                            ),
                                            Container(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: TextFormField(
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      enabled: false,
                                                      controller: snapshot2
                                                          .feeController,
                                                      decoration:
                                                          InputDecoration(
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black45,
                                                                    width:
                                                                        1.0)),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black45,
                                                                    width:
                                                                        1.0)),
                                                        prefixIcon: const Icon(
                                                          Icons.save,
                                                          size: 16,
                                                          color: Colors.black45,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Container(
                                                    decoration:
                                                        new BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                          color: Colors.black54,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                    ),
                                                    child:
                                                        IgnorePointer(
                                                          ignoring: true,
                                                          child: DropdownButtonHideUnderline(
                                                      child: DropdownButton<
                                                            String>(
                                                          icon: Icon(
                                                            Icons
                                                                .keyboard_arrow_down,
                                                            size: 16,
                                                          ),
                                                          items: snapshot2
                                                              .currencyDropDown
                                                              .map<
                                                                  DropdownMenuItem<
                                                                      String>>((String
                                                                  value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: <
                                                                    Widget>[
                                                                  SizedBox(
                                                                      width: 10),
                                                                  Expanded(
                                                                    child: Text(
                                                                      value,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black45),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          }).toList(),
                                                          onChanged: (value) {
//                                                        setState(() {
//                                                          _try_value_3 = value;
//                                                        });
                                                          },
                                                          value: snapshot2
                                                              .currencyDropDown[0],
                                                          isExpanded: true,
                                                      ),
                                                    ),
                                                        ),
                                                    width: 100,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              translator.translate("newAmt"),
                                              // users.withdrawField[7],
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 12),
                                            ),
                                            Container(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: TextFormField(
                                                      inputFormatters: <
                                                          TextInputFormatter>[
                                                        WhitelistingTextInputFormatter
                                                            .digitsOnly
                                                      ],
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller: snapshot2
                                                          .netAccountController,
                                                      enabled: false,
                                                      decoration:
                                                          InputDecoration(
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black45,
                                                                    width:
                                                                        1.0)),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black45,
                                                                    width:
                                                                        1.0)),
                                                        prefixIcon: const Icon(
                                                          FontAwesomeIcons
                                                              .database,
                                                          size: 16,
                                                          color: Colors.black45,
                                                        ),
                                                      ),
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          return translator
                                                              .translate(
                                                                  "withdrawAmount");
                                                        }
                                                        return null;
                                                      },
                                                      obscureText: false,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Container(
                                                    decoration:
                                                        new BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                          color: Colors.black54,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                    ),
                                                    child:
                                                        IgnorePointer(
                                                          ignoring: true,
                                                          child: DropdownButtonHideUnderline(
                                                      child: DropdownButton<
                                                            String>(
                                                          icon: Icon(
                                                            Icons
                                                                .keyboard_arrow_down,
                                                            size: 16,
                                                          ),
                                                          items: snapshot2
                                                              .currencyDropDown
                                                              .map<
                                                                  DropdownMenuItem<
                                                                      String>>((String
                                                                  value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: <
                                                                    Widget>[
                                                                  SizedBox(
                                                                      width: 10),
                                                                  Expanded(
                                                                    child: Text(
                                                                      value,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black45),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          }).toList(),
                                                          onChanged: (value) {
//                                                        setState(() {
//                                                          _try_value_4 = value;
//                                                        });
                                                          },
                                                          value: snapshot2
                                                              .currencyDropDown[0],
                                                          isExpanded: true,
                                                      ),
                                                    ),
                                                        ),
                                                    width: 100,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: ScreenUtil.getInstance()
                                                  .setHeight(10),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            width: double.infinity,
                                            child: Align(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Checkbox(
                                                    value: snapshot2.checkbox,
                                                    onChanged: (bool value) {
                                                      snapshot2
                                                          .setCheckBox(value);
                                                    },
                                                  ),
                                                  Container(
                                                    child: Text(translator
                                                        .translate("save")),
                                                  )
                                                ],
                                              ),
                                              alignment: Alignment.centerRight,
                                            )),
                                        Visibility(
                                          visible:
                                              snapshot2.withdrawalErrorText !=
                                                  null,
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                snapshot2.withdrawalErrorText ??
                                                    '',
                                                style: TextStyle(
                                                    color: Colors.red[800],
                                                    fontSize: 14),
                                              ),
                                              SizedBox(
                                                height: ScreenUtil.getInstance()
                                                    .setHeight(30),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: ScreenUtil.getInstance()
                                              .setWidth(690),
                                        ),
                                        SizedBox(
                                          height: ScreenUtil.getInstance()
                                              .setHeight(170),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            LoadingWidget(
                              isVisible: snapshot2.showLoad ?? false,
                            )
                          ],
                        );
                      }),
                    ),
                    load
                        ? Center(
                            child: SpinKitChasingDots(
                              size: 120,
                              color: Colors.blue,
                            ),
                          )
                        : Container()
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            }));
  }
}
