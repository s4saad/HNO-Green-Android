import 'dart:ui' as ui;

//import 'package:contact_picker/contact_picker.dart';
import 'package:fluttersipay/Money/transfer_to_individual_otp.dart';
import 'package:fluttersipay/corporate/global_data.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttersipay/main_api_data_model.dart';
import 'dart:convert';
import 'package:fluttersipay/utils/api_endpoints.dart';
import 'package:dio/dio.dart';
import 'package:fluttersipay/corporate/global_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersipay/Money/Send_corp.dart';
import 'package:fluttersipay/Money/providers/send_to_individual_provider.dart';
import 'package:fluttersipay/dashboard/Live_support.dart';
import 'package:fluttersipay/loading_widget.dart';
import 'package:fluttersipay/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:ola_like_country_picker/ola_like_country_picker.dart' as ola;
import 'package:provider/provider.dart';
import 'package:translator/translator.dart' as translator1;

import '../base_main_repo.dart';
import 'money_transfer_otp.dart';

class SendMoneyToIndividualScreen extends StatefulWidget {
  final BaseMainRepository baseMainRepository;
  final List wallets;

  SendMoneyToIndividualScreen(this.baseMainRepository, this.wallets);

  @override
  _SendMoneyToIndividualScreenState createState() =>
      _SendMoneyToIndividualScreenState();
}

class _SendMoneyToIndividualScreenState
    extends State<SendMoneyToIndividualScreen> {
  bool check_state = true;
  bool check_states = true;
  List<String> _listBankData = [
    translator.translate("individual"),
    translator.translate("merchanr")
  ];
  List<String> _listtryData = ["TRY", "USD", "EUR"];

  SendMoneyToIndividualProvider snap;
  ola.CountryPicker countryPicker;
  ola.Country country; // se
  String countrycode;
  bool visibility = false, isReceiverCustomerId = false;
  String number = "";
  var musnapShot;
  String phoneSelected = "";

  var local = ui.window.locale.countryCode;

//  final ContactPicker _contactPicker = new ContactPicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (var element in ola.countryCodes) {
      if (local.toLowerCase() == element["ISO"]) {
        setState(() {
          country = ola.Country.fromJson(element);
          countrycode = country.dialCode;
        });
      }
    }
    countryPicker = ola.CountryPicker(onCountrySelected: (country) {
      print("country- " + country.code);
      setState(() {
        this.country = country as ola.Country;
        countrycode = country.dialCode;
      });
      print('========country code here==========');
      print(countrycode);
      if (number != "" && number != null) {
        print("phone>>" + number + "  code>>" + countrycode);
        if (number.length > 9 && countrycode == "90") {
          musnapShot.onReceiverPhoneSubmitted("+" + countrycode + number);
        } else if (number.length > 11) {
          musnapShot.onReceiverPhoneSubmitted("+" + countrycode + number);
        }
        if (number.length > 11) {
          visibility = true;
        } else if (number.length > 9 && countrycode == "90") {
          visibility = true;
        } else {
          visibility = false;
        }
        setState(() {});
      }
    });
    // countrycode = "1";
    print('========country code here out==========');
    print(countrycode);

//  if(widget.remem==null) widget.remem=false;
  }

