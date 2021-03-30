import 'dart:async';
import 'dart:convert';
import 'package:fluttersipay/corporate/global_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:fluttersipay/deposit/json_models/deposit_success_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import 'package:fluttersipay/utils/api_endpoints.dart' as  points;
import 'package:fluttersipay/corporate/global_data.dart' as global;

class DepositSuccessScreen extends StatefulWidget {
  final DepositSuccessModel successModel;
  DepositSuccessScreen(this.successModel);
  @override
  _DepositSuccessScreenState createState() => _DepositSuccessScreenState();
}

class _DepositSuccessScreenState extends State<DepositSuccessScreen> {
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

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
    return new FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/json/deposit/6.2.1Deposit_succes.json'),
        builder: (context, snapshot) {
          var parsedJson;
          if (snapshot.hasData) {
            parsedJson = json.decode(snapshot.data.toString());
            //    users = success_json.fromJson(parsedJson);
            print(widget.successModel.siPayBankName);
            return Scaffold(
              key: _key,
              appBar: AppBar(
                centerTitle: true,
                title: Text(translator.translate("deposit").toUpperCase()),
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
                      // do something
                    },
                  )
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(50),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: ScreenUtil.getInstance().setHeight(200),
                            ),
                          ),
                          height: ScreenUtil.getInstance().setHeight(200),
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(20),
                        ),
                        Container(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              //////////////////////////////////////////////////////
                              ///////////////////////////////////////////////////////
                              translator.translate(
                                  widget.successModel.status.toLowerCase()),
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(10),
                        ),
                        Container(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              ///////////////////////////////////////////
                              /////////////////////////////////////////
                              widget.successModel.message,
                              style: TextStyle(
                                  color: Colors.black45, fontSize: 15),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(100),
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 30,
                            ),
                            Icon(
                              Icons.person,
                              color: Colors.black45,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(widget.successModel.bankName),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          color: Colors.black38,
                          height: 1.0,
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(40),
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 30,
                            ),
                            Icon(
                              Icons.person,
                              color: Colors.black45,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(translator.translate(
                                  widget.successModel.siPayBankName)),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          color: Colors.black38,
                          height: 1.0,
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(40),
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 30,
                            ),
                            Icon(
                              FontAwesomeIcons.hashtag,
                              color: Colors.black45,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                  translator.translate("iban").toUpperCase() +
                                      ': ' +
                                      widget.successModel.iban),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          color: Colors.black38,
                          height: 1.0,
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(40),
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 30,
                            ),
                            Icon(
                              FontAwesomeIcons.hashtag,
                              color: Colors.black45,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                  translator.translate("pnr").toUpperCase() +
                                      ': ' +
                                      widget.successModel.pnr),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          color: Colors.black38,
                          height: 1.0,
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(40),
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 30,
                            ),
                            Icon(
                              FontAwesomeIcons.moneyBillWaveAlt,
                              color: Colors.black45,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                  translator.translate("amount").toUpperCase() +
                                      ': ' +
                                      widget.successModel.amount +
                                      widget.successModel.currencyText),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          color: Colors.black38,
                          height: 1.0,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              /* Expanded(
                                child: Column(
                                  children: <Widget>[
                                   /*  IconButton(
                                      icon: const Icon(
                                        Icons.email,
                                        color: Colors.blue,
                                        size: 20,
                                      ),
                                      onPressed: () {},
                                    ), */
                                /*     Text(
                                      users.footerTab[0],
                                      style: TextStyle(
                                          fontSize: 8, color: Colors.black45),
                                    ), */
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                         /*            IconButton(
                                      icon: const Icon(
                                        Icons.sms,
                                        color: Colors.blue,
                                        size: 20,
                                      ),
                                      onPressed: () {},
                                    ), */
                              /*       Text(
                                      users.footerTab[1],
                                      style: TextStyle(
                                          fontSize: 8, color: Colors.black45),
                                    ), */
                                  ],
                                ),
                              ), */
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    IconButton(
                                      icon: const Icon(
                                        FontAwesomeIcons.whatsapp,
                                        color: Colors.blue,
                                        size: 20,
                                      ),
                                      onPressed: () {
// Whats app

                                        FlutterShareMe()
                                            .shareToWhatsApp(
                                                msg: widget
                                                        .successModel.bankName +
                                                    "\n " +
                                                    widget.successModel
                                                        .siPayBankName +
                                                    "\n " +
                                                    " IBAN:" +
                                                    widget.successModel.iban +
                                                    "\n" +
                                                    " PNR:" +
                                                    widget.successModel.pnr +
                                                    "\n " +
                                                    widget.successModel.amount +
                                                    widget.successModel
                                                        .currencyText)
                                            .then((value) {
                                          if (value == "false") {
                                            _key.currentState
                                                .showSnackBar(new SnackBar(
                                              duration: Duration(seconds: 2),
                                              content: new Text(
                                                  "Sharing Failed.please make sure that you have whatsapp on your device !!"),
                                            ));
                                          } else {
                                            _key.currentState
                                                .showSnackBar(new SnackBar(
                                              duration: Duration(seconds: 2),
                                              content: new Text("Done"),
                                            ));
                                          }
                                        });
                                      },
                                    ),
                                    Text(
                                      translator
                                          .translate("whats")
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 8, color: Colors.black45),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    IconButton(
                                      icon: const Icon(
                                        Icons.content_copy,
                                        color: Colors.blue,
                                        size: 20,
                                      ),
                                      onPressed: () async {
                                        await Clipboard
                                            .setData(new ClipboardData(
                                                text: widget
                                                        .successModel.bankName +
                                                    "\n " +
                                                    widget.successModel
                                                        .siPayBankName +
                                                    "\n" +
                                                    " IBAN: " +
                                                    widget.successModel.iban +
                                                    "\n" +
                                                    "  PNR: " +
                                                    widget.successModel.pnr +
                                                    "\n " +
                                                    widget.successModel.amount +
                                                    " " +
                                                    widget.successModel
                                                        .currencyText));

                                        _key.currentState
                                            .showSnackBar(new SnackBar(
                                          duration: Duration(seconds: 2),
                                          content: new Text(translator.translate("copied")),
                                        ));
                                      },
                                    ),
                                    Text(
                                      translator
                                          .translate("copy")
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 8, color: Colors.black45),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    IconButton(
                                      icon: const Icon(
                                        Icons.cancel,
                                        color: Colors.blue,
                                        size: 20,
                                      ),
                                      onPressed: () {
print("**************************  "+widget.successModel.iD);

isIndividual?
http.get(
  points.APIEndPoints.kApiIndividualDepositDeleteEndPoint+"/"+widget.successModel.iD,
  headers: {
    "Authorization":global.userToken,
     "Accept":"application/json"

  }


).then((value) {
print("Response cancel deposit:"+value.body.toString());
  if(value.body.toString().contains(":100")){


    _key.currentState.showSnackBar(
        new SnackBar(duration: Duration(seconds: 2),content: new Text(" Canceled Successfully ..."),));
Timer(
  Duration(seconds: 2),
    (){


      Navigator.pop(context);

      Navigator.pop(context);
    }

);


  }else{




    _key.currentState.showSnackBar(
        new SnackBar(duration: Duration(seconds: 2),content: new Text(" Deposit was not Canceled  ..."),));



  }


})
    :

//Cancel For Corpo
http.get(
    points.APIEndPoints.kApiCorporateDepositDeleteEndPoint+"/"+widget.successModel.iD,
    headers: {
      "Authorization":global.userToken,
      "Accept":"application/json"

    }


).then((value) {
  print("Response :"+value.body.toString());
  if(value.body.toString().contains(":100")){


    _key.currentState.showSnackBar(
        new SnackBar(duration: Duration(seconds: 2),content: new Text(" Canceled Successfully ..."),));
    Timer(
        Duration(seconds: 2),
            (){


          Navigator.pop(context);

          Navigator.pop(context);
        }

    );


  }else{




    _key.currentState.showSnackBar(
        new SnackBar(duration: Duration(seconds: 2),content: new Text(" Deposit was not Canceled  ..."),));



  }


});


                                      },
                                    ),
                                    Text(
                                      translator
                                          .translate("cancel")
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 8, color: Colors.black45),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(50),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30.0, right: 30.0),
                          child: Container(
                            child: FlatButton(
                              onPressed: () {
                                var count = 0;

                            isIndividual==false?    Navigator.popUntil(context, (route) {
                                  return count++ == 3;
                                }): Navigator.popUntil(context, (route) {
                              return count++ == 2;
                            });
                              },
                              color: Colors.blue,
                              disabledColor: Colors.blue,
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                translator.translate("dash").toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            width: ScreenUtil.getInstance().setWidth(690),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(40),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        });
  }
}

