import 'package:flutter/material.dart';
import 'package:dokanamar_driver/constant.dart';

import 'onBoarding.dart';

class splashScreen extends StatefulWidget {
  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(
        seconds: 3
    ),(){
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => onBoarding()
      ));
    }
    );

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/splash.png"
            ),
            fit: BoxFit.cover
          )
        ),
      ),
    );
  }
}