//  Future<String> openContactBook() async {
//    Contact contact = await _contactPicker.selectContact();
//    if (contact != null) {
//      var phoneNumber = contact.phoneNumber.number.toString().replaceAll(new RegExp(r"\s+"), "");
//
//      setState(() {
//        phoneSelected=phoneNumber;
//      });
//      return phoneNumber;
//    }
//    return "";
//  }
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
        create: (context) => SendMoneyToIndividualProvider(
            widget.baseMainRepository,
            widget.wallets,
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
            UserTypes.Individual),
        child: Consumer<SendMoneyToIndividualProvider>(
            builder: (context, snapshot, _) {
          musnapShot = snapshot;
          return Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  width: ScreenUtil.getInstance().setWidth(690),
                  child: FlatButton(
                    onPressed: () {
                      if (snapshot.descriptionController.text.isEmpty |
                      (snapshot.receiverController.text.isEmpty && snapshot.receiverCustomerController.text.isEmpty) |
                          snapshot.amountController.text.isEmpty) {
                        String des = snapshot.descriptionController.text.isEmpty
                            ? translator.translate("desc")
                            : "";

                        String anm = snapshot.amountController.text.isEmpty
                            ? translator.translate("amount")
                            : "";

                        String rec = snapshot.receiverController.text.isEmpty
                            ? translator.translate("receiverPhone")
                            : "";

                        Flushbar(
                          title: translator.translate("fail"),
                          message: /*des+anm+rec+": "+*/ translator
                              .translate('missing'),
                          duration: Duration(seconds: 5),
                        )..show(context);
                      } else {
                        /*  if (!snapshot.receiverController.text.contains("+")) {
                              snapshot.receiverController.text =
                                  "+" + countrycode + snapshot.receiverController.text;
                              //phoneNumber= snapshot.receiverController.text;}
                            }*/

                        snapshot.countryCode = "+" + countrycode;

                        //       print(snapshot.receiverController.text+"  "+snapshot.amountController.text+"  "+snapshot.descriptionController.text);

                        print(isIndividual.toString());
                        if (isIndividual) {
                          snapshot.moneyTransfer(
                              (phoneNumber, otpModel, mainRepo, userType) {
                            print(
                                "============&&&& here check otp call &&&&============");
                            print(phoneNumber.toString() +
                                " ; " +
                                otpModel.toString() +
                                " ; " +
                                userType.toString() +
                                " ; " +
                                mainRepo.toString());

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MoneyTransferOTPScreen(
                                    phoneNumber, //phoneNumber,
                                    otpModel,
                                    userType,
                                    mainRepo,
                                    false)));
                          }, (description) async {
                            // var txt = await translator1.GoogleTranslator()
                            //     .translate(description,
                            //         to: translator.currentLanguage);
//txt.toString().replaceAll("Açıklama:", "");
                            print("======here is desc======" +
                                description.toString());
                            Flushbar(
                              title: translator.translate("fail"),
                              message: description,
                              duration: Duration(seconds: 3),
                            )..show(context);
                          });
                        } else {
                          snapshot.setShowLoad(true);
                          http.post(
                              APIEndPoints.kAPICorporateCashoutCreateEndPoint,
                              headers: {
                                "Accept": "application/json",
                                "Authorization": userToken
                              },
                              body: {
                                'cashout_type': '2',
                                'gsm_number': snapshot.countryCode +
                                    snapshot.receiverController.text,
                                'customer_number': snapshot.receiverCustomerController.text,
                                'action': "CASHOUT_CREATE",
                                'nonuser': "0",
                                "user_name": userName.toString(),
                                'amount': snapshot.amountController.text,
                                'currency': snapshot
                                    .selectedCurrencyDropDownValue
                                    .toString(),
                                'description':
                                    snapshot.descriptionController.text,
                              }).then((val) {
                            print(val.body.toString());
                            snapshot.setShowLoad(false);
                            var map = json.decode(val.body.toString());
                            if (map["statuscode"] == 100) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => inOtp(map)));
                            } else {
//                              map["description"].toString()
                              Flushbar(
                                title: translator.translate("fail"),
                                message: map["description"].toString(),
                                duration: Duration(seconds: 3),
                              )..show(context);
                            }
                          });

/*
print("");
  snapshot.moneyTransfer2(
          (phoneNumber, otpModel, mainRepo, userType) {
        print(phoneNumber.toString());

      /*  Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MoneyTransferOTPScreen(
                snapshot.receiverController.text, //phoneNumber,
                otpModel,
                userType,
                mainRepo,
                false)));*/
        Flushbar(
          title: translator.translate("success"),
          message: "suc ",
          duration: Duration(seconds: 5),
        )..show(context);
      }, (description) async {
    var txt = await translator1.GoogleTranslator()
        .translate(description, to: translator.currentLanguage);
//txt.toString().replaceAll("Açıklama:", "");
    print("======_" + description.toString());
    Flushbar(
      title: translator.translate("fail"),
      message: txt.toString(),
      duration: Duration(seconds: 3),
    )..show(context);
  });
