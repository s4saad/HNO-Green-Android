import 'dart:convert';
import 'package:fluttersipay/dashboard/drawerMenu.dart';
import 'package:flushbar/flushbar.dart';
import 'package:fluttersipay/Exchange/exchange.dart';
import 'package:fluttersipay/Money/Send_money.dart';
import 'package:fluttersipay/Witdrawal/witdrawal.dart';
import 'package:fluttersipay/corporate/dashboard/providers/merchant_panel_dashboard_provider.dart';
import 'package:fluttersipay/corporate/global_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersipay/corporate/money/money_panel.dart';
import 'package:fluttersipay/corporate/payment/payment_link.dart';
import 'package:fluttersipay/corporate/withdrawal/create_withdrawal.dart';
import 'package:fluttersipay/dashboard/Live_support.dart';

import 'package:fluttersipay/deposit/json_models/main_deposit_ui_model.dart';
import 'package:fluttersipay/deposit/providers/deposit_panel_provider.dart';
import 'package:fluttersipay/utils/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import './create_deposit_card.dart';

import '../base_main_repo.dart';
import 'create_deposit_transfer.dart';

List<String> _listViewData;

class DepositPanelScreen extends StatefulWidget {
  final BaseMainRepository mainRepo;
  final UserTypes userType;
  final List userWallets;
  MerchantPanelProvider snapshot;

  DepositPanelScreen(this.mainRepo, this.userWallets, this.userType,
      {this.snapshot});

  @override
  _DepositPanelScreenState createState() => _DepositPanelScreenState();
}

class _DepositPanelScreenState extends State<DepositPanelScreen> {
  var _value;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
        create: (context) =>
            DepositPanelProvider(widget.mainRepo, widget.userWallets),
        child: FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/json/deposit/6.1DepositMethod.json'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //  if (_value == null) _value = users.method[0];
                _listViewData = [
                  translator.translate("deposit").toUpperCase().toString(),
                  translator.translate("moneytrans").toUpperCase().toString(),
                  translator.translate("withdraw").toUpperCase().toString(),
                  translator.translate("exchange").toUpperCase().toString()
                ];
                return Scaffold(

                    //       drawer: DrawerMenu().getDrawer,
                    appBar: AppBar(
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
                      centerTitle: true,
                      title:
                          Text(translator.translate("deposit").toUpperCase()),
                      flexibleSpace: Image(
                        image: AssetImage('assets/appbar_bg.png'),
                        height: 100,
                        fit: BoxFit.fitWidth,
                      ),
                      actions: <Widget>[
                        IconButton(
                          padding: const EdgeInsets.only(right: 20.0),
                          icon: Icon(
                            FontAwesomeIcons.commentAlt,
                            color: Colors.white,
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
                    body: Consumer<DepositPanelProvider>(
                        builder: (context, snapshot, _) {
                      return Stack(
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
                                  padding: EdgeInsets.only(left: 30, right: 30),
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
                                              double.parse(snapshot
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
                                              double.parse(snapshot
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
                                            double.parse(snapshot
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
                                      ScreenUtil.getInstance().setHeight(100),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 30.0, right: 30.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        translator
                                            .translate("deposit")
                                            .toUpperCase(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: ScreenUtil.getInstance()
                                            .setHeight(50),
                                      ),
                                      /*      Text(
                                        users.choose,
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 12),
                                      ), */
                                      isIndividual
                                          ? DropdownButtonFormField<String>(
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  FontAwesomeIcons.wallet,
                                                  color: Colors.grey,
                                                ),
                                                hintText: translator
                                                    .translate("chooseDeposit"),
                                                hintStyle:
                                                    TextStyle(fontSize: 12),
                                              ),
                                              //       hint: Text(users.choose),
                                              icon: Icon(
                                                  Icons.keyboard_arrow_down),
                                              items: [
                                                translator
                                                    .translate("bankTrans")
                                                    .toUpperCase()
                                                    .toString()
                                                //        ,translator.translate("card").toString(),
                                              ].map<DropdownMenuItem<String>>(
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
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  _value = value;
                                                });

                                                createDeposit(snapshot.mainRepo,
                                                    snapshot.userWallets);
                                              },
                                              value: _value,
                                              isExpanded: true,
                                            )
                                          : DropdownButtonFormField<String>(
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  FontAwesomeIcons.wallet,
                                                  color: Colors.grey,
                                                ),
                                                hintText: translator
                                                    .translate("chooseDeposit"),
                                                hintStyle:
                                                    TextStyle(fontSize: 12),
                                              ),
                                              //       hint: Text(users.choose),
                                              icon: Icon(
                                                  Icons.keyboard_arrow_down),
                                              items: [
                                                translator
                                                    .translate("bankTrans")
                                                    .toUpperCase()
                                                    .toString()
                                              ].map<DropdownMenuItem<String>>(
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
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  _value = value;
                                                });

                                                createDeposit(snapshot.mainRepo,
                                                    snapshot.userWallets);
                                              },
                                              value: _value,
                                              isExpanded: true,
                                            ),
                                      SizedBox(
                                        height: ScreenUtil.getInstance()
                                            .setHeight(30),
                                      ),
                                      Container(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child:
                                              Image.asset('assets/deposit.png'),
                                        ),
                                        height: ScreenUtil.getInstance()
                                            .setHeight(400),
                                      ),
                                      SizedBox(
                                        height: ScreenUtil.getInstance()
                                            .setHeight(30),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        /*  child: FlatButton(
                                          onPressed: () {

                 createDeposit(snapshot.mainRepo,
                                                snapshot.userWallets);  
                                          },
                                          child: Text(
                                            users.howto,
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ), */
                                      ),
                                      SizedBox(
                                        height: 60,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          isIndividual
                              ? Dashboardbottom(context, widget.mainRepo,
                                  widget.userWallets, widget.userType)
                              : Dashboardbottom2(context, widget.snapshot),
                        ],
                      );
                    }));
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            }));
  }

  createDeposit(repo, wallets) {
//var list = json.decode(wallets.toString());
    print(_value.toString() + "<<<>>>>" + _listViewData[1].toString());

    if (_value.toString().toUpperCase() !=
        translator.translate("card").toUpperCase()) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CreateBankTransferDepositScreen(repo, wallets),
          ));
    } else {
//print("#4#"+wallets[0]["allow_cc_deposit"].toString());

      var acceptedCurrenciesID = [];
      for (int i = 0; i < wallets.length; i++) {
        if (wallets[i]["allow_cc_deposit"] == 1)
          acceptedCurrenciesID.add(wallets[i]["currency_code"]);
      }

      if (acceptedCurrenciesID.length != 0) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Create_Card(acceptedCurrenciesID),
            ));
      } else {
        Flushbar(
          icon: Icon(
            Icons.warning,
            color: Colors.red,
            size: 25,
          ),
          margin: EdgeInsets.all(8),
          borderRadius: 0,
          message: translator.translate("creditnotallow"),
          duration: Duration(seconds: 7),
        )..show(context);
      }
    }
  }

  Widget Dashboardbottom2(
      BuildContext context, MerchantPanelProvider snapshot) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.blue,
                child: FlatButton(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.database,
                        color: Colors.white,
                        size: 15,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Withdraw',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CreateCorporateWithdrawalsPanelScreen(
                                  snapshot.corporateMainRepository,
                                  snapshot.userWallets),
                        ));
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.blue,
                child: FlatButton(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.paperPlane,
                        color: Colors.white,
                        size: 15,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        translator.translate("moneytrans"),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MoneyPanelScreen(
                              snapshot.corporateMainRepository,
                              snapshot.userWallets),
                        ));
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.blue,
                child: FlatButton(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.link,
                        color: Colors.white,
                        size: 15,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Payment Link',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Payment_Link(),
                        ));
                  },
                ),
              ),
            ),