class success_json {
  String header;
  String success;
  String yourdeposit;
  DepositData depositData;
  List<String> footerTab;
  String button;

  success_json(
      {this.header,
      this.success,
      this.yourdeposit,
      this.depositData,
      this.footerTab,
      this.button});

  success_json.fromJson(Map<String, dynamic> json) {
    header = json['header'];
    success = json['success'];
    yourdeposit = json['yourdeposit'];
    depositData = json['deposit_data'] != null
        ? new DepositData.fromJson(json['deposit_data'])
        : null;
    footerTab = json['footer_tab'].cast<String>();
    button = json['button'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['header'] = this.header;
    data['success'] = this.success;
    data['yourdeposit'] = this.yourdeposit;
    if (this.depositData != null) {
      data['deposit_data'] = this.depositData.toJson();
    }
    data['footer_tab'] = this.footerTab;
    data['button'] = this.button;
    return data;
  }
}

class DepositData {
  String bank;
  String reciever;
  String iban;
  String pNR;
  String aMOUNT;

  DepositData({this.bank, this.reciever, this.iban, this.pNR, this.aMOUNT});

  DepositData.fromJson(Map<String, dynamic> json) {
    bank = json['bank'];
    reciever = json['reciever'];
    iban = json['iban'];
    pNR = json['PNR'];
    aMOUNT = json['AMOUNT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bank'] = this.bank;
    data['reciever'] = this.reciever;
    data['iban'] = this.iban;
    data['PNR'] = this.pNR;
    data['AMOUNT'] = this.aMOUNT;
    return data;
  }
}