*/

                        }
                      }
                    },
                    color: Colors.blue,
                    disabledColor: Colors.blue,
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      translator.translate("Sendbtn").toUpperCase(),
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
                title: Text(translator.translate("moneytrans")),
                flexibleSpace: Image(
                  image: AssetImage('assets/appbar_bg.png'),
                  height: 100,
                  fit: BoxFit.fitWidth,
                ),
                leading: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 16,
                      ),
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
                      //           size: 16,
                    ),
                    onPressed: () {
                      // do something

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Live_Support(),
                          ));
                    },
                  )
                ],
              ),
              body: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(50),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: Text(
                            translator.translate("availableBalance"),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(50),
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
                                      double.parse(snapshot
                                                  .getAvailableWalletAmount(0)
                                                  .toString())
                                              .toStringAsFixed(2) +
                                          '₺',
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 16),
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
                                      double.parse(snapshot
                                                  .getAvailableWalletAmount(1)
                                                  .toString())
                                              .toStringAsFixed(2) +
                                          "\$",
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 16),
                                    ),
                                  )),
                            ),
                            Expanded(
                              child: Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    double.parse(snapshot
                                                .getAvailableWalletAmount(2)
                                                .toString())
                                            .toStringAsFixed(2) +
                                        '€',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 16),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(80),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30.0, right: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                translator.translate("sendmoney"),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(50),
                              ),
                              Text(
                                translator.translate("chooseWallet"),
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12),
                              ),
                              DropdownButton<String>(
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 16,
                                ),
                                items: _listBankData
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.wallet,
                                          color: Colors.grey,
                                          size: 15,
                                        ),
                                        SizedBox(width: 20),
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
                                  if (value ==
                                      translator.translate("merchanr")) {
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SendMoneyToCorporateScreen(
                                                  widget.baseMainRepository,
                                                  widget.wallets,
                                                  UserTypes.Corporate),
                                        ));
                                  }
                                },
                                value: translator.translate("individual"),
                                isExpanded: true,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(50),
                                  ),
                                  /*    Text(
                                    'PHONE NO',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 12),
                                  ), */

                                  Row(
                                    children: [
                                      Expanded(
                                          child: InkWell(
                                        onTap: () {
                                          if (isReceiverCustomerId) {
                                            setState(() {
                                              snapshot.receiverCustomerController.clear();
                                              snapshot.receiverController.clear();
                                              visibility = false;
                                              snapshot.receiverData = null;
                                              isReceiverCustomerId =
                                                  !isReceiverCustomerId;
                                            });
                                          }
                                        },
                                        child: Column(
                                          //crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              child: isIndividual
                                                  ? Text(
                                                      translator.translate(
                                                          "receiverPhone"),
                                                      style: TextStyle(
                                                          color: check_state
                                                              ? Colors.black54
                                                              : Colors.red,
                                                          fontSize: 12),
                                                    )
                                                  : Text(
                                                      translator.translate(
                                                              "receiverPhone") +
                                                          " *",
                                                      style: TextStyle(
                                                          color: check_state
                                                              ? Colors.black54
                                                              : Colors.red,
                                                          fontSize: 12),
                                                    ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height:
                                                  isReceiverCustomerId ? 0 : 2,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              color: Colors.blue,
                                            )
                                          ],
                                        ),
                                      )),
                                      Expanded(
                                          child: InkWell(
                                        onTap: () {
                                          if (!isReceiverCustomerId) {
                                            snapshot.receiverCustomerController.clear();
                                            snapshot.receiverController.clear();
                                            setState(() {
                                              visibility = false;
                                              snapshot.receiverData = null;
                                              isReceiverCustomerId =
                                                  !isReceiverCustomerId;
                                            });
                                          }
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              child: Text(
                                                translator
                                                    .translate("receiverCustNo"),
                                                style: TextStyle(
                                                    color: check_state
                                                        ? Colors.black54
                                                        : Colors.red,
                                                    fontSize: 12),
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height:
                                                  isReceiverCustomerId ? 2 : 0,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              color: Colors.blue,
                                            )
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                  isReceiverCustomerId
                                      ? Container()
                                      : Row(
                                          children: <Widget>[
                                            GestureDetector(
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(top: 20),
                                                width: 70,
                                                height: 30,
                                                child: Row(
                                                  children: <Widget>[
                                                    Image.asset(
                                                      country.flagUri,
                                                      package:
                                                          'ola_like_country_picker',
                                                      width: 30,
                                                      height: 27,
                                                    ),
                                                    Expanded(
                                                        child: Text(
                                                      "+" + country.dialCode,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      overflow:
                                                          TextOverflow.fade,
                                                    ))
                                                  ],
                                                ),
                                              ),
                                              onTap: () {
                                                FocusScope.of(context)
                                                    .requestFocus(FocusNode());
                                                countryPicker.launch(context);
                                                /* if (snapshot.receiverController.text
                                                  .contains("+")) {
                                                snapshot.receiverController.text = "";
                                              }*/
                                              },
                                            ),
                                            Expanded(
                                              child: TextFormField(
                                                maxLength: countrycode == "90"
                                                    ? 11
                                                    : 13,
                                                inputFormatters: <
                                                    TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                // inputFormatters: [
                                                //   countrycode == "90"
                                                //       ? LengthLimitingTextInputFormatter(
                                                //           10)
                                                //       : LengthLimitingTextInputFormatter(
                                                //           12),
                                                // ],
//                                          inputFormatters: <TextInputFormatter>[
//                                            FilteringTextInputFormatter
//                                              .allow(RegExp(
//                                                r'^\d{8,15}'))
                                                // WhitelistingTextInputFormatter
                                                //     .digitsOnly
//                                          ],
                                                style: TextStyle(
                                                    color: Colors.black),
                                                keyboardType:
                                                    TextInputType.phone,
                                                controller:
                                                    snapshot.receiverController,
                                                onChanged: (value) {
                                                  phoneSelected = "";
                                                  number = value;
                                                  visibility = false;

                                                  if (value != "" &&
                                                      value != null &&
                                                      countrycode != "" &&
                                                      countrycode != null) {
                                                    if (value.length > 9 &&
                                                        countrycode == "90") {
                                                      print("+" +
                                                          countrycode
                                                              .toString() +
                                                          value.toString());
                                                      snapshot
                                                          .onReceiverPhoneSubmitted(
                                                              "+" +
                                                                  countrycode +
                                                                  value,
                                                              '');
                                                    } else if (value.length >
                                                        11) {
                                                      print("+" +
                                                          countrycode
                                                              .toString() +
                                                          value.toString());
                                                      snapshot
                                                          .onReceiverPhoneSubmitted(
                                                              "+" +
                                                                  countrycode +
                                                                  value,
                                                              '');
                                                    }
                                                    // if (value.length > 11) {
                                                    //   visibility = true;
                                                    // } else if (value.length > 9 && countrycode == "90") {
                                                    visibility = true;
                                                    // } else {
                                                    //   visibility = false;
                                                    // }
                                                    setState(() {});
                                                  }
                                                },
                                                onFieldSubmitted: (value) {
                                                  number = value;
                                                  visibility = true;
                                                  if (value != "" &&
                                                      value != null &&
                                                      countrycode != "" &&
                                                      countrycode != null) {
                                                    print("+" +
                                                        countrycode.toString() +
                                                        value.toString());
                                                    snapshot
                                                        .onReceiverPhoneSubmitted(
                                                            "+" +
                                                                countrycode +
                                                                value,
                                                            '');

                                                    // if (value.length == 12) {
                                                    //   visibility = true;
                                                    // } else if (value.length == 10 &&
                                                    //     countrycode == "90") {
                                                    visibility = true;
                                                    // } else {
                                                    //   visibility = false;
                                                    // }
                                                    setState(() {});
                                                  }
                                                },
                                                /*       inputFormatters: [maskFormatter], */
                                                decoration: InputDecoration(
                                                  //   labelText: "",
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black45,
                                                                  width: 1.0)),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black45,
                                                                  width: 1.0)),
                                                  prefixIcon: snapshot
                                                          .phoneLoading
                                                      ? CupertinoActivityIndicator()
                                                      : Icon(
                                                          Icons.phone,
                                                          size: 16,
                                                          color: Colors.black45,
                                                        ),
                                                ),
                                                obscureText: false,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
//                                          Contact contact = await _contactPicker.selectContact();
//                                          if (contact != null) {
//                                            var phoneNumber = contact.phoneNumber.number.toString().replaceAll(new RegExp(r"\s+"), "");
//
//                                            setState(() {
//                                              snapshot.receiverController..text=phoneNumber;
//                                            });
//
//                                            return phoneNumber;
//                                          }
//                                          return "";
                                              },
                                              child: Icon(
                                                Icons
                                                    .quick_contacts_dialer_rounded,
                                              ),
                                            ),
                                          ],
                                        ),

