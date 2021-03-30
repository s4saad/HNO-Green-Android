import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersipay/corporate/Mobile%20POS/CreditCardScreen.dart';
import 'package:fluttersipay/corporate/dashboard/support.dart';
import 'package:fluttersipay/utils/api_endpoints.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../global_data.dart';
import 'AmountScreen.dart';

class MobilePosDetailsScreen extends StatefulWidget {
  @override
  _nine_twoState createState() => _nine_twoState();
}

class _nine_twoState extends State<MobilePosDetailsScreen> {
  TextEditingController nameController = new TextEditingController();
  bool _validateName = false;
  SharedPreferences prefs;
  String name,phone,email,appId,appSecret,merchantKey;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  getData() async {
    prefs = await SharedPreferences.getInstance();

    print("Token>>>>>" + prefs.getString("token"));

    var jsonData = null;
    var responce = await http.get(
        APIEndPoints.kBaseCorporateAPIEndPoint + "/corporate/info",
        headers: {
          "Accept": "application/json",
          "Authorization": userToken,
          "Content-Type":"application/json"
        });
//
    if (responce.statusCode == 200) {
      print(responce.body);
      jsonData = json.decode(responce.body);
      merchantKey=jsonData["data"]["corporate_info"]["merchant_key"];
      appId=jsonData["data"]["corporate_info"]["app_id"];
      appSecret=jsonData["data"]["corporate_info"]["app_secret"];
      print("merchant key : "+merchantKey);
      print("app id :"+appId);
      print("app secret :"+appSecret);
      setState(() {});
    } else {
      print(responce.body);
    }
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
      appBar: AppBar(
        centerTitle: false,
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
        title: Text(
          "MOBILE POS",
          style: TextStyle(fontSize: 16),
        ),
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "DETAILS",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Enter your customer's full name, phone number and email address",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 19, color: Colors.black.withOpacity(0.4)),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "FULL NAME*",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.3),
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  errorText: _validateName ? 'Enter full name' : null,
                  prefixIcon: const Icon(
                    FontAwesomeIcons.portrait,
                    size: 16,
                    color: Colors.black45,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "PHONE NUMBER",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.3),
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    FontAwesomeIcons.phone,
                    size: 16,
                    color: Colors.black45,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "E-MAIL ADDRESS",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.3),
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    FontAwesomeIcons.inbox,
                    size: 16,
                    color: Colors.black45,
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    nameController.text.isEmpty
                        ? _validateName = true
                        : _validateName = false;
                  });
                  if (!_validateName) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => CreditCardScreen(merchantKey))));
                  }
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Center(
                    child: Text(
                      "CONTINUE",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
