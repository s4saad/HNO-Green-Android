import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttersipay/corporate/dashboard/merchant.dart';
import 'package:fluttersipay/corporate/dashboard/merchant_repo.dart';
import 'package:fluttersipay/corporate/dashboard/providers/merchant_panel_dashboard_provider.dart';
import 'package:fluttersipay/dashboard/merchant_panel.dart';
import 'package:fluttersipay/login_screens/password_verify_second.dart';
import 'package:fluttersipay/main_api_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttersipay/corporate/global_data.dart' as gd;
import 'login_screens/dummyScreen.dart';
import 'login_screens/login_main.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController animationController;
  Animatable<Color> back_title = TweenSequence<Color>([
    TweenSequenceItem(
      weight: 1,
      tween: ColorTween(
        begin: Colors.black,
        end: Colors.white,
      ),
    ),
  ]);

  Animatable<Color> background = TweenSequence<Color>([
    TweenSequenceItem(
      weight: 1,
      tween: ColorTween(
        begin: Colors.white,
        end: Colors.blue,
      ),
    ),
  ]);

  var remem,
      email = "",
      pass = "",
      phone = "",
      type,
      passCor = "",
      countryCode = '',
      countryFlagUri = '';
  bool isIndividual = false;
  String token = '';
  var _visible = true;
String phone2;
  @override
  dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 2),
    );
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();

    fun();
  }

  fun() async {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        remem = prefs.getBool("remember") ?? false;
        // type = prefs.getBool("type");
         phone2= prefs.getString("phone2") ?? "";
        phone = prefs.getString("phone") ?? "";
        countryCode = prefs.getString("country_code") ?? "";
        countryFlagUri = prefs.getString("country_flagUri") ?? "";
        email = prefs.getString("email") ?? "";
        isIndividual = prefs.getBool("isIndividual") ?? false;
        token = prefs.getString("token") ?? '';
pass=prefs.getString("password")??"";
//////passCor=prefs.getString("passCor")??"";
//type=prefs.getString("type")??false;
      });

//individual
    });
  }

  startTime() async {
    var _duration = new Duration(seconds: 2,milliseconds: 1500);

    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async {
/*   SharedPreferences prefs=await SharedPreferences.getInstance();
 
if(/* prefs.getBool("remember")==true */1==0){  
  MerchantMainRepository objj;
  MerchantPanelProvider obj;  
  MainApiModel userData;
  
objj=new MerchantMainRepository(prefs.getString("token").toString()); 

//obj.setValues(objj, userData);
  var dat= prefs.getString("data");
 var data=json.decode(dat.toString());
userData=new MainApiModel(int.parse(prefs.getString("code").toString())
, prefs.getString("desc"), dat);
obj =new MerchantPanelProvider( objj, userData);






print(data.toString());



                                      Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(
                                              builder: (context) =>
                                              prefs.getBool("type")==true
                                                  ? MerchantPanelScreen(
                                userData, prefs.getString("token"))
                                                  : CorporateMerchantPanelScreen(
                                                      userData,  prefs.getString("token"))),
                                          (route) => false);

}else{





 */

    print(this.remem.toString() +
        "--1--  " +
        this.email.toString() +
        "  --2--" +
        this.pass.toString() +
        "  --3--  " +
        this.phone2.toString() +
        " --4-- " +
        this.passCor.toString()
    + isIndividual.toString()+"  "+this.token.isEmpty.toString()
    );
//5337058020
    if(//1==2
    isIndividual && token.isNotEmpty && phone2!=null
    ){
      gd.isIndividual=true;
      gd.userToken="Bearer "+token;
print("%%%%%%%%%%%%%%"+this.phone+"%%%%%%%%%%%%%%%%%% "+this.countryCode.toString());
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
            VerifyPasswordSecondScreen(
           // this.countryCode+this.phone,
phone2,
                pass,'en',
                token:this.token,
            exit:true
            ),
      ));

    }else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
            MyLoginPage(
                this.remem,
                this.email,
                "",
                this.phone,
                this.type,
                "",
                this.countryCode,
                this.countryFlagUri),
      ));
    }
    /*
         Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context)=> dummy(),
     ));
*/
    /* 
}
 
  */
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ColorFiltered(
          child: Image.asset(
            "assets/splash/Splash.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          colorFilter: ColorFilter.mode(
              background
                  .evaluate(AlwaysStoppedAnimation(animationController.value)),
              BlendMode.color),
        ),
        Center(
          child: new Image.asset(
            'assets/splash/logo.png',
            width: animation.value * 250,
            height: animation.value * 250,
            color: back_title
                .evaluate(AlwaysStoppedAnimation(animationController.value)),
          ),
        )
      ],
    );
  }
}
