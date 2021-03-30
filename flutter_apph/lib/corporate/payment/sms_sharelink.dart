import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttersipay/corporate/dashboard/support.dart';
import 'package:fluttersipay/corporate/payment/success_sharelink.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:fluttersipay/corporate/global_data.dart';
import 'package:fluttersipay/utils/api_endpoints.dart' as global;
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:fluttersipay/dashboard/drawerMenu.dart';

class Sms_Sharelink extends StatefulWidget {
  Sms_Sharelink({this.dpl});

  Map dpl;

  @override
  _Sms_Sharelink createState() => _Sms_Sharelink();
}

class _Sms_Sharelink extends State<Sms_Sharelink> {
  bool _checkphone = true;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  TextEditingController _phoneController = TextEditingController();
  bool showLoad = false;
  int phone;

  @override
  void initState() {
    super.initState();
    // _phoneController.text="";
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
      key: scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(690),
          child: FlatButton(
            onPressed: () {
              if (_phoneController.value.text == "") {
                scaffoldKey.currentState.showSnackBar(SnackBar(
                    duration: Duration(seconds: 3),
                    content: Text("Please enter a GMS Number !")));
              } else if (_phoneController.value.text.length < 13) {
                scaffoldKey.currentState.showSnackBar(SnackBar(
                    duration: Duration(seconds: 3),
                    content: Text("GMS Number must be at least 13 digits !")));
              } else {
                setState(() {
                  showLoad = true;
                });
                phone = int.parse(_phoneController.value.text);

                http.post(global.APIEndPoints.smsApi, headers: {
                  "Accept": "application/json",
                  "Authorization": userToken
                }, body: {
                  "dpl_id": widget.dpl["id"].toString(),
                  "payment_link_type": "1",
                  "phone[]": "+" + phone.toString()
                }).then((res) {
                  setState(() {
                    showLoad = false;
                  });
//print("#######SMS########"+res.body.toString());
                  if (res.statusCode == 200) {
                    Map map = json.decode(res.body.toString());
                    if (map["statuscode"] == 100) {
                      ///
                      scaffoldKey.currentState.showSnackBar(SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text(translator.translate("sendingCompleted"))));
                    } else {
                      scaffoldKey.currentState.showSnackBar(SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text(translator.translate("sendingFailed"))));
                    }
                  } else {
                    scaffoldKey.currentState.showSnackBar(SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text(translator.translate("sendingFailed"))));
                  }
                });

                setState(() {
                  _phoneController.text = "";
                });

                ///     Navigator.pop(context);
                ///        Navigator.push(
                ///   context,
                ///    MaterialPageRoute(
                ///        builder: (context) =>
                //              Success_Sharelink(),
                //          ));

              }
            },
            color: Colors.blue,
            disabledColor: Colors.blue,
            padding: EdgeInsets.all(15.0),
            child: Text(
              translator.translate('sendSMS'),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
      body: new FutureBuilder(
          future: DefaultAssetBundle.of(context)
              .loadString('assets/json/register/2.1Register.json'),
          builder: (context, snapshot) {
            Autogenerated users;
            var parsedJson;
            if (snapshot.hasData) {
              parsedJson = json.decode(snapshot.data.toString());
              users = Autogenerated.fromJson(parsedJson);
              return new Scaffold(
                //      drawer:DrawerMenu().getDrawer ,
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
                              builder: (context) => Live_Support(),
                            ));
                      },
                    )
                  ],
                ),
                body: Stack(
                  alignment: Alignment.center,
                  children: [
                    SingleChildScrollView(
                        child: Padding(
                            padding: EdgeInsets.only(left: 30.0, right: 30.0),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: ScreenUtil.getInstance().setWidth(60),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    translator.translate("shareSms"),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil.getInstance().setWidth(50),
                                ),
                                Container(
                                  child: Text(
                                    '#' +
                                        widget.dpl['id'].toString() +
                                        '-' +
                                        translator.translate("shareInfo"),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black45,
                                    ),
                                  ),
                                  width: ScreenUtil.getInstance().setWidth(690),
                                ),
                                SizedBox(
                                  height:
                                      ScreenUtil.getInstance().setHeight(100),
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                          'DPL#' +
                                              widget.dpl['id'].toString() +
                                              '-' +
                                              translator.translate("onetime") +
                                           " " +  translator.translate("link"),
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 15)),
                                    ),
                                    Expanded(
                                      child: Container(
                                          child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          widget.dpl['is_amount_set_by_user'] ==
                                                  1
                                              ? ""
                                              : // translator.translate("setbyusr"):
                                              widget.dpl['amount'].toString(),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 15),
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
                                  height:
                                      ScreenUtil.getInstance().setHeight(30),
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                          translator.translate("expiry"),
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 15)),
                                    ),
                                    Container(
                                        child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        widget.dpl['type'] == 1
                                            ? widget.dpl['expire_date']
                                            : widget.dpl["expire_date"]
                                                .toString()
                                                .replaceFirst(
                                                    "00:",
                                                    widget.dpl["expire_time"]
                                                            .toString() +
                                                        ":"),
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15),
                                      ),
                                    )),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Divider(
                                  color: Colors.black26,
                                  height: 1.0,
                                ),
                                SizedBox(
                                  height:
                                      ScreenUtil.getInstance().setHeight(100),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    translator.translate("gsmNum") + ' *',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      ScreenUtil.getInstance().setHeight(20),
                                ),
                                TextFormField(
                                  style: TextStyle(color: Colors.black),
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
//                              hintText: 'Phone Number',
//                              hintStyle: CustomTextStyle.formField(context),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: _checkphone
                                                ? Colors.black38
                                                : Colors.red,
                                            width: 1.0)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: _checkphone
                                                ? Colors.black38
                                                : Colors.red,
                                            width: 1.0)),
                                    prefixIcon: _checkphone
                                        ? const Icon(
                                            Icons.phone,
                                            color: Colors.black38,
                                          )
                                        : const Icon(
                                            Icons.cancel,
                                            color: Colors.red,
                                          ),
                                  ),
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly,
                                    // Fit the validating format.
