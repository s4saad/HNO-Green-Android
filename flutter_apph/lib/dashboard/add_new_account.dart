import 'dart:convert';
import 'package:fluttersipay/deposit/json_models/bank_list_model.dart';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersipay/avaliable_banks_model.dart';
import 'package:fluttersipay/base_main_repo.dart';
import 'package:fluttersipay/dashboard/Live_support.dart';
import 'package:fluttersipay/dashboard/providers/add_bank_account_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import '../loading_widget.dart';

class AddNewBankAccountScreen extends StatefulWidget {
  final BaseMainRepository baseRepo;

  AddNewBankAccountScreen(this.baseRepo);

  @override
  _AddNewBankAccountScreenState createState() =>
      _AddNewBankAccountScreenState();
}

class _AddNewBankAccountScreenState extends State<AddNewBankAccountScreen> {
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
    final _media = MediaQuery.of(context).size;

    Future<Map<String, String>> loadJson() async {
      final jsonA = await DefaultAssetBundle.of(context)
          .loadString('assets/json/dashboard/add_new_account.json');
      return {
        'merchant': jsonA,
      };
    }

    return ChangeNotifierProvider(
        create: (context) => AddBankAccountProvider(
            widget.baseRepo,
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
            null),
        child: FutureBuilder(
            future: loadJson(),
            builder: (context, snapshot) {
       
              var parsedJson;
              var footerJson;
              if (snapshot.hasData) {
                parsedJson = json.decode(snapshot.data['merchant'].toString());
                
                return new Scaffold(

               ///   drawer:DrawerMenu().getDrawer ,

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
                    title: Text(translator.translate("addBank")),
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
                            Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Live_Support(),
                                          ));
                          // do something
                        },
                      )
                    ],
                  ),
                  body: Consumer<AddBankAccountProvider>(
                      builder: (context, snapshot, _) {
                    return Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        SingleChildScrollView(
                            child: Padding(
                          padding: EdgeInsets.only(right: 30.0, left: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(30),
                              ),
                              Text(
                                translator.translate("addBankAcc"),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                translator.translate("accName"),
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12),
                              ),
                              TextField(
                                style: TextStyle(color: Colors.black),
                                controller: snapshot.accountNameTextController,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black26, width: 0.5)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black45, width: 1.0)),
                                  prefixIcon: const Icon(
                                      FontAwesomeIcons.signature,
                                      size: 16,
                                      color: Colors.black26),
                                ),
                                obscureText: false,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                   translator.translate("bank"),
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12),
                              ),
                              snapshot.bankList != null
                                  ? DropdownButton<BankModel>(
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 16,
                                ),
                                value: snapshot
                                    .selectedBankDropDownValue,
                                items:
                                snapshot.banksDropDown,
                                onChanged:
                                    (BankModel bank) {
                                      snapshot
                                          .selectedBankDropDownValue=bank;
                                      print(snapshot.ibanController.text.toString());
                                     snapshot.ibanController.text="";//bank.iban.toString();
                                },
                                hint:
                                Text(translator.translate(
                                    "chobnk")),
                                isExpanded: true,
                              )
                                  : SizedBox(
                                      width: 0.0,
                                    ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                translator.translate("curr"),
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12),
                              ),
                              Container(
                                child: DropdownButton<String>(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.black26,
                                  ),
                                  items: snapshot.currenciesList
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Icon(
                                            Icons.map,
                                            size: 18,
                                            color: Colors.black38,
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
                                    snapshot.selectedCurrencyDropDownValue =
                                        value;
                                  },
                                  value: snapshot.selectedCurrencyDropDownValue,
                                  isExpanded: true,
                                ),
                                width: ScreenUtil.getInstance().setWidth(300),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                 translator.translate("accHolder"),
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 12),
                              ),
                              TextField(
                                style: TextStyle(color: Colors.black),
                                controller:
                                    snapshot.accountHolderNameController,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black26, width: 0.5)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black26, width: 0.5)),
                                  prefixIcon: const Icon(
                                    Icons.person,
                                    size: 16,
                                    color: Colors.black45,
                                  ),
                                ),
                                obscureText: false,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                               translator.translate("iban"),
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12),
                              ),
                              TextField(
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(24),
                                          WhitelistingTextInputFormatter.digitsOnly
                                        ],
                                style: TextStyle(color: Colors.black),
                                keyboardType: TextInputType.number,
                                controller: snapshot.ibanController,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black26, width: 0.5)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black26, width: 0.5)),

                                  prefixIcon:

                                       Icon(
                                        FontAwesomeIcons.hashtag,
                                        size: 14,
                                        color: Colors.black45,
                                      ),


                                  prefix: Text("TR "),
                                ),
                                obscureText: false,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                translator.translate("state"),
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12),
                              ),
                              Container(
                                child: DropdownButton<String>(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.black26,
                                  ),
                                  items: snapshot.activeList
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Icon(
                                            Icons.map,
                                            color: Colors.black38,
                                            size: 18,
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
                                    snapshot.selectedActiveDropDownValue =
                                        value;
                                  },
                                  value: snapshot.selectedActiveDropDownValue,
                                  isExpanded: true,
                                ),
                                width: ScreenUtil.getInstance().setWidth(300),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Visibility(
                                visible: snapshot.addBankErrorText != null,
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      snapshot.addBankErrorText ?? '',
                                      style: TextStyle(
                                          color: Colors.red[800], fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: ScreenUtil.getInstance()
                                          .setHeight(30),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: FlatButton(
                                  onPressed: () {
                                    snapshot.addNewBankAccount(() {
                                      Navigator.of(context).pop();
                                      Flushbar(
                                        title:    translator.translate("success"),
                                        message:
                                              translator.translate("addedbank"),
                                        duration: Duration(seconds: 3),
                                      )..show(context);
                                    }, (description) {
                                      Flushbar(
                                        title:   translator.translate("fail"),
                                        message: description,
                                        duration: Duration(seconds: 3),
                                      )..show(context);
                                    });
                                  },
                                  color: Colors.blue,
                                  disabledColor: Colors.blue,
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                     translator.translate("save"),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                width: ScreenUtil.getInstance().setWidth(690),
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        )),
                        LoadingWidget(
                          isVisible: snapshot.showLoad ?? false,
                        )
                      ],
                    );
                  }),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            }));
  }
}

