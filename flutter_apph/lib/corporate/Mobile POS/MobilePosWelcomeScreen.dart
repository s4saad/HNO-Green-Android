import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttersipay/corporate/dashboard/support.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'MobilePosDetailScreen.dart';


class MobilePosWelcomeScewwn extends StatefulWidget {
  @override
  _nine_oneState createState() => _nine_oneState();
}

class _nine_oneState extends State<MobilePosWelcomeScewwn> {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.3),
              child: Image.asset(
                "assets/splash/mobile_pos.png",
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25,right: 25),
              child: Text(
                "Are you ready to turn your phone into a POS device?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.black.withOpacity(0.4)
                ),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (
                    (context)=> MobilePosDetailsScreen()
                )));
              },
              child: Container(
                margin: EdgeInsets.only(left: 25,right: 25),
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.blue
                ),
                child: Center(
                  child: Text(
                    "NEW PAYMENT",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
              child: Divider(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25,right: 25),
              child: Text(
                "HOW TO?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.blue,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
