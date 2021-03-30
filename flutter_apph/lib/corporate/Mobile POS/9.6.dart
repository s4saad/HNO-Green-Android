import 'package:flutter/material.dart';
import 'package:fluttersipay/dashboard/Live_support.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../corporate/dashboard/support.dart';
import '9.7.dart';


class nine_six extends StatefulWidget {
  @override
  _nine_sixState createState() => _nine_sixState();
}

class _nine_sixState extends State<nine_six> {
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
          "PRODUCT SUMMARY",
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
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Full Name",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.4),
                      fontSize: 15
                    ),
                  ),
                  Text(
                    "SUKRU OZAN EZER",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      fontWeight: FontWeight.w500
                    ),
                  ),

                ],
              ),

            ),
            SizedBox(
              height: 30,
              child: Divider(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Email",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.4),
                        fontSize: 15
                    ),
                  ),
                  Text(
                    "eso@esports@gmail.com",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),
                  ),

                ],
              ),

            ),
            SizedBox(
              height: 30,
              child: Divider(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Phone Number",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.4),
                        fontSize: 15
                    ),
                  ),
                  Text(
                    "+905558923117",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),
                  ),

                ],
              ),

            ),
            SizedBox(
              height: 30,
              child: Divider(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Amount",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.4),
                        fontSize: 15
                    ),
                  ),
                  Text(
                    "1,00 TRY",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),
                  ),

                ],
              ),

            ),
            SizedBox(
              height: 30,
              child: Divider(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Fee",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.4),
                        fontSize: 15
                    ),
                  ),
                  Text(
                    "0,01 TRY",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),
                  ),

                ],
              ),

            ),
            SizedBox(
              height: 30,
              child: Divider(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Installments",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.4),
                        fontSize: 15
                    ),
                  ),
                  Text(
                    "1",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),
                  ),

                ],
              ),

            ),
            SizedBox(
              height: 30,
              child: Divider(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (
                        (context)=> nine_seven()
                )));
              },
              child: Container(
                margin: EdgeInsets.only(left: 25.0, right: 25),
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
    );
  }
}
