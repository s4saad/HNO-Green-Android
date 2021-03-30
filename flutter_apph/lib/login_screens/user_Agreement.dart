import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:fluttersipay/dashboard/drawerMenu.dart';
class agree extends StatefulWidget {
  agree({Key key}) : super(key: key);

  @override
  _agreeState createState() => _agreeState();
}

class _agreeState extends State<agree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //  drawer: DrawerMenu().getDrawer,
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
          title: Text(
            translator.translate("user")+" "+translator.translate("agreement")
            ,

          ),
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

        body:Padding(
          padding: const EdgeInsets.all(15.0),
          child:   SingleChildScrollView(
            child: Text(translator.translate("userAgreement"),
              style: TextStyle(
                  fontSize: 18,
                  // fontWeight: FontWeight.bold,
                  color: Colors.black
              ),
            ),
          ),
        )
    );
  }
}