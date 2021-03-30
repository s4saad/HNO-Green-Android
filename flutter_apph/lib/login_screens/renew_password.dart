import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersipay/dashboard/merchant_panel.dart';
import 'package:fluttersipay/login_screens/login_repo.dart';
import 'package:fluttersipay/login_screens/secret_question_screen.dart';
import 'package:fluttersipay/main_api_data_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../loading_widget.dart';

class RenewPassword extends StatefulWidget {
  MainApiModel mainApiModel;

  RenewPassword({this.mainApiModel});

  @override
  _RenewPasswordState createState() => _RenewPasswordState();
}

class _RenewPasswordState extends State<RenewPassword> {
  final TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  String password, confirmPassword, errorText = '';
  bool showLoad = false;

  onClickVerify() async {
    setState(() {
      errorText = '';
    });
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      setState(() {
        showLoad = true;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = await prefs.getString("token") ?? '';
      LoginRepository _loginRepo = LoginRepository();
      MainApiModel model =
          await _loginRepo.renewPassword(password, confirmPassword, token);
      setState(() {
        showLoad = false;
      });
      if (model.statusCode == 100) {
        print(model.data.toString());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('password', password.toString());

        if (widget.mainApiModel == null) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SecretQuestionScreen(token)));
        } else {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  MerchantPanelScreen(widget.mainApiModel, token)));
        }
      } else {
        if (model.data['errors'] != null) {
          List<String> da = model.data['errors']['new_password'] != null
              ? model.data['errors']['new_password'].cast<String>()
              : List();
          setState(() {
            errorText =
                da.toString().isEmpty ? model.description : da.toString();
          });
        } else {
          setState(() {
            errorText = model.description;
          });
        }
      }
    }
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  Future<bool> popCallback() async {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1304, allowFontScaling: true)
          ..init(context);
    return WillPopScope(
      onWillPop: popCallback,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  popCallback();
                },
              );
            },
          ),
          centerTitle: true,
          title: Text(translator.translate("RENEWPSWD").toUpperCase()),
          flexibleSpace: Image(
            image: AssetImage('assets/appbar_bg.png'),
            height: 100,
            fit: BoxFit.fitWidth,
          ),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.only(right: 20.0),
              icon: Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
              },
            )
          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 50, 10, 50),
                      child: Text(
                        translator.translate('updatePolicy'),
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(35),
                            color: Colors.grey[400]),
                      ),
                    ),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(290)),
                    TextFormField(
                      obscureText: true,
                      controller: passController,
                      decoration: InputDecoration(
                        hintText: translator.translate("pass").toUpperCase(),
                        prefixIcon: Icon(FontAwesomeIcons.lock),
                        counterText: "",
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (value) {
                        if (value.isEmpty) {
                          return translator.translate("enterPassword");
                        } else if (value.length < 6) {
                          return translator.translate("PSWDLEN");
                        } else if (!isNumeric(value)) {
                          return translator.translate("only_number");
                        }
                        return null;
                      },
                      onSaved: (value) => password = value,
                      maxLength: 6,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText:
                              translator.translate("verify_pass").toUpperCase(),
                          prefixIcon: Icon(Icons.refresh),
                          counterText: ''),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (value) {
                        if (value.isEmpty) {
                          return translator.translate("enterPassword");
                        } else if (value.length < 6) {
                          return translator.translate("PSWDLEN");
                        } else if (passController.text != value) {
                          return translator.translate("PSWDNOTMTCH");
                        } else if (!isNumeric(value)) {
                          return translator.translate("only_number");
                        }
                        return null;
                      },
                      onSaved: (value) => confirmPassword = value,
                      maxLength: 6,
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            errorText,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(100)),
                    Container(
                      width: ScreenUtil.getInstance().setWidth(690),
                      child: FlatButton(
                        onPressed: () => onClickVerify(),
                        color: Colors.blue,
                        disabledColor: Colors.blue,
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          translator.translate("verify_btn"),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            LoadingWidget(
              isVisible: showLoad,
            )
          ],
        ),
      ),
    );
  }
}