//                _phoneNumberFormatter,
                                  ],
                                  obscureText: false,
                                ),
                                SizedBox(
                                  height:
                                      ScreenUtil.getInstance().setHeight(130),
                                ),
                                Container(
                                  width: ScreenUtil.getInstance().setWidth(690),
                                ),
                              ],
                            ))),
                    Visibility(
                      visible: showLoad,
                      child: SpinKitChasingDots(
                        color: Colors.blue,
                      ),
                    )
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              // return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          }),
    );
  }
}

class Autogenerated {
  String header;
  String create;
  String sign;
  String phone;
  String have;
  String button;
  User user;
  Fail fail;

  Autogenerated(
      {this.header,
      this.create,
      this.sign,
      this.phone,
      this.have,
      this.button,
      this.user,
      this.fail});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    header = json['header'];
    create = json['create'];
    sign = json['sign'];
    phone = json['phone'];
    have = json['Have'];
    button = json['button'];
    user = json['User'] != null ? new User.fromJson(json['User']) : null;
    fail = json['fail'] != null ? new Fail.fromJson(json['fail']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['header'] = this.header;
    data['create'] = this.create;
    data['sign'] = this.sign;
    data['phone'] = this.phone;
    data['Have'] = this.have;
    data['button'] = this.button;
    if (this.user != null) {
      data['User'] = this.user.toJson();
    }
    if (this.fail != null) {
      data['fail'] = this.fail.toJson();
    }
    return data;
  }
}

class User {
  String user;
  String and;
  String privacy;

  User({this.user, this.and, this.privacy});

  User.fromJson(Map<String, dynamic> json) {
    user = json['User'];
    and = json['and'];
    privacy = json['privacy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['User'] = this.user;
    data['and'] = this.and;
    data['privacy'] = this.privacy;
    return data;
  }
}

class Fail {
  String user;
  String login;

  Fail({this.user, this.login});

  Fail.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    login = json['login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['login'] = this.login;
    return data;
  }
}
