import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersipay/Money/Send_corp.dart';
import 'package:fluttersipay/Money/Send_individual.dart';
import 'package:fluttersipay/corporate/dashboard/support.dart';
import 'package:fluttersipay/corporate/money/providers/money_panel_provider.dart';
import 'package:fluttersipay/utils/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../base_main_repo.dart';
import 'package:fluttersipay/dashboard/drawerMenu.dart';
class MoneyPanelScreen extends StatefulWidget {
  final BaseMainRepository mainRepo;
  final List userWallets;
  MoneyPanelScreen(this.mainRepo, this.userWallets);
  @override
  _MoneyPanelScreenState createState() => _MoneyPanelScreenState();
}

class _MoneyPanelScreenState extends State<MoneyPanelScreen> {
  var _value ;
  List<String> _listViewData = [ translator.translate("merchanr"), translator.translate("individual")];

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
            MoneyPanelProvider(widget.mainRepo, widget.userWallets),
        child: Scaffold(
         //   drawer:DrawerMenu().getDrawer ,
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
              title: Text( translator.translate("moneytrans")),
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
            body: Consumer<MoneyPanelProvider>(builder: (context, snapshot, _) {
              return Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(50),
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
                          height: ScreenUtil.getInstance().setHeight(50),
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
                               double.parse(snapshot.getAvailableWalletAmount(0).toString()).toStringAsFixed(2) +
                                          '₺',
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 16),
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
                              double.parse(snapshot.getAvailableWalletAmount(1).toString()).toStringAsFixed(2) +
                                          "\$",
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 16),
                                    ),
                                  )),
                            ),
                            Expanded(
                              child: Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                             double.parse(snapshot.getAvailableWalletAmount(2).toString()).toStringAsFixed(2) + '€',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 16),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(80),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30.0, right: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                            translator.translate("sendmoney"),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(30),
                              ),
                              /*Text(
                                translator.translate("chooseWallet"),
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12),
                              ),*/
                              DropdownButtonFormField<String>(
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.grey,
                                ),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.wallet,
                                    color: Colors.grey,
                                  ),
                                  hintText: translator
                                      .translate("chooseWallet"),
                                  hintStyle:
                                  TextStyle(fontSize: 12),
                                ),
                               // hint: Text(translator.translate("chooseWallet")),
                                items: _listViewData
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
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
                                  sendMoney();
                                },
                                value: _value,
                                isExpanded: true,
                              ),
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(100),
                              ),
                     /*          Align(
                                alignment: Alignment.center,
                                child: FlatButton(
                                  onPressed: () {
                                    sendMoney();
                                  },
                                  child: Text(
                                    "HOW TO?",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ), */
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            })));
  }

  void sendMoney() {
    if (_value == translator.translate("merchanr")) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                SendMoneyToCorporateScreen(widget.mainRepo, widget.userWallets, UserTypes.Corporate),
          ));
    }
    if (_value ==
        translator.translate("individual")) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                SendMoneyToIndividualScreen(
                    widget.mainRepo,
                    widget.userWallets),
          ));
    }
   /* Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SendMoneyToCorporateScreen(
              widget.mainRepo, widget.userWallets, UserTypes.Corporate),
        ));*/
  }
}
