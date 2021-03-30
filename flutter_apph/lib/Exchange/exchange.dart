import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersipay/Exchange/providers/exchange_provider.dart';
import 'package:fluttersipay/bottom_navigator.dart';
//import 'package:fluttersipay/dashboard/drawerMenu.dart';
import 'package:fluttersipay/loading_widget.dart';
import 'package:fluttersipay/utils/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:fluttersipay/dashboard/Live_support.dart';
import '../base_main_repo.dart';
import 'exchange_rate.dart';

class ExchangePanelScreen extends StatefulWidget {
  final BaseMainRepository baseRepo;
  final List wallets;
  final UserTypes userType;
  ExchangePanelScreen(this.baseRepo, this.wallets, this.userType);
  @override
  _ExchangePanelScreenState createState() => _ExchangePanelScreenState();
}

class _ExchangePanelScreenState extends State<ExchangePanelScreen> {
  int _selectedItemPosition = 0;

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
    return  ChangeNotifierProvider(
        create: (context) => ExchangeProvider(widget.baseRepo, widget.wallets,
            TextEditingController(), TextEditingController()),
        child: Scaffold(

          ///  drawer: DrawerMenu().getDrawer,
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
              title: Text("EXCHANGE"),
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
            body: 1==1?
            Container(child:Center(child:Text(translator.translate("exchangeMaintenance"))))
                :
            Consumer<ExchangeProvider>(builder: (context, snapshot, _) {
              return Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
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
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                  decoration: new BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                        color: Colors.black38,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      snapshot.getAvailableWalletAmount(0) +
                                          '৳',
                                      style: TextStyle(
                                          color: Colors.black38, fontSize: 16),
                                    ),
                                  )),
                            ),
                            Expanded(
                              child: Container(
                                  decoration: new BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                        color: Colors.black38,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      snapshot.getAvailableWalletAmount(1) +
                                          "\$",
                                      style: TextStyle(
                                          color: Colors.black38, fontSize: 16),
                                    ),
                                  )),
                            ),
                            Expanded(
                              child: Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    snapshot.getAvailableWalletAmount(2) + '€',
                                    style: TextStyle(
                                        color: Colors.black38, fontSize: 16),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30.0, right: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height:
                                    ScreenUtil.getInstance().setHeight(10),
                                  ),
                                  Text(
                                    'FROM',
                                    style: TextStyle(
                                        color: Colors.black38, fontSize: 12),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: TextFormField(
                                              style: TextStyle(
                                                  color: Colors.black),
                                              keyboardType: TextInputType.phone,
                                              controller:
                                              snapshot.fromController,
                                              decoration: InputDecoration(
                                                  enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide:
                                                      BorderSide(
                                                          color: Colors
                                                              .black45,
                                                          width: 0.2)),
                                                  focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide:
                                                      BorderSide(
                                                          color: Colors
                                                              .black45,
                                                          width: 0.2)),
                                                  prefixIcon: const Icon(
                                                    Icons.map,
                                                    size: 16,
                                                    color: Colors.black45,
                                                  ),
                                                  hintText: "0,00"),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Please enter AMOUNT';
                                                }
                                                return null;
                                              },
                                              obscureText: false,
                                            ),
                                          ),
                                          height: 50,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'EXCHANGE',
                                    style: TextStyle(
                                        color: Colors.black38, fontSize: 12),
                                  ),
                                  SizedBox(
                                    height:
                                    ScreenUtil.getInstance().setHeight(20),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: DropdownButton<String>(
                                              icon: Icon(
                                                Icons.keyboard_arrow_down,
                                                size: 16,
                                              ),
                                              items: snapshot.currenciesDropDown
                                                  .map<
                                                  DropdownMenuItem<
                                                      String>>(
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
                                                snapshot.selectedCurrencyDropDownValue1 =
                                                    value;
                                              },
                                              value: snapshot
                                                  .selectedCurrencyDropDownValue1,
                                              isExpanded: true,
                                            ),
                                          ),
                                          height: ScreenUtil.getInstance()
                                              .setHeight(110),
