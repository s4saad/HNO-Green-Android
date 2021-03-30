import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersipay/corporate/dashboard/support.dart';
import 'package:fluttersipay/corporate/global_data.dart';
import 'package:fluttersipay/corporate/payment/multitime_success.dart';
import 'package:fluttersipay/utils/api_endpoints.dart' as global;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

TextEditingController _SMSController = TextEditingController();

Widget Multi_Time() {
  return Multi_Time_panel();
}

class Multi_Time_panel extends StatefulWidget {
  Multi_Time_panel({Key key}) : super(key: key);

  @override
  _Multi_Time_panel createState() => _Multi_Time_panel();
}

class _Multi_Time_panel extends State<Multi_Time_panel> {
  double amount;
  bool check_state = true;
  int currency = 1;
  List currencyList = new List();
  String explain;
  bool load = false;
  int maxUse;
  TextEditingController mount = TextEditingController();
  DateTime startdate;
  File image;
  GlobalKey<FormState> _key = new GlobalKey<FormState>();
  List<String> _listtryData = ["TRY", "TRYS"];
  bool _remember = false;
  String _time = "";
  var _try_value = "TRY";
  var product = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startdate=DateTime.now();
    _time="12:00";

    getCurrencies();
  }

  void startDatePicker() async {
    var order = await getDate();
    setState(() {
      startdate = order;
    });
  }

//TextEditingController product;

  Future<DateTime> getDate() {
    // Imagine that this function is
    // more complex and slow.
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
  }

