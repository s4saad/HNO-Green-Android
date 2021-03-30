import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttersipay/corporate/dashboard/support.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttersipay/corporate/payment/success_sharelink.dart';
import 'package:fluttersipay/utils/api_endpoints.dart' as global;
import 'package:http/http.dart' as http;
import 'package:fluttersipay/corporate/global_data.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:fluttersipay/dashboard/drawerMenu.dart';

TextEditingController _phoneController = TextEditingController();

class Email_Sharelink extends StatefulWidget {
  Map dpl;

  Email_Sharelink({this.dpl});

  @override
  _Email_Sharelink createState() => _Email_Sharelink();
}

class _Email_Sharelink extends State<Email_Sharelink> {
  bool _checkphone = true;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  String email;
  bool showLoad = false;

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
              if (email == null) {
                scaffoldKey.currentState.showSnackBar(SnackBar(
                    duration: Duration(seconds: 2),
                    content: Text(translator.translate("error") +
                        translator.translate("email"))));
              } else {
                if (email.contains("com") &&
                    email.contains(".") &&
                    email.contains("@")) {
                  setState(() {
                    showLoad = true;
                  });
//call API
                  List<String> emails = new List<String>();

                  emails.add(email);
                  print(emails.toString());
                  http
                      .post(global.APIEndPoints.emailApi,
                          headers: {
                            "Accept": "application/json",
                            "Authorization": userToken
                          },
                          body: {
                            "dpl_id": widget.dpl["id"].toString(),
                            "payment_link_type": "1",
                            "email[]": emails[0].toString()
                          },
                          encoding: Encoding.getByName(
                              "application/x-www-form-urlencoded"))
                      .then((res) {
                    setState(() {
                      showLoad = false;
                    });
                    print("###############" + res.body.toString());
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
                } else {
                  scaffoldKey.currentState.showSnackBar(SnackBar(
                      duration: Duration(seconds: 2),
                      content: Text(translator.translate("emailVerify"))));
                }
              }
            },
            color: Colors.blue,
            disabledColor: Colors.blue,
            padding: EdgeInsets.all(15.0),
            child: Text(
              translator.translate('sendEmail'),
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
                                    translator.translate("shareEmail"),
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
                                        widget.dpl["id"].toString() +
                                        '-' +
                                        translator.translate("shareInfoEmail"),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black45,
                                    ),
                                  ),
                                  width: ScreenUtil.getInstance().setWidth(690),
                                ),
                                SizedBox(
                                  height: ScreenUtil.getInstance().setHeight(100),
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                          translator.translate("dpl") +
                                              ' #' +
                                              widget.dpl["id"].toString() +
                                              '-' +
                                              translator.translate("onetime") +" "+
                                              translator.translate("link"),
                                          style: TextStyle(
                                              color: Colors.black45, fontSize: 15)),
                                    ),
                                    Expanded(
                                      child: Container(
                                          child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          widget.dpl['is_amount_set_by_user'] == 1
                                              ? ''
                                              : widget.dpl['amount'].toString(),
                                          style: TextStyle(
                                              color: Colors.black87, fontSize: 15),
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
                                  height: ScreenUtil.getInstance().setHeight(30),
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(translator.translate("expiry"),
                                          style: TextStyle(
                                              color: Colors.black45, fontSize: 15)),
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
                                            color: Colors.black87, fontSize: 15),
                                      ),
                                    )),
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
                                  height: ScreenUtil.getInstance().setHeight(120),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    translator.translate("recEmail") + ' *',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil.getInstance().setHeight(20),
                                ),
                                Container(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 10.0, right: 10.0),
                                    child: _checkphone
                                        ? Container(
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                color: Colors.black38,
                                              ),
                                            ),
                                            height: 0,
                                          )
                                        : Row(
                                            children: <Widget>[
                                              Text(
                                                "", //   users.fail.user,
                                                style: TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  translator.translate("login"),
                                                  style: TextStyle(
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                  ),
                                ),
                                TextFormField(
                                  //       initialValue: email,

                                  onChanged: (mail) {
                                    setState(() {
                                      email = mail;
                                      //_phoneController.value=email;
                                    });

                                    /*     if(text.length > 0 && !_checkphone){
                                      setState(() {
                                        _checkphone = true;
                                      });
                                    } */
                                  },
                                  style: TextStyle(
                                      color:
                                          _checkphone ? Colors.black : Colors.red),
                                  //         controller: _phoneController,

                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: 'example@mail.com',
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
                                            Icons.email,
                                            color: Colors.black38,
                                          )
                                        : const Icon(
                                            Icons.cancel,
                                            color: Colors.red,
                                          ),
                                  ),

                                  obscureText: false,
                                ),
                                SizedBox(
                                  height: ScreenUtil.getInstance().setHeight(130),
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
              return Text("${snapshot.error}");
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
