import 'package:dokanamar_driver/constant.dart';
import 'package:dokanamar_driver/screens/homeScreen.dart';
import 'package:dokanamar_driver/screens/signUp.dart';
import 'package:dokanamar_driver/screens/splashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: primaryColor,
        iconTheme: IconThemeData(
          color: blackColor
        )
      ),
      home: splashScreen(),
    );
  }
}
