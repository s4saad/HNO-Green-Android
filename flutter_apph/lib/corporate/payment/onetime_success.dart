import 'dart:convert';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersipay/corporate/dashboard/support.dart';
import 'package:fluttersipay/utils/api_endpoints.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttersipay/corporate/payment/email_sharelink.dart';
import 'package:fluttersipay/corporate/payment/sms_sharelink.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:fluttersipay/dashboard/drawerMenu.dart';
import 'dpl_history.dart';

Widget Onetime_Success(Map dpl) {


  return Onetime_Success_panel(dpl:dpl);
}

class Onetime_Success_panel extends StatefulWidget {
 // Onetime_Success_panel({Key key}) : super(key: key);
  Map dpl;
  Onetime_Success_panel({this.dpl});
  
  @override
  _Onetime_Success_panel createState() => _Onetime_Success_panel(dpl: this.dpl);
}

class _Onetime_Success_panel extends State<Onetime_Success_panel>  {
  
  Map dpl;
  _Onetime_Success_panel({this.dpl});
  GlobalKey<ScaffoldState> _key=new   GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {
print(widget.dpl["exchange_rate"]);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
    ScreenUtil(width: 750, height: 1304, allowFontScaling: true)
      ..init(context);
    return Scaffold(key: _key,
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

            //    drawer:DrawerMenu().getDrawer ,
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
                  title: Text(translator.translate('sharelink')),
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
                            height: ScreenUtil.getInstance().setHeight(20),
                          ),
                          Container(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                '#'+this.dpl["id"].toString()+translator.translate("successInfo"),
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
                                child: Text('DPL#'+this.dpl["id"].toString()+'-'+translator.translate("oneTimeLink"),
                                 style: TextStyle(color: Colors.black45, fontSize: 14)),
                              ),
                              Expanded(
                                child: Container(
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                              widget.dpl['is_amount_set_by_user']==1? ""://translator.translate("setbyusr"):
            widget.dpl['currency'].toString()=="1"?      widget.dpl['amount'].toString()+" "+"TRY":
                  widget.dpl['currency'].toString()=="2"?      widget.dpl['amount'].toString()+" "+"USD":      widget.dpl['amount'].toString()+" "+"EUR"
                  ,
                                           style: TextStyle(color: Colors.black87, fontSize: 15),
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
                              Expanded(
                                child: Container(
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                            widget.dpl['type']==1?widget.dpl['expire_date']: widget.dpl["expire_date"].toString().replaceFirst("00:", widget.dpl["expire_time"].toString()+":"),
                                
                                 
                                          style: TextStyle(color: Colors.black87, fontSize: 15),
                                        ),
                                      ),
                                    )),
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
                            height: 30,
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
                                     //     Navigator.pop(context);
                                          Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => Email_Sharelink(dpl:this.dpl),
                                          ));
                                        },
                                      ),
                                      Text(
                                        users.footerTab[0],
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
                                      //    Navigator.pop(context);
                                          Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => Sms_Sharelink(dpl: this.dpl,),
                                          ));
                                        },
                                      ),
                                      Text(
                                        users.footerTab[1],
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
                                              msg: 'DPL#'+this.dpl["id"].toString()+'-'+translator.translate("oneTimeLink")+
                                                  "\n " +
                                                  widget.dpl['is_amount_set_by_user'].toString()=="1"? translator.translate("setbyusr"):
                                              widget.dpl['currency'].toString()=="1"?      widget.dpl['amount'].toString()+" "+"TRY":
                                              widget.dpl['currency'].toString()=="2"?      widget.dpl['amount'].toString()+" "+
                                                  "USD":      widget.dpl['amount'].toString()+" "+"EUR"

                                                  +
                                                  "\n " +
                                                  translator.translate("expiry") +
                                                  "\n" +
                                                  widget.dpl['type']==1?widget.dpl['expire_date']: widget.dpl["expire_date"].toString().replaceFirst("00:", widget.dpl["expire_time"].toString()+":"),

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
                                        users.footerTab[2],
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
                                        onPressed: () async{

 await Clipboard.setData(new ClipboardData(text:APIEndPoints.dplLink+this.dpl["token"].toString()));

              _key.currentState.showSnackBar(
                      new SnackBar(duration: Duration(seconds: 2),content: new Text(translator.translate("dpllinkcopy")),));




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
                                        onPressed: () {


Navigator.pop(context);

                                        },
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
                            height: ScreenUtil.getInstance().setHeight(10),
                          ),
                    /*       Container(
                            padding: EdgeInsets.only(left: 30.0, right: 30.0),
                            child: FlatButton(
                              onPressed: (){
                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=> Dpl_History(),
                                ));
                              },
                              color: Colors.blue,
                              disabledColor: Colors.blue,
                              padding: EdgeInsets.all(15.0),
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 95,
                                    ),
                                    SizedBox(
                                      child: Icon(FontAwesomeIcons.link, color: Colors.white, size: 15,),
                                      width: 30,
                                    ),
                                    SizedBox(
                                      child: Text(
                                        "DPL HISTORY",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            width: ScreenUtil.getInstance().setWidth(750),
                          ), */
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