//  Future<DateTime> getTime() {
//    return showDatePicker(context,
//        showTitleActions: true,
//        minTime: DateTime(2018, 3, 5),
//        maxTime: DateTime(2019, 6, 7), onChanged: (date) {
//          print('change $date');
//        }, onConfirm: (date) {
//          print('confirm $date');
//        }, currentTime: DateTime.now(), locale: LocaleType.zh);
//  };

  Widget DropDown(List data) {
    if (data != null) {
      return DropdownButtonFormField(
        /* 
            validator: (val){


if(val==null)

            }, */
        items: data.map((item) {
          return new DropdownMenuItem(
            child: new Text(
              item['code'],
              style: TextStyle(fontSize: 14.0),
            ),
            value: item['id'].toString(),
          );
        }).toList(),
        hint: Text(
          "TRY",
          style: TextStyle(
            color: Colors.black45,
          ),
        ),
        onChanged: (newVal) {
          setState(() {
            currency = int.parse(newVal);
            //    customerid = newVal;
            print('customrid:' + newVal.toString());
          });
        },
        //    value: _mySelection,
      );
    } else {
      return new Center(
        child: CircularProgressIndicator(),
      );
    }
  }

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
      body: new FutureBuilder(
          future: DefaultAssetBundle.of(context)
              .loadString('assets/json/Withdrawl/8.6Withdraw_request.json'),
          builder: (context, snapshot) {
//          request_json users;
            var parsedJson;
            if (snapshot.hasData) {
              parsedJson = json.decode(snapshot.data.toString());
//            users = request_json.fromJson(parsedJson);

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
                  title: Text(translator.translate('multiTimeLink')),
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
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Form(
                        key: _key,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(50),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30, right: 30),
                              child: Text(
                                translator.translate("MULTITIMELINK"),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(50),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30.0, right: 30.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    translator.translate("multiInfo"),
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 16),
                                  ),
                                  SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(100),
                                  ),
                                  Text(
                                    translator.translate("AMOUNT *"),
                                    style: TextStyle(
                                        color: check_state
                                            ? Colors.black26
                                            : Colors.red,
                                        fontSize: 12),
                                  ),
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: TextFormField(
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              WhitelistingTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            enabled: !_remember,
                                            controller: mount,
                                            onSaved: (val) {
                                              if (val == "") {
                                                amount = -1;
                                              } else {
                                                amount = double.parse(
                                                    val.toString());
                                              }
                                            },
                                            style: TextStyle(
                                                color: check_state
                                                    ? Colors.black
                                                    : Colors.red),
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black26,
                                                          width: 0.5)),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black26,
                                                          width: 0.5)),
                                              prefixIcon: check_state
                                                  ? const Icon(
                                                      FontAwesomeIcons
                                                          .moneyBillWaveAlt,
                                                      size: 16,
                                                      color: Colors.black26,
                                                    )
                                                  : const Icon(
                                                      Icons.cancel,
                                                      size: 16,
                                                      color: Colors.red,
                                                    ),
                                            ),
                                            obscureText: false,
                                            validator: (value) => value.isEmpty
                                                ? translator
                                                    .translate('enterAmount')
                                                : null,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          decoration: new BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.black26,
                                                width: 0.5,
                                              ),
                                            ),
                                          ),
                                          child: DropDown(currencyList),
                                          width: 100,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Checkbox(
                                        value: _remember,
                                        onChanged: (bool value) {
                                          if (value) {
                                            setState(() {
                                              mount.text = "0";
                                              amount = 0;
                                              _remember = value;
                                            });
                                          } else {
                                            setState(() {
                                              _remember = value;
                                            });
                                          }
                                        },
                                      ),
                                      Expanded(
                                        child: Text(
                                          translator
                                              .translate("setbyusr")
                                              .toUpperCase(),
                                          style: TextStyle(
                                              color: check_state
                                                  ? Colors.black26
                                                  : Colors.red,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    translator.translate("PRODUCT NAME *"),
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  TextFormField(
                                    //      enabled: !_remember,

                                    onSaved: (val) {
                                      product = val;
                                    },
                                    validator: (value) => value.isEmpty
                                        ? translator.translate('enterProduct')
                                        : null,
                                    style: TextStyle(
                                        color: check_state
                                            ? Colors.black
                                            : Colors.red),
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black26,
                                              width: 0.5)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black26,
                                              width: 0.5)),
                                      /*      prefixIcon: check_state
                                                  ? const Icon(
                                                      FontAwesomeIcons.moneyBillWaveAlt,
                                                      size: 16,
                                                      color: Colors.black26,
                                                    )
                                                  : const Icon(
                                                      Icons.cancel,
                                                      size: 16,
                                                      color: Colors.red,
                                                    ), */
                                    ),
                                    obscureText: false,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[

                                      Text(
                                        translator.translate("Expiry Date *"),
                                        style: TextStyle(
                                            color: check_state
                                                ? Colors.black26
                                                : Colors.red,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        translator.translate("Expiry Hour *"),
                                        style: TextStyle(
                                            color: check_state
                                                ? Colors.black26
                                                : Colors.red,
                                            fontSize: 12),
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              right: 5, left: 5),
                                          child: Container(
                                            decoration: new BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  //                   <--- left side
                                                  color: Colors.black12,
                                                  width: 0.5,
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                              children: <Widget>[




                                                Expanded(
                                                  child: Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 5, left: 5),
                                                      child: Container(
                                                        decoration: new BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                              color: Colors.black26,
                                                              width: 0.5,
                                                            ),
                                                          ),
                                                        ),
                                                        child: Row(
                                                          children: <Widget>[
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Icon(
                                                              FontAwesomeIcons
                                                                  .calendarAlt,
                                                              color: Colors.black26,
                                                              size: 16,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                  startdate == null
                                                                      ? ''
                                                                      : startdate.day
                                                                      .toString() +
                                                                      '/' +
                                                                      startdate.month
                                                                          .toString() +
                                                                      '/' +
                                                                      startdate.year
                                                                          .toString(),
                                                                  textAlign:
                                                                  TextAlign.center,
                                                                  style: TextStyle(
                                                                      fontSize: 12)),
                                                            ),
                                                            IconButton(
                                                                alignment:
                                                                Alignment.centerRight,
                                                                icon: Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down,
                                                                  size: 15,
                                                                  color: Colors.black26,
                                                                ),
                                                                onPressed: () {
                                                                  startDatePicker();
                                                                }),
                                                          ],
                                                        ),
                                                      )),
                                                  flex: 1,
                                                ),





                                                Expanded(
                                                  child: RaisedButton(
//                                                shape: RoundedRectangleBorder(
//                                                    borderRadius: BorderRadius.circular(5.0)),
//                                                elevation: 4.0,
                                                    onPressed: () {
                                                      DatePicker
                                                          .showTime12hPicker(
                                                              context,
                                                              theme:
                                                                  DatePickerTheme(
                                                                containerHeight:
                                                                    210.0,
                                                              ),
                                                              showTitleActions:
                                                                  true,
                                                              onConfirm:
                                                                  (time) {
                                                        _time =
                                                            '${time.hour} : ${time.minute} ';
                                                        setState(() {});
                                                      },
                                                              currentTime:
                                                                  DateTime
                                                                      .now(),
                                                              locale: LocaleType
                                                                  .en);
                                                      setState(() {});
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: 50.0,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Row(
                                                            children: <Widget>[
                                                              Container(
                                                                child: Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Icon(
                                                                      Icons
                                                                          .access_time,
                                                                      size: 16,
                                                                      color: Colors
                                                                          .black26,
                                                                    ),
                                                                    Text(
                                                                      " $_time",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black87,
                                                                          fontSize:
                                                                              16),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .keyboard_arrow_down,
                                                            size: 16,
                                                            color:
                                                                Colors.black26,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    color: Colors.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    translator.translate("maxNumofUse") + '',
                                    style: TextStyle(
                                        color: check_state
                                            ? Colors.black26
                                            : Colors.red,
                                        fontSize: 11),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    onSaved: (val) {
                                      if (val == "") {
                                        maxUse = -1;
                                      } else {
                                        maxUse = int.parse(val);
                                      }
                                    },
//                                    validator: (value) => value.isEmpty
//                                        ? translator.translate('enterMaxNo')
//                                        : null,
                                    style: TextStyle(color: Colors.black),
                                    keyboardType: TextInputType.number,
                                    //    controller: _SMSController,
                                    decoration: InputDecoration(
//                                  hintStyle: CustomTextStyle.formField(context),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black26,
                                              width: 0.5)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black26,
                                              width: 0.5)),
                                      prefixIcon: const Icon(
                                        Icons.check,
                                        color: Colors.black26,
                                        size: 17,
                                      ),
                                    ),
                                    obscureText: false,
                                  ),
                                  SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(50),
                                  ),
                                  Text(
                                    translator.translate("EXPLANATION"),
                                    style: TextStyle(
                                        color: check_state
                                            ? Colors.black26
                                            : Colors.red,
                                        fontSize: 11),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Icon(
                                          FontAwesomeIcons.sms,
                                          color: Colors.black26,
                                          size: 17,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Expanded(
                                        child: Text(
                                          translator.translate("explainInfo"),
                                          style: TextStyle(
                                              color: check_state
                                                  ? Colors.black26
                                                  : Colors.red,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30.0, right: 30.0),
                              child: TextFormField(
                                onSaved: (val) {
                                  explain = val;
                                },
//                                validator: (value) => value.isEmpty
//                                    ? translator.translate('enterExplain')
//                                    : null,
                                style: TextStyle(color: Colors.black),
                                keyboardType: TextInputType.text,
                                //    controller: _SMSController,
                                decoration: InputDecoration(
//                                      hintStyle: CustomTextStyle.formField(context),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black12, width: 1.0)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black12, width: 1.0)),
                                ),
                                obscureText: false,
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            image != null
                                ? Card(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Image.file(
                                      image,
                                      width: 120,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ))
                                : Container(),
                            SizedBox(
                              height: 5,
                            ),
                            Card(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: InkWell(
                                onTap: () {
                                  ImagePicker.pickImage(
                                          source: ImageSource.gallery)
                                      .then((imageFile) {
                                    setState(() {
                                      image = imageFile;
                                    });
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(translator.translate("choosefile")),
                                      SizedBox(width: 16),
                                      Icon(FontAwesomeIcons.fileUpload)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 30.0, right: 30.0),
                              child: FlatButton(
                                onPressed: () async {
                                  _key.currentState.validate();
                                  _key.currentState.save();
                                  //      print("Pressed ### Multi Time..$_time....$amount....$startdate......explain=.$explain...$maxUse");
                                  if (this._time != null &&
                                      this.amount != -1 &&
                                      product != "" &&
                                      this.startdate != null) {
                                    setState(() {
                                      load = true;
                                    });

                                    var request = http.MultipartRequest(
                                        "POST",
                                        Uri.parse(
                                            global.APIEndPoints.createApi));
                                    request.fields['amount'] =
                                        this.amount.toString();
                                    request.fields['currency'] =
                                        currency.toString();
                                    request.fields['payment_link_type'] =
                                        2.toString();
                                    request.fields['description'] =
                                        this.explain.toString();
                                    request.fields['is_amount_set_by_user'] =
                                        _remember ? "1" : "0";
                                    request.fields['name_of_product'] = product;
                                    request.fields['expire_date'] =
                                        this.startdate.toString();
                                    request.fields['max_number_of_uses'] =
                                        this.maxUse.toString();
                                    request.fields['expire_hour'] =
                                        _time.substring(0, 2).toString();
                                    if (image != null) {
                                      List<http.MultipartFile> multiFiles =
                                          List<http.MultipartFile>();
                                      multiFiles.add(
                                          await http.MultipartFile.fromPath(
                                              "product_photo", image.path));
                                      request.files.addAll(multiFiles);
                                    }
                                    request.headers
                                        .addAll({"Authorization": userToken});

                                    http.Response.fromStream(
                                            await request.send())
                                        .then((res) {
                                      if (res.statusCode == 200) {
                                        print(res.body.toString() +
                                            "__===__RESPONSE __+++");

                                        Map dpl =
                                            json.decode(res.body.toString());

                                        var state;
                                        state = dpl;
                                        dpl = dpl["data"]["dpl"];

                                        _key.currentState.reset();

                                        setState(() {
                                          load = false;
                                        });
                                        if (state["statuscode"] == 100) {
                                          Navigator.pop(context);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Multitime_Success_panel(
                                                        dpl),
                                              ));
                                        } else {
                                          Scaffold.of(context).showSnackBar(
                                              SnackBar(
                                                  duration:
                                                      Duration(seconds: 2),
                                                  content: Text(
                                                      translator.translate(
                                                          "dplFailed"))));

                                          setState(() {
                                            load = true;
                                          });
                                        }
                                      } else {
                                        setState(() {
                                          load = false;
                                        });
                                        Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                                duration: Duration(seconds: 2),
                                                content: Text(translator
                                                    .translate("dplFailed"))));
                                      }
                                    });
                                  } else {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        duration: Duration(seconds: 2),
                                        content: Text(translator
                                            .translate("requiredField"))));
                                  }

                                  /*   Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Multitime_Success(),
                                      )); */
                                },
                                color: Colors.blue,
                                disabledColor: Colors.blue,
                                padding: EdgeInsets.all(15.0),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      this.load == true
                                          ? Container(
                                              margin: EdgeInsets.only(right: 5),
                                              width: 15,
                                              height: 15,
                                              child: CircularProgressIndicator(
                                                backgroundColor: Colors.white,
                                              ))
                                          : SizedBox(
                                              child: Icon(
                                                FontAwesomeIcons.link,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                              width: 30,
                                            ),
                                      SizedBox(
                                        child: Text(
                                          translator.translate("createdpl"),
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
                            ),
                            SizedBox(
                              height: 80,
                            ),
                          ],
                        ),
                      ),
                    ),
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