//                                  Container(
//                                      height:12,child: Center(child: Text(phoneSelected,style: TextStyle(fontSize: 12),))),
                                  SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(10),
                                  ),
                                  isReceiverCustomerId
                                      ? TextFormField(
                                    maxLength: 10,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          style: TextStyle(color: Colors.black),
                                          keyboardType: TextInputType.phone,
                                          controller: snapshot
                                              .receiverCustomerController,
                                          onChanged: (value) {
                                      if(value.length == 10){
                                            visibility = true;
                                              snapshot.onReceiverPhoneSubmitted(
                                                  '', value);
                                              visibility = true;
                                              setState(() {});
                                            }
                                          },
                                          onFieldSubmitted: (value) {
                                            if(value.length == 10){
                                              visibility = true;
                                                snapshot.onReceiverPhoneSubmitted(
                                                    '', value);

                                                visibility = true;
                                                setState(() {});
                                            }
                                          },
                                          decoration: InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black45,
                                                    width: 1.0)),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black45,
                                                    width: 1.0)),
                                            prefixIcon: snapshot.phoneLoading
                                                ? CupertinoActivityIndicator()
                                                : Icon(
                                                    Icons.perm_identity,
                                                    size: 16,
                                                    color: Colors.black45,
                                                  ),
                                          ),
                                          obscureText: false,
                                        )
                                      : Container(),
                                  Visibility(
                                    visible: visibility == true &&
                                        snapshot.receiverData != null,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Icon(
                                            snapshot.receiverData ==
                                                    translator
                                                        .translate("NonsiUser")
                                                ? FontAwesomeIcons.userTimes
                                                : FontAwesomeIcons.userCheck,
                                            size: 15.0,
                                            color: snapshot.receiverData ==
                                                    translator
                                                        .translate("NonsiUser")
                                                ? Colors.red
                                                : Colors.blue),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                          snapshot.receiverData ?? '',
                                          style: TextStyle(
                                              color: snapshot.receiverData ==
                                                      translator.translate(
                                                          "NonsiUser")
                                                  ? Colors.red
                                                  : Colors.blue),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(40),
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: check_states
                                          ? Container(
                                              child: Text(
                                                '',
                                                style: TextStyle(
                                                  color: Colors.black38,
                                                ),
                                              ),
                                              height: 0,
                                            )
                                          : RichText(
                                              textAlign: TextAlign.right,
                                              text: TextSpan(
                                                  // set the default style for the children TextSpans
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      wordSpacing: 3),
                                                  children: [
                                                    WidgetSpan(
                                                      child: Icon(
                                                        FontAwesomeIcons
                                                            .userCheck,
                                                        size: 14,
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                        text:
                                                            ' AIGERIM KAIROLDAYEVA',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.blue)),
                                                  ])),
                                    ),
                                  ),
                                  isIndividual
                                      ? Text(
                                          translator.translate("amount"),
                                          style: TextStyle(
                                              color: check_state
                                                  ? Colors.black54
                                                  : Colors.red,
                                              fontSize: 12),
                                        )
                                      : Text(
                                          translator.translate("amount") + " *",
                                          style: TextStyle(
                                              color: check_state
                                                  ? Colors.black54
                                                  : Colors.red,
                                              fontSize: 12),
                                        ),
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: TextFormField(
                                            maxLength: 10,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'^\d+\.?\d{0,2}'))
                                              // WhitelistingTextInputFormatter.digitsOnly
                                            ],
                                            style: TextStyle(
                                                color: check_state
                                                    ? Colors.black
                                                    : Colors.red),
                                            keyboardType: TextInputType.number,
                                            controller:
                                                snapshot.amountController,
                                            onChanged: (text) {
                                              if (text.length > 0 &&
                                                  !check_state) {
                                                setState(() {
                                                  check_state = true;
                                                });
                                              }
                                            },
                                            decoration: InputDecoration(
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black45,
                                                          width: 1.0)),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black45,
                                                          width: 1.0)),
                                              prefixIcon: check_state
                                                  ? const Icon(
                                                      FontAwesomeIcons
                                                          .moneyBillWaveAlt,
                                                      size: 16,
                                                      color: Colors.black45,
                                                    )
                                                  : const Icon(
                                                      Icons.cancel,
                                                      size: 16,
                                                      color: Colors.red,
                                                    ),
                                            ),
                                            obscureText: false,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          decoration: new BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.black54,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              icon: Icon(
                                                Icons.keyboard_arrow_down,
                                                size: 16,
                                              ),
                                              items: _listtryData.map<
                                                      DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      SizedBox(width: 10),
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
                                                snapshot.selectedCurrencyDropdownValue =
                                                    value;
                                              },
                                              value: snapshot
                                                  .selectedCurrencyDropDownValue,
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
                                  Padding(
                                    padding: EdgeInsets.only(right: 120),
                                    child: check_state
                                        ? Container(
                                            height: 0,
                                          )
                                        : Container(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              translator.translate("error") +
                                                  translator
                                                      .translate("valid") +
                                                  " " +
                                                  translator
                                                      .translate("amount")
                                                      .toLowerCase(),
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                  ),
                                  SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(20),
                                  ),
                                  Text(
                                    translator.translate("desc"),
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 12),
                                  ),
                                  TextFormField(
                                    style: TextStyle(color: Colors.black),
                                    keyboardType: TextInputType.text,
                                    controller: snapshot.descriptionController,
                                    decoration: InputDecoration(
                                      hintText:
                                          translator.translate("descHint"),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black45,
                                              width: 1.0)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black45,
                                              width: 1.0)),
                                      prefixIcon: const Icon(
                                        FontAwesomeIcons.solidCommentDots,
                                        color: Colors.black45,
                                        //  size: 16,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return translator.translate("error");
                                      }
                                      return null;
                                    },
                                    obscureText: false,
                                  ),
                                  SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(140),
                                  ),
                                  Container(
                                    width:
                                        ScreenUtil.getInstance().setWidth(690),
                                  ),
                                  SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(40),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  LoadingWidget(
                    isVisible: snapshot.showLoad ?? false,
                  )
                ],
              ));
        }));
  }
}
