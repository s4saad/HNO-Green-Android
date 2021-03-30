import 'package:flutter/material.dart';
import 'package:fluttersipay/corporate/dashboard/support.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../corporate/dashboard/support.dart';


class nine_nine extends StatefulWidget {
  @override
  _nine_nineState createState() => _nine_nineState();
}

class _nine_nineState extends State<nine_nine> {
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
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Center(
          child: Column(
            children: [
              Image.asset(
                "assets/splash/fail.png",
                height: 200,
                width: 200,
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Transaction has been failed. \nError code / Reason",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.4),
                  fontSize: 18
                ),
              ),
              Text(
                "XX404XX Insufficient Balance",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18
                ),
              ),
              Expanded(child: SizedBox()),
              InkWell(
                onTap: (){
//                  Navigator.push(context, MaterialPageRoute(builder: (
//                          (context)=> nine_eight()
//                  )));
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black.withOpacity(0.2)
                      )
                  ),
                  child: Center(
                    child: Text(
                      "RE-ENTER CARD INFORMATION",
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

                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.blue
                  ),
                  child: Center(
                    child: Text(
                      "CANCEL PAYMENT",
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
