
import"package:flutter/material.dart";
import 'package:fluttersipay/corporate/dashboard/support.dart';
import 'package:fluttersipay/corporate/global_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

//owner khaled

class paymentSettings extends StatefulWidget {
  @override
  _paymentSettingsState createState() => _paymentSettingsState();
}

class _paymentSettingsState extends State<paymentSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text(translator.translate("paymentMethods")),
        flexibleSpace: Image(
          image: AssetImage('assets/appbar_bg.png'),
          height: 100,
          fit: BoxFit.fitWidth,
        ),
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
      body: Container(

      ),
    );
  }
}