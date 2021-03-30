import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersipay/Money/Send_individual.dart';
import 'package:fluttersipay/Money/providers/send_to_corporate_provider.dart';
import 'package:fluttersipay/dashboard/Live_support.dart';
import 'package:fluttersipay/loading_widget.dart';
import 'package:fluttersipay/utils/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart' as translator1;

import './providers/transfer_money_provider.dart';
class SendMoneyToCorporateScreen extends StatefulWidget {
  //final BaseMainRepository baseMainRepository;
  //final List wallets;
  //final UserTypes userType;

  @override
  _SendMoneyToCorporateScreenState createState() =>
      _SendMoneyToCorporateScreenState();
}

class _SendMoneyToCorporateScreenState
    extends State<SendMoneyToCorporateScreen> {
  final _formKey = GlobalKey<FormState>();

  var check_state=true,check_states=true;
  var _bank_value = translator.translate("merchanr");
  List<String> _listBankData = [
    translator.translate("merchanr"),
    translator.translate("individual")
  ];
  var _try_value = "TRY";
  List<String> _listtryData = ["TRY", "USD", "EUR"];

  var snap;

  String selectedCurrencyDropdownValue="TRY";

  var selectedCurrencyDropDownValue;
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
        create: (context) => TransferMoneyProvider(

          TextEditingController(),
          TextEditingController(),
          TextEditingController(),
          TextEditingController()

      ),
        child: Consumer<TransferMoneyProvider>(
            builder: (context, snapshot, _) {

              return Scaffold(
                  floatingActionButtonLocation:




                  FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      width: ScreenUtil.getInstance().setWidth(690),
                      child: FlatButton(
                        onPressed: () {





                    /*      if (_formKey.currentState.validate()) {
                            snapshot.moneyTransfer(
                                    (phoneNumber, otpModel, mainRepo, userType, b2b) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => MoneyTransferOTPScreen(
                                          phoneNumber, otpModel, userType, mainRepo, b2b)));

                                  print(phoneNumber.toString() +
                                      "//" +
                                      otpModel.toString() +
                                      "//" +
                                      userType.toString() +
                                      mainRepo.toString() +
                                      b2b.toString());
                                }, (description) {
                              translator1.GoogleTranslator()
                                  .translate(description.toString(),
                                  to: translator.currentLanguage)
                                  .then((k) {

                                Flushbar(
                                  title: translator.translate("fail"),
                                  message: k.toString(),
                                  duration: Duration(seconds: 3),
                                )..show(context);
                              });
                              print("++>>>> " + description.toString());
                            });
                          }*/
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
                          //     size: 16,
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
                  body:

                  SingleChildScrollView(
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Column(
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
                                        "220" +
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
                             "55" +
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
                                      "150" +
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
                                    translator.translate("sendmoney").toUpperCase(),
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
                                      setState(() {
                                        _bank_value = value;
                                      });

                                      if (value ==
                                          translator.translate("individual")) {
                                       /* Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SendMoneyToIndividualScreen(
                                                      widget.baseMainRepository,
                                                      widget.wallets),
                                            ));*/
                                      }
                                    },
                                    value: _bank_value,
                                    isExpanded: true,
                                  ),
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          height:
                                          ScreenUtil.getInstance().setHeight(50),
                                        ),
                                        Text(
                                          translator.translate("merchantID"),
                                          style: TextStyle(
                                              color: Colors.black54, fontSize: 12),
                                        ),
                                        TextFormField(
                                          style: TextStyle(color: Colors.black),
                                          keyboardType: TextInputType.phone,
                                          controller: snapshot.merchantId,
                                          onFieldSubmitted: (value) {
                                            //snapshot.onReceiverPhoneSubmitted(value);
                                       //   snapshot.getReceiverData();
print(">>>>>"+snapshot.merchantId.text);
                                            },

                                          decoration: InputDecoration(
                                            hintText: translator
                                                .translate("merchantIDHint"),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black45,
                                                    width: 1.0)),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black45,
                                                    width: 1.0)),
                                        /*    prefixIcon: snapshot.phoneLoading
                                                ? CupertinoActivityIndicator()
                                                : const Icon(
                                              FontAwesomeIcons.hashtag,
                                              size: 16,
                                              color: Colors.black45,
                                            ),*/
                                          ),
                                          obscureText: false,
                                        ),
                                        SizedBox(
                                          height:
                                          ScreenUtil.getInstance().setHeight(10),
                                        ),
                                        Visibility(
                                          visible:false,// snapshot.receiverData != null,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                    /*          Icon(
                                                  snapshot.receiverData ==
                                                      translator
                                                          .translate("NonsiUser")
                                                      ? FontAwesomeIcons.userSlash
                                                      : FontAwesomeIcons.userCheck,
                                                  size: 15.0,
                                                  color: snapshot.receiverData ==
                                                      translator
                                                          .translate("NonsiUser")
                                                      ? Colors.red
                                                      : Colors.blue),*/
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text(
                                         ""   /*    snapshot.receiverData ?? '',
                                                style: TextStyle(
                                                    color: snapshot.receiverData ==
                                                        translator.translate(
                                                            "NonsiUser")
                                                        ? Colors.red
                                                        : Colors.blue),*/
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
                                                              .industry,
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
                                        Text(
                                          translator.translate("amount") + ' *',
                                          style: TextStyle(
                                              color: Colors.black54, fontSize: 12),
                                        ),
                                        Container(
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Expanded(
                                                child: TextFormField(
                                                  inputFormatters: [

                                                    WhitelistingTextInputFormatter.digitsOnly
                                                  ],
                                                  style: TextStyle(
                                                      color: check_state
                                                          ? Colors.black
                                                          : Colors.red),
                                                  keyboardType: TextInputType.phone,
                                                  controller:
                                                  snapshot.amount,
                                                  onChanged: (text) {






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
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return translator
                                                          .translate("error");
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
                                                      selectedCurrencyDropdownValue =value;
                                                    },
                                                    value:selectedCurrencyDropDownValue,
                                                    isExpanded: true,
                                                  ),
                                                ),
                                                width: 100,
                                              )
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
                                          controller: snapshot.description,
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
                                              //   size: 16,
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
                                          ScreenUtil.getInstance().setHeight(130),
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
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        LoadingWidget(
                          isVisible: snapshot.showLoad ?? false,
                        )
                      ],
                    ),
                  )

              );

            }
        ));
  }
}
