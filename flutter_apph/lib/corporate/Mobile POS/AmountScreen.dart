import 'package:flutter/material.dart';
import 'package:fluttersipay/corporate/Mobile%20POS/InstallmentScreen.dart';
import 'package:fluttersipay/corporate/dashboard/support.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'CreditCardScreen.dart';


class AmountScreen extends StatefulWidget {

  final String merchantKey,card;

  AmountScreen(this.merchantKey,this.card);

  @override
  _nine_threeState createState() => _nine_threeState();
}

class _nine_threeState extends State<AmountScreen> {
  TextEditingController amountController = new TextEditingController();

  List<String> list = ["TRY", "USD", "EUR"];

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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "AMOUNT",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Please enter the transaction amount.",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 19,
                    color: Colors.black.withOpacity(0.4)
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "AMOUNT",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.3),
                    fontWeight: FontWeight.bold,
                    fontSize: 14
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "0.00",
                        prefixIcon: const Icon(
                          FontAwesomeIcons.solidFlag,
                          size: 16,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black.withOpacity(0.4),
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "TRY",
                          style: TextStyle(
                            fontSize: 18
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 16,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 60,
              ),
              InkWell(
                onTap: (){
                  print(widget.merchantKey);
                Navigator.push(context, MaterialPageRoute(builder: (
                        (context)=> InstallmentScreen(widget.merchantKey,widget.card,amountController.text.toString())
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
