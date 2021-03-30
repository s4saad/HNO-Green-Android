import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fluttersipay/dashboard/drawerMenu.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersipay/dashboard/merchant_panel.dart';
import 'package:fluttersipay/loading_widget.dart';
import 'package:fluttersipay/login_screens/login_repo.dart';
import 'package:fluttersipay/login_screens/providers/kyc_provider.dart';
import 'package:fluttersipay/utils/custom_text_style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../main_api_data_model.dart';
import 'json_models/kyc_ui_verification_model.dart';
import 'package:translator/translator.dart' as tr;
import 'package:fluttersipay/corporate/global_data.dart' as gd;
import 'package:http/http.dart' as http;
import 'package:fluttersipay/utils/api_endpoints.dart' as points;
import 'package:fluttersipay/corporate/global_data.dart';

class KYCUserVerificationScreen extends StatefulWidget {
  final MainApiModel registerData;
  String token;

  KYCUserVerificationScreen(this.registerData, {this.token});

  @override
  KYCUserVerificationScreenState createState() =>
      KYCUserVerificationScreenState();
}

class KYCUserVerificationScreenState extends State<KYCUserVerificationScreen> {
  bool showLoad = true;
  List<DropdownMenuItem<String>> _dropDownP = List();
  List<DropdownMenuItem<String>> _dropDownProfession = List();
  List<DropdownMenuItem<String>> _dropDownQ = List();
  List<DropdownMenuItem<String>> _dropDownQuestions = List();
  String prof = '', selectedValue = '', answer = '', errorText = '';

  onClickVerify() async {
    widget.token = widget.token;
  }

  Future<void> _getKYCData() async {
    final response = await http.get(
        points.APIEndPoints
            .kApiIndividualUserVerificationEndPoint,
        headers: {
          "Accept": "application/json",
          "Authorization": userToken
        });
    if (response.statusCode == 200) {
      Map map = json.decode(response.body.toString());
      print('===== kyc form data =====');
      if (map['statuscode'] == 100) {
        print(response.body);
          for(int i=0; i<map['data']['sectors'].length; i++) {
            _dropDownP.add(DropdownMenuItem<String>(
                value: map['data']['sectors'][i]['id'].toString(),
                child: Text(map['data']['sectors'][i]['name'].toString())));
          }
          map['data']['questions'].forEach((i,q) {
            _dropDownQ.add(DropdownMenuItem<String>(
                value: i.toString(), child: Text(q.toString())));
          });
          setState(() {
            _dropDownProfession = _dropDownP;
            _dropDownQuestions = _dropDownQ;
          });

          print(_dropDownQuestions.toString());
      }
      print('===== end here =====');
    }

  }


