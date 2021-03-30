import 'package:flutter/material.dart';
import 'package:fluttersipay/corporate/dashboard/support.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../corporate/dashboard/support.dart';
import '9.9.dart';

class nine_eight extends StatefulWidget {
  @override
  _nine_eightState createState() => _nine_eightState();
}

class _nine_eightState extends State<nine_eight> {
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
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/splash/succ.png",
                height: 200,
                width: 200,
              ),
              Text(
                "Transaction has been completed \nsuccessfully.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 18
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Transaction ID",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.4),
                        fontSize: 18
                    ),
                  ),
                  Text(
                    "#023942",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
                child: Divider(
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Paid Amount",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.4),
                        fontSize: 18
                    ),
                  ),
                  Text(
                    "1,01 TRY",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
                child: Divider(
                ),
              ),
              InkWell(
                onTap: (){
//                  Navigator.push(context, MaterialPageRoute(builder: (
//                          (context)=> nine_eight()
//                  )));
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black.withOpacity(0.2)
                      )
                  ),
                  child: Center(
                    child: Text(
                      "DOWNLOAD RECEIPT",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
//                  Navigator.push(context, MaterialPageRoute(builder: (
//                          (context)=> nine_eight()
//                  )));
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black.withOpacity(0.2)
                      )
                  ),
                  child: Center(
                    child: Text(
                      "NEW PAYMENT",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (
                          (context)=> nine_nine()
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
                      "DASHBOARD",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500
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