//                                width: ScreenUtil.getInstance().setWidth(150),
                                        ),
                                      ),
                                      Container(
                                        child: Container(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Icon(
                                              FontAwesomeIcons.exchangeAlt,
                                              color: Colors.black26,
                                              size: 20.0,
                                            ),
                                          ),
                                          width: ScreenUtil.getInstance()
                                              .setWidth(150),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: DropdownButton<String>(
                                              icon: Icon(
                                                Icons.keyboard_arrow_down,
                                                size: 16,
                                              ),
                                              items: snapshot.currenciesDropDown
                                                  .map<
                                                  DropdownMenuItem<
                                                      String>>(
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
                                                snapshot.selectedCurrencyDropDownValue2 =
                                                    value;
                                              },
                                              value: snapshot
                                                  .selectedCurrencyDropDownValue2,
                                              isExpanded: true,
                                            ),
                                          ),
                                          height: ScreenUtil.getInstance()
                                              .setHeight(110),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'TO',
                                    style: TextStyle(
                                        color: Colors.black38, fontSize: 12),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: TextFormField(
                                              enabled: false,
                                              style: TextStyle(
                                                  color: Colors.black),
                                              keyboardType: TextInputType.phone,
                                              controller: snapshot.toController,
                                              decoration: InputDecoration(
                                                enabledBorder:
                                                UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                        Colors.black45,
                                                        width: 0.2)),
                                                focusedBorder:
                                                UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                        Colors.black45,
                                                        width: 0.2)),
                                                prefixIcon: const Icon(
                                                  Icons.map,
                                                  size: 16,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Please enter AMOUNT';
                                                }
                                                return null;
                                              },
                                              obscureText: false,
                                            ),
                                          ),
                                          height: ScreenUtil.getInstance()
                                              .setHeight(100),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: Text(snapshot.from ?? '',
                                  style: TextStyle(
                                      color: Colors.black45, fontSize: 17)),
                            ),
                            Expanded(
                              child: Container(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      snapshot.to ?? '',
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 16),
                                    ),
                                  )),
                            ),
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
//                        Row(
//                          children: <Widget>[
//                            SizedBox(
//                              width: 30,
//                            ),
//                            Expanded(
//                              child: Text('Expiry Date: ',
//                                  style: TextStyle(
//                                      color: Colors.black45, fontSize: 17)),
//                            ),
//                            Expanded(
//                              child: Container(
//                                  child: Align(
//                                alignment: Alignment.bottomRight,
//                                child: Text(
//                                  '20.10.2019 14:19',
//                                  style: TextStyle(
//                                      color: Colors.black87, fontSize: 16),
//                                ),
//                              )),
//                            ),
//                            SizedBox(
//                              width: 30,
//                            ),
//                          ],
//                        ),
//                        SizedBox(
//                          height: 20,
//                        ),
                        Divider(
                          color: Colors.black26,
                          height: 1.0,
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(50),
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 30.0, right: 30.0),
                              child: Container(
                                child: FlatButton(
                                  onPressed: () {
                                    snapshot.createExchange(() {
                                      Navigator.of(context).pop();
                                      Flushbar(
                                        title: "Successful!",
                                        message:
                                        translator.translate("exchangeSuccess"),
                                        duration: Duration(seconds: 3),
                                      )..show(context);
                                    }, (description) {
                                      Flushbar(
                                        title: "Failure",
                                        message: description,
                                        duration: Duration(seconds: 3),
                                      )..show(context);
                                    });
                                  },
                                  color: Colors.blue,
                                  disabledColor: Colors.blue,
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    "EXCHANGE",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                width: ScreenUtil.getInstance().setWidth(640),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 90,
                        ),
                      ],
                    ),
                  ),
                  getCustomNavigator(
                      context,
                      ["Deposit", "Money Transfer", "Withdraw", "Exchange"],
                      3,
                      widget.baseRepo,
                      widget.wallets,
                      widget.userType),
                  LoadingWidget(isVisible: snapshot.showLoad ?? false)
                ],
              );
            })));
  }

  void checkVerify() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Exchange_rate(),
//        builder: (context) => Verify_attention(),
        ));
  }
}
