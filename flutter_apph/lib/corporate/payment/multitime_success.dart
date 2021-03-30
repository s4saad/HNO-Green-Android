import 'dart:convert';

import 'package:flutter_share_me/flutter_share_me.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersipay/corporate/dashboard/support.dart';
import 'package:fluttersipay/utils/api_endpoints.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttersipay/corporate/payment/sms_multishare.dart';
import 'package:fluttersipay/corporate/payment/email_multishare.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../global_data.dart';
import 'dpl_history.dart';
import 'package:fluttersipay/dashboard/drawerMenu.dart';
import 'package:http/http.dart' as http;
import 'package:fluttersipay/utils/api_endpoints.dart' as global;
class Multitime_Success_panel extends StatefulWidget {
  Multitime_Success_panel(this.dpl);

  Map dpl;

  @override
  _Multitime_Success_panel createState() => _Multitime_Success_panel();
}

class _Multitime_Success_panel extends State<Multitime_Success_panel> {

  GlobalKey<ScaffoldState> _key=new   GlobalKey<ScaffoldState>();
  List currencyList = new List();

  getCurrencies() {
    var response = http.get(global.APIEndPoints.createApi,
        headers: {"Authorization": userToken});

    response.then((value) {
      Map<String, dynamic> body = json.decode(value.body.toString());

      setState(() {
        currencyList = body["data"]["currencies"];
      });
    });
  }

  @override
  void initState() {
    getCurrencies();
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
    return Scaffold(

key: _key,
      body: new FutureBuilder(
          future: DefaultAssetBundle.of(context)
              .loadString('assets/json/deposit/6.2.1Deposit_succes.json'),
          builder: (context, snapshot) {
            success_json users;
            var parsedJson;
            if (snapshot.hasData) {
              parsedJson = json.decode(snapshot.data.toString());
              users = success_json.fromJson(parsedJson);
              return Scaffold(


           //     drawer:DrawerMenu().getDrawer ,
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
                  title: Text(translator.translate("sharelink")),
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
                              builder: (context) =>
                                  Live_Support(),
                            ));

                      },
                    )
                  ],
                ),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: ScreenUtil.getInstance().setHeight(40),
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
                            height: ScreenUtil.getInstance().setHeight(40),
                          ),
                          Container(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                translator.translate("success"),
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(40),
                          ),
                          Container(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                '#'+widget.dpl['id'].toString()+translator.translate("successInfo"),
                                style: TextStyle(
                                    color: Colors.black38, fontSize: 15, height: 1.7),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(70),
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 30,
                              ),
                              Container(
                                child: Text('DPL#'+widget.dpl['id'].toString()+'-'+translator.translate("multiTimeLink"),
                                    style: TextStyle(color: Colors.black45, fontSize: 14)),
                              ),
                              Expanded(
                                child: Container(
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        widget.dpl['is_amount_set_by_user']==1? translator.translate("setbyusr"):
                                        '${widget.dpl['amount'].toString()} ${currencyList != null ? currencyList[int.parse(widget.dpl['currency']) - 1]['code'] : ''}',
                                        style: TextStyle(color: Colors.black, fontSize: 15),
                                      ),
                                    )),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            color: Colors.black26,
                            height: 1.0,
                          ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(30),
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                child: Text(translator.translate("expiry"),
                                    style: TextStyle(color: Colors.black45, fontSize: 15)),
                              ),
                              Container(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      widget.dpl['expire_date'].toString().replaceFirst("00:", widget.dpl["expire_time"]+":"),
                                      style: TextStyle(color: Colors.black, fontSize: 15),
                                    ),
                                  )),
                              SizedBox(
                                width: 30,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            color: Colors.black26,
                            height: 1.0,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 30,
                              ),
                              Text(translator.translate("maxNumofUse"), style: TextStyle(color: Colors.black45, fontSize: 15)),
                              Expanded(
                                child: Container(
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        widget.dpl['max_number_of_uses'],
                                        style: TextStyle(color: Colors.black, fontSize: 15),
                                      ),
                                    )),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            color: Colors.black26,
                            height: 1.0,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      IconButton(
                                        icon: const Icon(
                                          Icons.email,
                                          color: Colors.blue,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          //    Navigator.pop(context);
                                          Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => Email_Multishare(dpl:widget.dpl),
                                          ));
                                        },
                                      ),
                                      Text(
                                        translator.translate("email"),
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
                                          Icons.sms,
                                          color: Colors.blue,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          //      Navigator.pop(context);
                                          Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => Sms_Multishare(dpl:widget.dpl),
                                          ));
                                        },
                                      ),
                                      Text(
                                        translator.translate("sms"),
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
                                          FontAwesomeIcons.whatsapp,
                                          color: Colors.blue,
                                          size: 20,
                                        ),
                                        onPressed: () {






                                          FlutterShareMe()
                                              .shareToWhatsApp(
                                            msg: 'DPL#'+widget.dpl["id"].toString()+'-'+translator.translate("oneTimeLink")+
                                                "\n " +
                                                widget.dpl['is_amount_set_by_user'].toString()=="1"? translator.translate("setbyusr"):
                                            widget.dpl['currency'].toString()=="1"?      widget.dpl['amount'].toString()+" "+"TRY":
                                            widget.dpl['currency'].toString()=="2"?      widget.dpl['amount'].toString()+" "+
                                                "USD":      widget.dpl['amount'].toString()+" "+"EUR"

                                                +
                                                "\n " +
                                                translator.translate("expiry") +
                                                "\n" +
                                                widget.dpl['type']==1?widget.dpl['expire_date'].toString(): widget.dpl["expire_date"].toString().replaceFirst("00:", widget.dpl["expire_time"].toString()+":"),

                                          )
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
                                        translator.translate("whats"),
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
                                        onPressed: ()async {

                                          await Clipboard.setData(new ClipboardData(
                                              text:APIEndPoints.dplLink+widget.dpl["token"].toString()));



                                          Scaffold.of(context).showSnackBar(SnackBar(
                                              duration: Duration(seconds: 3),
                                              content: Text(translator.translate("dpllinkcopy"))
                                          ));




                                        },
                                      ),
                                      Text(
                                        translator.translate("copy"),
                                        style: TextStyle(
                                            fontSize: 8, color: Colors.black45),
                                      ),
                                    ],
                                  ),
                                ),
                                /*Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      IconButton(
                                        icon: const Icon(
                                          Icons.cancel,
                                          color: Colors.blue,
                                          size: 20,
                                        ),
                                        onPressed: () {Navigator.pop(context);},
                                      ),
                                      Text(
                                        translator.translate("cancel"),
                                        style: TextStyle(
                                            fontSize: 8, color: Colors.black45),
                                      ),
                                    ],
                                  ),
                                ),*/
                              ],
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
          }),
    );
  }
}

class success_json {
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

  String button;
  DepositData depositData;
  List<String> footerTab;
  String header;
  String success;
  String yourdeposit;

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
  DepositData({this.bank, this.reciever, this.iban, this.pNR, this.aMOUNT});

  DepositData.fromJson(Map<String, dynamic> json) {
    bank = json['bank'];
    reciever = json['reciever'];
    iban = json['iban'];
    pNR = json['PNR'];
    aMOUNT = json['AMOUNT'];
  }

  String aMOUNT;
  String bank;
  String iban;
  String pNR;
  String reciever;

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