  @override
  void initState() {
    // getSecretQuestion();
    // TODO: implement initState
    super.initState();
    _getKYCData();
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
    return new FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/json/register/2_4KYC.json'),
        builder: (context, snapshot) {
          KYCVerificationModel users;
          var parsedJson;
          if (snapshot.hasData) {
            parsedJson = json.decode(snapshot.data.toString());
            users = KYCVerificationModel.fromJson(parsedJson);
            return new Scaffold(
              //    drawer: DrawerMenu().getDrawer,
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
                title: Text(translator.translate("userVer")),
                flexibleSpace: Image(
                  image: AssetImage('assets/appbar_bg.png'),
                  height: 100,
                  fit: BoxFit.fitWidth,
                ),
                actions: <Widget>[
                  IconButton(
                    padding: const EdgeInsets.only(right: 20.0),
                    icon: Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // do something
                    },
                  )
                ],
              ),
              body: ChangeNotifierProvider(
                  create: (context) => KYCProvider(
                      widget.registerData,
                      LoginRepository(),
                      TextEditingController(),
                      TextEditingController(),
                      TextEditingController(),
                      TextEditingController(),
                      TextEditingController(),
                      TextEditingController(text: "10/10/1999"),
                      TextEditingController(),
                      TextEditingController()),
                  child: SingleChildScrollView(
                    child: Padding(
                        padding: EdgeInsets.only(left: 30.0, right: 30.0),
                        child: Consumer<KYCProvider>(
                            builder: (context, snapshot, _) {
                          return Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(40),
                                  ),
                                  Text(
                                    translator.translate("dgitalwallet"),
                                    style: TextStyle(
                                      color: Colors.black45,
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(40),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      translator.translate("name"),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                  TextField(
                                    style: TextStyle(color: Colors.black),
                                    keyboardType: TextInputType.text,
                                    controller: snapshot.nameController,
                                    decoration: InputDecoration(
                                      hintStyle:
                                          CustomTextStyle.formField(context),
                                      errorText: snapshot.nameErrorMessage,
                                      errorMaxLines: 50,
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black12,
                                              width: 1.0)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black45,
                                              width: 1.0)),
                                      prefixIcon: const Icon(
                                        Icons.person,
                                        color: Colors.black38,
                                      ),
                                    ),
                                    obscureText: false,
                                  ),
                                  SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(30),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      translator.translate("surname"),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                  TextField(
                                    style: TextStyle(color: Colors.black),
                                    keyboardType: TextInputType.text,
                                    controller: snapshot.surnameController,
                                    decoration: InputDecoration(
                                      hintStyle:
                                          CustomTextStyle.formField(context),
                                      errorText: snapshot.surnameErrorMessage,
                                      errorMaxLines: 50,
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black12,
                                              width: 1.0)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black45,
                                              width: 1.0)),
                                      prefixIcon: const Icon(
                                        Icons.person,
                                        color: Colors.black38,
                                      ),
                                    ),
                                    obscureText: false,
                                  ),
                                  SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(30),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      translator.translate("tck"),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                  TextField(
                                    style: TextStyle(color: Colors.black),
                                    keyboardType: TextInputType.number,
                                    maxLength: 11,
                                    controller: snapshot.tokenController,
                                    decoration: InputDecoration(
                                      hintStyle:
                                          CustomTextStyle.formField(context),
                                      errorMaxLines: 50,
                                      errorText: snapshot.tcknErrorMessage,
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black12,
                                              width: 1.0)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black45,
                                              width: 1.0)),
                                      prefixIcon: const Icon(
                                        FontAwesomeIcons.hashtag,
                                        color: Colors.black38,
                                      ),
                                    ),
                                    obscureText: false,
                                  ),
                                  /*    SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(30),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                             translator.translate("email"),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                  TextField(
                                    style: TextStyle(color: Colors.black),
                                    keyboardType: TextInputType.emailAddress,

                                    controller: snapshot.emailController,
                                    decoration: InputDecoration(
                                      errorText: snapshot.emailErrorMessage,

                                      hintStyle:
                                          CustomTextStyle.formField(context),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black12,
                                              width: 1.0)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black45,
                                              width: 1.0)),

                                      prefixIcon: const Icon(
                                        Icons.email,
                                        color: Colors.black38,
                                      ),
                                    ),
                                    obscureText: false,
                                  ),



                                  SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(30),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                     translator.translate("pass"),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                  TextField(
                                    style: TextStyle(color: Colors.black),
                                    keyboardType: TextInputType.text,
                                    controller: snapshot.passwordController,
                                    decoration: InputDecoration(
                                      hintStyle:
                                          CustomTextStyle.formField(context),
                                      errorMaxLines: 50,
                                      errorText: snapshot.passwordErrorMessage,
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black12,
                                              width: 1.0)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black45,
                                              width: 1.0)),
                                      prefixIcon: const Icon(
                                        Icons.lock,
                                        color: Colors.black38,
                                      ),
                                    ),
                                    obscureText: true,
                                  ),
                                  SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(30),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                    translator.translate("ConfPass"),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                  TextField(
                                    style: TextStyle(color: Colors.black),
                                    keyboardType: TextInputType.text,
                                    controller: snapshot.confirmController,
                                    decoration: InputDecoration(
                                      hintStyle:
                                          CustomTextStyle.formField(context),
                                      errorMaxLines: 50,
                                      errorText:
                                          snapshot.verifyPasswordErrorMessage,
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black12,
                                              width: 1.0)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black45,
                                              width: 1.0)),
                                      prefixIcon: const Icon(
                                        Icons.lock,
                                        color: Colors.black38,
                                      ),
                                    ),
                                    obscureText: true,
                                  ),
                               */
                                  SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(30),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      translator.translate("dob"),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