//          Expanded(
//            flex: 1,
//            child: Container(
//              color: Colors.blue,
//              child: FlatButton(
//                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Icon(
//                      FontAwesomeIcons.creditCard,
//                      color: Colors.white,
//                      size: 15,
//                    ),
//                    SizedBox(
//                      height: 5,
//                    ),
//                    Text(
//                      'Mobile POS',
//                      style: TextStyle(color: Colors.white, fontSize: 12),
//                    ),
//                  ],
//                ),
//                onPressed: () {
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                        builder: (context) => limits_Panel(),
//                      ));
//                },
//              ),
//            ),
//          ),
          ],
        ),
        height: 60,
        width: double.infinity,
      ),
    );
  }
}

Widget Dashboardbottom(BuildContext context, BaseMainRepository baseRepo,
    var wallets, UserTypes userType) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: SizedBox(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              child: FlatButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.moneyBillWaveAlt,
                      color: Colors.blue,
                      size: 15,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      translator.translate("deposit"),
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                onPressed: () async {
/* baseRepo.depositForm().then((x){
print("111111111111111111=>"+x.data.toString());
print("222222222222222222=>"+"/////"+wallets.toString());
print("33333333333333333=>"+userType.toString());

}); */
//print("NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN");
                  /*     Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          DepositPanelScreen(baseRepo, wallets, userType)));  */
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.blue,
              child: FlatButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.paperPlane,
                      color: Colors.white,
                      size: 15,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      translator.translate("moneytrans"),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => userType == UserTypes.Individual
                              ? MoneyTransferSendScreen(baseRepo, wallets)
                              : MoneyPanelScreen(baseRepo, wallets)));
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.blue,
              child: FlatButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.database,
                      color: Colors.white,
                      size: 15,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      translator.translate("withdraw"),
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
                onPressed: () {
                  print("#####################");
                  userType == UserTypes.Individual
                      ? Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context2) =>
                                UserWithdrawalPanelScreen(baseRepo, wallets),
                          ))
                      : Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context2) =>
                                CreateCorporateWithdrawalsPanelScreen(
                                    baseRepo, wallets),
                          ));
                },
              ),
            ),
          ),
          // Expanded(
          //   flex: 1,
          //   child: Container(
          //     color: Colors.blue,
          //     child: FlatButton(
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: <Widget>[
          //           Icon(
          //             FontAwesomeIcons.exchangeAlt,
          //             color: Colors.white,
          //             size: 15,
          //           ),
          //           SizedBox(
          //             height: 5,
          //           ),
          //           Text(
          //        translator.translate("exchange"),
          //             style: TextStyle(color: Colors.white, fontSize: 12),
          //           ),
          //         ],
          //       ),
          //       onPressed: () {
          //         Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => ExchangePanelScreen(
          //                   baseRepo, wallets, UserTypes.Individual),
          //             ));
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
      height: 60,
      width: double.infinity,
    ),
  );
}
