import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersipay/Money/Send_corp.dart';
import 'package:fluttersipay/Money/providers/money_transfer_send_provider.dart';
import 'package:fluttersipay/base_main_repo.dart';
import 'package:fluttersipay/dashboard/Live_support.dart';
import 'package:fluttersipay/utils/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:fluttersipay/dashboard/drawerMenu.dart';
import '../bottom_navigator.dart';
import 'Incomming_request.dart';
import 'Send_individual.dart';


class MoneyTransferSendScreen extends StatefulWidget {
  final BaseMainRepository baseMainRepository;
  final List wallets;
  MoneyTransferSendScreen(this.baseMainRepository, this.wallets);
  @override
  _MoneyTransferSendScreenState createState() =>
      _MoneyTransferSendScreenState();
}

class _MoneyTransferSendScreenState extends State<MoneyTransferSendScreen> {
  var _value;// = translator.translate("merchanr");
  List<String> _listViewData = [translator.translate("individual"), translator.translate("merchanr")];
  List<String> _list_footer = [
    translator.translate("deposit"),
    translator.translate("moneytrans"),
    translator.translate("withdraw"),
    translator.translate("exchange")
  ];
  int _index = 0;
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
        create: (context) => MoneyTransferSendProvider(
            widget.baseMainRepository, widget.wallets),
        child: Scaffold(

       //     drawer: DrawerMenu().getDrawer,
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
              title: Text(translator.translate("moneytrans").toUpperCase()),
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
            body: Consumer<MoneyTransferSendProvider>(
                builder: (context, snapshot, _) {
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


                                          double.parse(snapshot.getAvailableWalletAmount(0).toString()).toStringAsFixed(2)+
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


                                          double.parse(snapshot.getAvailableWalletAmount(1).toString()).toStringAsFixed(2)+
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


                                        double.parse(snapshot.getAvailableWalletAmount(2).toString()).toStringAsFixed(2)+ '€',
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
                                    items: _listViewData
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                /*Icon(
                                                  FontAwesomeIcons.wallet,
                                                  color: Colors.grey,
                                                  size: 15,
                                                ),*/
                                                SizedBox(width: 25),
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
                                    value: _value,
                                    isExpanded: true,
                                  ),
                                  SizedBox(
                                    height: ScreenUtil.getInstance().setHeight(30),
                                  ),
                                  Container(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child:
                                      Image.asset('assets/money_transfer.png'),
                                    ),
                                    height: ScreenUtil.getInstance().setHeight(300),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil.getInstance().setHeight(30),
                                  ),
                                  /*           Align(
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
                                  SizedBox(
                                    height: ScreenUtil.getInstance().setHeight(10),
                                  ),
                                  Container(
                                    child: FlatButton(
                                      onPressed: () {

                                            Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MoneyRequestsListScreen(
                                                  widget.baseMainRepository),
                                        )
                                            );
                                      },
                                      color: Colors.blue,
                                      disabledColor: Colors.blue,
                                      padding: EdgeInsets.all(15.0),
                                      child: Text(
                                        translator.translate("withdrawbtn"),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    width: ScreenUtil.getInstance().setWidth(690),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil.getInstance().setHeight(10),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      getCustomNavigatorMONEY(
                          context,
                          _list_footer,
                          1,
                          widget.baseMainRepository,
                          widget.wallets,
                          UserTypes.Individual),
                    ],
                  );
                })));
  }

  void sendMoney() {
    if (_value == _listViewData[0]) {

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SendMoneyToIndividualScreen(
                widget.baseMainRepository, widget.wallets),
          ));
    } else {

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SendMoneyToCorporateScreen(
                widget.baseMainRepository,
                widget.wallets,
                UserTypes.Individual),
          ));
    }
  }
}
