import 'package:flutter/material.dart';
import 'package:fluttersipay/corporate/dashboard/support.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:signature/signature.dart';
import '../corporate/dashboard/support.dart';
import '9.8.dart';

class nine_seven extends StatefulWidget {
  @override
  _nine_sevenState createState() => _nine_sevenState();
}

class _nine_sevenState extends State<nine_seven> {

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.blue,
  );

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
          "CUSTOMER SIGNATURE",
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .width * 0.8,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1)
                ),
                child: Signature(
                  controller: _controller,
                  height: MediaQuery
                      .of(context)
                      .size
                      .width * 0.8,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  backgroundColor: Colors.black.withOpacity(0.1)
                ),
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "By signing here, you agree to the ",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.4),
                        fontSize: 18
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: "terms of use ",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18
                          )
                      ),
                      TextSpan(
                          text: "and ",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.4),
                          )
                      ),
                      TextSpan(
                          text: "privacy policy",
                          style: TextStyle(
                            color: Colors.blue,
                          )
                      ),
                    ]
                )
            ),
            Text(
              "Customer signature confirming the transaction",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.4),
                  fontSize: 18
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (
                        (context) => nine_eight()
                )));
              },
              child: Container(
                height: 50,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                    color: Colors.blue
                ),
                child: Center(
                  child: Text(
                    "COMPLETE",
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
