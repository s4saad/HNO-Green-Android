import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../dashboard/Support/support_tickets.dart';
import 'merchant.dart';
import 'package:fluttersipay/dashboard/drawerMenu.dart';
TextEditingController _message_controller = new TextEditingController();

Widget Live_Support() {

return support_tickets();
//  return Live_Support_Panel();
}

class Live_Support_Panel extends StatefulWidget {
  Live_Support_Panel({Key key}) : super(key: key);
  @override
  _Live_Support_Panel createState() => _Live_Support_Panel();
}

class _Live_Support_Panel extends State<Live_Support_Panel> {
  var message_data = [
    {
      "data": "Hello Ozan,\n How may I help?",
      "time": "4",
    },
    {
      "data": "Hello Ozan,\n How may I help?",
      "time": "4",
    },
    {
      "data": "Hello Ozan,\n How may I help?",
      "time": "4",
    },
    {
      "data": "Hello Ozan,\n How may I help?",
      "time": "4",
    },
    {
      "data": "Hello Ozan,\n How may I help?",
      "time": "4",
    },
    {
      "data": "Hello Ozan,\n How may I help?",
      "time": "4",
    },
    {
      "data": "Hello Ozan,\n How may I help?",
      "time": "4",
    }
  ];
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
        drawer:DrawerMenu().getDrawer ,
        appBar: AppBar(
          centerTitle: true,
          title: Text(translator.translate("supportMerchant")),
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
              },
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: CircleAvatar(
                                  backgroundImage: Image.asset(
                                    'assets/user_avatar.png',
                                  ).image,
                                ),
                                height: ScreenUtil.getInstance().setHeight(130),
                                width: ScreenUtil.getInstance().setHeight(130),
                              ),
                              Expanded(
                                child:  Padding(
                                  padding: EdgeInsets.only(
                                    left: 30,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                'ŞALLI ÇEYİZ PERDE',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                        ),
                                        width: ScreenUtil.getInstance().setWidth(500),
                                      ),
                                      SizedBox(
                                        height: ScreenUtil.getInstance().setHeight(20),
                                      ),
                                      Container(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'SUPPORT CONSULTANT',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black45,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: Text(
                            translator.translate("averageResponseTime"),
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          width: double.infinity,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                    color: Colors.white,
                  ),
                  Container(
                    child: new ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: message_data.length,
                      primary: true,
                      itemBuilder: (BuildContext content, int index){
                        return message_list(
                            data: message_data[index]["data"],
                            time:message_data[index]["time"],
                            num: index
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  controller: _message_controller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    border: InputBorder.none,
                    prefixIcon: const Icon(
                      FontAwesomeIcons.commentAlt,
                      color: Colors.black26,
                      size: 16,
                    ),
                    hintText: translator.translate("msgHint"),
                    hintStyle: TextStyle(color: Colors.black26, height: 1.3),
                  ),
                  obscureText: false,
                ),
                width: double.infinity,
                height: 60,
              ),
            )
          ],
        ));
  }

  Widget message_list({String data, String time, int num}) {
    return new Container(
      child: Padding(
        padding: EdgeInsets.only(left: 30.0, right: 30.0,top: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: num %2 == 0? CrossAxisAlignment.start: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              data,
              textAlign: num%2 == 0 ? TextAlign.start: TextAlign.end,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              time + ' minutes ago',
              style: TextStyle(
                  color: Colors.black45
              ),
            )
          ],
        ),
      ),
      color: num%2 == 0 ? null: Colors.white,
    );
  }
}