//                                      CalendarDatePicker(
//                                        initialDate: DateTime.now(),
//                                        firstDate: DateTime.now(),
//                                        lastDate: DateTime.now(),
//                                        onDateChanged: (val) {
//                                          print(val);
//                                          Navigator.pop(context);
//                                        },
//                                      );

                                      DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          onConfirm: (date) {
                                        snapshot.dateController.text =
                                            date.year.toString();
                                      });
                                    },
                                    child: TextField(
                                      style: TextStyle(color: Colors.black),
                                      keyboardType: TextInputType.number,
                                      maxLength: 4,
                                      enabled: false,
                                      controller: snapshot.dateController,
                                      decoration: InputDecoration(
                                        hintStyle:
                                            CustomTextStyle.formField(context),
                                        errorMaxLines: 50,
                                        errorText:
                                            snapshot.dateOfBirthErrorMessage,
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black12,
                                                width: 1.0)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black45,
                                                width: 1.0)),
                                        prefixIcon: const Icon(
                                          Icons.date_range,
                                          color: Colors.black38,
                                        ),
                                      ),
                                      obscureText: false,
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(20),
                                  ),
                                  Text(
                                    translator.translate('job'),
                                    style: TextStyle(
                                        fontSize: 12
                                        //ScreenUtil().setSp(20),
                                        //fontWeight: FontWeight.w700,
                                        ,
                                        color: Colors.grey[500]),
                                  ),
                                  SizedBox(height: 5),
                                  DropdownButtonFormField(
                                    hint: Text(
                                      translator.translate('choose_one'),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          FontAwesomeIcons.lock,
                                          size: 18,
                                        )),
                                    items: _dropDownProfession,
                                    onChanged: (value) {
                                      print(value);
                                      prof = value;
                                    },
                                    onSaved: (value) {},
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Select profession.';
                                      }
                                      return null;
                                    },
                                    isExpanded: true,
                                  ),


                                  // Align(
                                  //   alignment: Alignment.topLeft,
                                  //   child: Text(
                                  //     translator.translate("job"),
                                  //     style: TextStyle(
                                  //       fontSize: 12,
                                  //       color: Colors.black45,
                                  //     ),
                                  //   ),
                                  // ),
                                  // DropdownButtonFormField<String>(
                                  //   isDense: true,
                                  //   icon: Icon(Icons.keyboard_arrow_down),
                                  //   items: list
                                  //       .map<DropdownMenuItem<String>>((value) {
                                  //     return DropdownMenuItem<String>(
                                  //       value: value,
                                  //       child: Row(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.spaceBetween,
                                  //         children: <Widget>[
                                  //           //
                                  //           //                 Icon(Icons.cur),
                                  //
                                  //           SizedBox(width: 10),
                                  //           Expanded(
                                  //             child: Text(
                                  //               value,
                                  //               style: TextStyle(
                                  //                   fontSize: 12,
                                  //                   color: Colors.grey),
                                  //             ),
                                  //           )
                                  //         ],
                                  //       ),
                                  //     );
                                  //   }).toList(),
                                  //   onChanged: (value) {
                                  //     setState(() {
                                  //       prof = value;
                                  //     });
                                  //
                                  //     snapshot.professionController.text =
                                  //         value;
                                  //   },
                                  //   value: prof,
                                  //   hint: Text(
                                  //       translator.translate('choose_one')),
                                  //   decoration: InputDecoration(
                                  //       prefixIcon: SizedBox(
                                  //     child: Image.asset(
                                  //       "assets/job.png",
                                  //     ),
                                  //     width: 10,
                                  //     height: 10,
                                  //   )),
                                  //   isExpanded: true,
                                  // ),


                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    translator.translate('secret_question'),
                                    style: TextStyle(
                                        fontSize: 12
                                        //ScreenUtil().setSp(20),
                                        //fontWeight: FontWeight.w700,
                                        ,
                                        color: Colors.grey[500]),
                                  ),
                                  SizedBox(height: 5),
                                  DropdownButtonFormField(
                                    hint: Text(
                                      translator.translate('choose_one'),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                      FontAwesomeIcons.lock,
                                      size: 18,
                                    )),
                                    items: _dropDownQuestions,
                                    onChanged: (value) {
                                      print(value);
                                      selectedValue = value;
                                    },
                                    onSaved: (value) {},
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Select question.';
                                      }
                                      return null;
                                    },
                                    isExpanded: true,
                                  ),
                                  SizedBox(height: 20),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        hintText:
                                            translator.translate('answer_here'),
                                        hintStyle: TextStyle(fontSize: 12),
                                        prefixIcon: Icon(
                                          FontAwesomeIcons.lock,
                                          size: 18,
                                        )),
                                    onChanged: (value) {
                                      answer = value.toString();
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter your answer';
                                      }
                                      return null;
                                    },
                                  ),

                                  /*      TextField(
                                    style: TextStyle(color: Colors.black),
                                    keyboardType: TextInputType.text,
                                    controller: snapshot.professionController,
                                    decoration: InputDecoration(
                                      hintStyle:
                                          CustomTextStyle.formField(context),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black12,
                                              width: 1.0)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black45,
                                              width: 1.0)),
                                      prefixIcon: const Icon(
                                        Icons.room_service,
                                        color: Colors.black38,
                                      ),
                                    ),
                                    obscureText: false,
                                  ),*/
                                  SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(20),
                                  ),
                                  Visibility(
                                    visible:
                                        snapshot.kycVerificationErrorMessage !=
                                            null,
                                    child: Column(
                                      children: <Widget>[
                                        /*   FutureBuilder(
                                          future: tr.GoogleTranslator().translate(
                                              snapshot.kycVerificationErrorMessage,to:translator.currentLanguage),
                                          builder: (context, snapsho) {
                                           if(!snapsho.hasData)return Text("");
                                            return Text(
                                              snapsho.data.toString(),
                                              style:
                                                  TextStyle(color: Colors.red[800]),
                                            );
                                          }
                                        ),*/
                                        SizedBox(
                                          height: ScreenUtil.getInstance()
                                              .setHeight(2),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    snapshot.kycVerificationErrorMessage??''.toString(),
                                    style:
                                    TextStyle(color: Colors.red[800]),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil.getInstance()
                                        .setHeight(20),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: FlatButton(
                                            onPressed: () {
                                              snapshot.question =
                                                  this.selectedValue;
                                              snapshot.answer = answer;

                                              snapshot.bearerToken =
                                                  widget.token;
                                              snapshot.verifyKYCUser((msg) {
                                                //          Navigator.popUntil(context,
                                                //            (route) => route.isFirst);
                                                Flushbar(
                                                    title: translator
                                                        .translate("succuss"),
                                                    message: msg,
                                                    duration:
                                                        Duration(seconds: 5))
                                                  ..show(context);

                                                Navigator.of(context).pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MerchantPanelScreen(
                                                                widget
                                                                    .registerData,
                                                                widget.token)),
                                                    (route) => false);
                                              });
                                            },
                                            color: Colors.blue,
                                            disabledColor: Colors.blue,
                                            padding: EdgeInsets.all(15.0),
                                            child: Text(
                                              translator.translate("verify"),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: FlatButton(
                                            onPressed: () {
                                              gd.isVerified = false;
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MerchantPanelScreen(
                                                                  widget
                                                                      .registerData,
                                                                  widget
                                                                      .token)),
                                                      (route) => false);
                                            },
                                            color: Colors.blue,
                                            disabledColor: Colors.blue,
                                            padding: EdgeInsets.all(15.0),
                                            child: Text(
                                              translator.translate("skip"),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    width:
                                        ScreenUtil.getInstance().setWidth(690),
                                  ),
                                  SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(40),
                                  ),
                                ],
                              ),
                              LoadingWidget(isVisible: snapshot.showLoad)
                            ],
                          );
                        })),
                  )),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        });
  }
}