class addaccount_json {
  String header;
  String add;
  String account;
  String bank;
  List<String> bankList;
  String currency;
  List<String> currencyList;
  String accountHolder;
  String iban;
  String status;
  List<String> statusList;
  String button;

  addaccount_json(
      {this.header,
      this.add,
      this.account,
      this.bank,
      this.bankList,
      this.currency,
      this.currencyList,
      this.accountHolder,
      this.iban,
      this.status,
      this.statusList,
      this.button});

  addaccount_json.fromJson(Map<String, dynamic> json) {
    header = json['header'];
    add = json['add'];
    account = json['account'];
    bank = json['bank'];
    bankList = json['bank_list'].cast<String>();
    currency = json['currency'];
    currencyList = json['currency_list'].cast<String>();
    accountHolder = json['account_holder'];
    iban = json['iban'];
    status = json['status'];
    statusList = json['status_list'].cast<String>();
    button = json['button'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['header'] = this.header;
    data['add'] = this.add;
    data['account'] = this.account;
    data['bank'] = this.bank;
    data['bank_list'] = this.bankList;
    data['currency'] = this.currency;
    data['currency_list'] = this.currencyList;
    data['account_holder'] = this.accountHolder;
    data['iban'] = this.iban;
    data['status'] = this.status;
    data['status_list'] = this.statusList;
    data['button'] = this.button;
    return data;
  }
}


//3-32-35-38-44-56-