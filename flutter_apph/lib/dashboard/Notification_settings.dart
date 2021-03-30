import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersipay/dashboard/Live_support.dart';
import 'package:fluttersipay/dashboard/providers/notification_settings_provider.dart';
import 'package:fluttersipay/loading_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'drawerMenu.dart';
import '../base_main_repo.dart';
import 'package:translator/translator.dart' as tr;
class NotificationSettingsScreen extends StatefulWidget {
  final BaseMainRepository baseRepo;
  NotificationSettingsScreen(this.baseRepo);
  @override
  _NotificationSettingsScreenState createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  var _check_value =
      List<List<bool>>.generate(4, (i) => List<bool>.generate(3, (j) => false));
  var _setting_data = [
    {
      "title": "Money Transfer",
      "description": " Simply dummy text",
    },
    {
      "title": "Transaction Refunds",
      "description": "Simply dummy text",
    },
    {
      "title": "Money Requests",
      "description": "Simply dummy text",
    },
    {
      "title": "Weekly Report",
      "description": " Simply dummy text",
    },
  ];
  var snap;

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
        create: (context) => NotificationSettingsProvider(widget.baseRepo),
        child: Scaffold(




        //    drawer:DrawerMenu().getDrawer ,


            floatingActionButtonLocation:FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Container(

                width: ScreenUtil.getInstance().setWidth(690),

                child: FlatButton(
                  onPressed: () {





                    snap.saveNotificationSettings(() {
                      Navigator.of(context).pop();
                      Flushbar(
                        title: translator.translate("success"),
                        message:
                        'Notification Settings updated successfully.',
                        duration: Duration(seconds: 3),
                      )..show(context);
                    }, (description) {
                      Flushbar(
                        title: translator.translate("fail"),
                        message: description,
                        duration: Duration(seconds: 3),
                      )..show(context);
                    });    },
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
              ),
            ),










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
              title: Text(translator.translate("notiSetting")),
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
            body: Consumer<NotificationSettingsProvider>(
                builder: (context, snapshot, _) {


                  snap=snapshot;

              return Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                            translator.translate("notiSetting"),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                           translator.translate("notiSettingInfo"),     style: TextStyle(
                                    color: Colors.black54, fontSize: 16),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                           /*            child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.phone_android,
                                            color: Colors.blue,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                          translator.translate("app"),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.black45),
                                          )
                                        ],
                                      ), */
                                      width: 40,
                                    ),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            FontAwesomeIcons.commentDots,
                                            color: Colors.blue,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                          translator.translate("sms"),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.black45),
                                          )
                                        ],
                                      ),
                                      width: 40,
                                    ),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.email,
                                            color: Colors.blue,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            translator.translate("email"),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.black45),
                                          )
                                        ],
                                      ),
                                      width: 40,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: new ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.notificationSettingsUI.length,
                            primary: true,
                            itemBuilder: (BuildContext content, int index) {
                      var title=snapshot.notificationSettingsUI[index];

                              return new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 20.0, right: 20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(width: MediaQuery.of(context).size.width/2,
                                              child:

                                             Text(
                                             title
                                                ,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold),
                                              )
                                            ),
                     
                          Expanded(
                               child: Row(
                                            children: <Widget>[
                                          /*     Expanded(
                                                flex: 1,
                                                child: Text(''),
                                              ), */
                                              Expanded(
                                                flex: 1,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                   /*  Container(
                                                      child:
                                                       Checkbox(
                                                        value: true,
                                                        onChanged:
                                                            (bool value) {


//print(snapshot.[index].toString());
                                    
                                                            }
                                                            
                                                            
                                                            ,
                                                      ),
                                                      width: 40,
                                                    ), */
                                                    Container(
                                                      child: Checkbox(
                                                        value: snapshot
                                                                .checkedSMSList[
                                                            index],
                                                        onChanged: (bool value) {
                                                          snapshot.setSMSCheckBox(
                                                              index, value);
                                                        },
                                                      ),
                                                      width: 40,
                                                    ),
                                                    Container(
                                                      child: Checkbox(
                                                        value: snapshot
                                                                .checkedEmailList[
                                                            index],
                                                        onChanged: (bool value) {
                                                          snapshot
                                                              .setEmailCheckBox(
                                                                  index, value);
                                                        },
                                                      ),
                                                      width: 40,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                             )
                                          ],
                                        ),
                                
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black45,
                                    height: 1.0,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Container(

                            width: ScreenUtil.getInstance().setWidth(690),
                          ),
                        ),
                        SizedBox(
                          height: 90,
                        )
                      ],
                    ),
                  ),
                  //Dashboardbottom(context, null, null, null),
                  LoadingWidget(
                    isVisible: snapshot.showLoad ?? false,
                  )
                ],
              );
            })));
  }
}
