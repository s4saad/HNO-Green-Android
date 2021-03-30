import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersipay/dashboard/Live_support.dart';
import 'package:fluttersipay/dashboard/providers/money_transfer_settings_provider.dart';
import 'package:fluttersipay/loading_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart' as trans;
import 'drawerMenu.dart';
import '../base_main_repo.dart';

class TransferSettingsScreen extends StatefulWidget {
  final BaseMainRepository baseRepo;

  TransferSettingsScreen({this.baseRepo});

  @override
  _TransferSettingsScreenState createState() => _TransferSettingsScreenState();
}

class _TransferSettingsScreenState extends State<TransferSettingsScreen> {
  List<String> _priority_data = [translator.translate("availableBalance"),translator.translate("balance")];
  bool isallowed = false;

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
        create: (context) => MoneyTransferSettingsProvider(widget.baseRepo),
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
              title: Text(translator.translate("transSettings")),
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
            body: Consumer<MoneyTransferSettingsProvider>(
                builder: (context, snapshot, _) {
              return Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(left: 30.0, right: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                     /*     Text(
                        translator.translate("moneytrans").toUpperCase()+" "+translator.translate("setting").toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),*/
                          SizedBox(
                            height: 40,
                          ),
                         /* Text(
                         translator.translate("moneytrans").toUpperCase()+translator.translate("req"),
                            style:
                                TextStyle(color: Colors.black54, fontSize: 12),
                              ),*/
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Icon(
                                      FontAwesomeIcons.userCog,
                                      color: Colors.black26,
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          translator.translate("allowReq"),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Checkbox(
                                            value: snapshot.checkBoxValue,
                                            onChanged: (bool newValue) {
                                              snapshot.setCheckBox(newValue);
                                            })
                                      ],
                                    ),
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
                              RichText(
                                  textAlign: TextAlign.left,
                                  text: TextSpan(
                                    // set the default style for the children TextSpans
                                      style:
                                      TextStyle(fontSize: 13, wordSpacing: 3),
                                      children: [
                                        WidgetSpan(
                                          child: Icon(
                                            Icons.info,
                                            size: 14,
                                            color: Colors.black45,
                                          ),
                                        ),
                                        TextSpan(
                                            text:translator.translate("transferInfosettings")
                                            ,   style:
                                        TextStyle(color: Colors.black45)),
                                      ])),
                              SizedBox(
                                height: 50,
                              ),
                              Text(
                                translator.translate("Transpriority"),
                                style:
                                TextStyle(color: Colors.black54, fontSize: 12),
                              ),
                              DropdownButton<String>(
                                icon: Icon(Icons.keyboard_arrow_down),
                                items: _priority_data
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Icon(Icons.note),
                                    SizedBox(width: 10),
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
                              snapshot
                                  .setMoneyTransferSettingDropDownValue(value);
                            },
                            value: snapshot.selectedDropDownValue,
                            isExpanded: true,
                          ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(180),
                          ),
                          Container(
                            child: FlatButton(
                              onPressed: () {
                                snapshot.saveMoneyTransferSettings(() {
                                  Navigator.of(context).pop();
                                  Flushbar(
                                    title: translator.translate("success"),
                                    message:translator.translate("setupdated"),
                                    duration: Duration(seconds: 3),
                                  )..show(context);
                                }, (description) {
                                  Flushbar(
                                    title: translator.translate("fail"),
                                    message: translator.currentLanguage=="en"?
                                    trans.GoogleTranslator().translate(description,to: "en").toString()
                                    :
                                   trans.GoogleTranslator().translate(description,to: "tr").toString()
                                    ,
                                    duration: Duration(seconds: 3),
                                  )..show(context);
                                });
                              },
                              color: Colors.blue,
                              disabledColor: Colors.blue,
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                translator.translate("save"),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            width: ScreenUtil.getInstance().setWidth(690),
                          ),
                          SizedBox(
                            height: 60,
                          )
                        ],
                      ),
                    ),
                  ),
                  //Dashboardbottom(context, null, null, UserTypes.Individual),
                  LoadingWidget(
                    isVisible: snapshot.showLoad ?? false,
                  )
                ],
              );
            })));
  }
}
