import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'DemoFaceFinger.dart';
import 'LocalAuthservices/service_locator.dart';
import 'SplashScreen.dart';
//267 261 271 270
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  LIST_OF_LANGS = ["tr", "en"];
  LANGS_DIR = 'assets/langs/';
  await translator.init();

  runApp(
    LocalizedApp(
      child: Main(),
    ),
  );
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SiPay',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      localizationsDelegates: translator.delegates,
      locale: translator.locale,
      supportedLocales: translator.locals(),
    );
  }
}

/*
rajibcuetcse@gmail.com
Nop@ss1234
 */
