import 'package:flutter/material.dart';
import 'package:fluttersipay/corporate/Mobile%20POS/AmountScreen.dart';
import 'package:fluttersipay/corporate/dashboard/support.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../corporate/dashboard/support.dart';
import 'InstallmentScreen.dart';

class CreditCardScreen extends StatefulWidget {

  final String merchantKey;
  CreditCardScreen(this.merchantKey);

  @override
  _nine_fourState createState() => _nine_fourState();
}

class _nine_fourState extends State<CreditCardScreen> {
  TextEditingController cardController = new TextEditingController();

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
          "CARD DETAILS",
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
                "Installment options appear on the next page",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.black.withOpacity(0.4)
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "CARD NUMBER",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.3),
                    fontWeight: FontWeight.bold,
                    fontSize: 14
                ),
              ),
              TextFormField(
                controller: cardController,
                decoration: InputDecoration(
                  hintText: "_ _ _ _  _ _ _ _  _ _ _ _  _ _ _ _",
                  prefixIcon: const Icon(
                    FontAwesomeIcons.hashtag,
                    size: 16,
                    color: Colors.black45,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "EXPIRY DATE",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.3),
                            fontWeight: FontWeight.bold,
                            fontSize: 14
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width* 0.4,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "_ _ / _ _",
                            prefixIcon: const Icon(
                              FontAwesomeIcons.hashtag,
                              size: 16,
                              color: Colors.black45,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: SizedBox()),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "CVV",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.3),
                            fontWeight: FontWeight.bold,
                            fontSize: 14
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width* 0.4,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "_ _ _",
                            prefixIcon: const Icon(
                              FontAwesomeIcons.hashtag,
                              size: 16,
                              color: Colors.black45,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset("assets/splash/cc.png"),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (
                          (context)=> AmountScreen(widget.merchantKey,cardController.text.toString())
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
      )
    );
  }
}
