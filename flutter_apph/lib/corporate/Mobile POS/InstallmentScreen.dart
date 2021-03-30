import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttersipay/corporate/dashboard/support.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttersipay/utils/api_endpoints.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../corporate/dashboard/support.dart';
import '../global_data.dart';
import '9.6.dart';

class InstallmentScreen extends StatefulWidget {

  final String merchantKey,card,amount;

  InstallmentScreen(this.merchantKey,this.card,this.amount);
  @override
  _nine_fiveState createState() => _nine_fiveState();
}

class _nine_fiveState extends State<InstallmentScreen> {

  TextEditingController nameController = new TextEditingController();
  bool _validateName = false;
  SharedPreferences prefs;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    prefs = await SharedPreferences.getInstance();

//    print("Token>>>>>" + prefs.getString("token"));
    print("Input_field"+widget.card+widget.amount+widget.merchantKey);
    Map data = {
      'credit_card': widget.card,
      'amount': widget.amount,
      'currency_code': 'TRY',
      'merchant_key':widget.merchantKey
    };
    var jsonData = null;
    var responce = await http.post(
        APIEndPoints.kBaseCorporateAPIEndPointCCPayment,
        body: data,
        headers: {
          "Accept": "application/json",
          "Authorization": userToken,

        });
//
    if (responce.statusCode == 200) {
      print(responce.body);
      jsonData = json.decode(responce.body);

      setState(() {});
    } else {
      print(responce.body);
    }
  }

  @override
  Widget build(BuildContext context) {
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
          "INSTALLMENTS",
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
                "INSTALLMENTS",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.3),
                    fontWeight: FontWeight.bold,
                    fontSize: 14
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    FontAwesomeIcons.chartPie,
                    color: Colors.black.withOpacity(0.4),
                  ),
                  Text(
                    "SINGLE PAYMENT",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "1X1,00TRY",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black.withOpacity(0.4),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
                child: Divider(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (
                          (context)=> nine_six()
                  )));
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.blue
                  ),
                  child: Center(
                    child: Text(
                      "CONTINUE",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                      ),
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
