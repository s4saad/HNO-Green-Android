import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersipay/corporate/global_data.dart';
import 'package:fluttersipay/dashboard/merchant_panel.dart';
import 'package:fluttersipay/loading_widget.dart';
import 'package:fluttersipay/login_screens/kyc_verification.dart';
import 'package:fluttersipay/main_api_data_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:fluttersipay/utils/api_endpoints.dart' as points;
import 'package:dio/dio.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttersipay/corporate/global_data.dart' as gd;
class emailPass extends StatefulWidget {
  MainApiModel mainApiModel;
  dynamic token = "";
  bool isKYC = false;

  emailPass(this.mainApiModel, this.token, {this.isKYC});

  @override
  _emailPassState createState() => _emailPassState();
}

class _emailPassState extends State<emailPass> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  String password, confirmPassword, errorText = '', email;
  bool showLoad = false;

  Future<bool> popCallback() async {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Email Pass Main Api Model date: " +
        widget.mainApiModel.data.toString().toString());
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
          title: Text(
            translator.translate('PSWDEML'),
            style: TextStyle(fontSize: 17),
          ),
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
                      padding: const EdgeInsets.fromLTRB(16, 50, 16, 50),
                      child: Text(
                        translator.translate('updatePolicy'),
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(35),
                            color: Colors.grey[400]),
                      ),
                    ),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: translator.translate("email"),
                        prefixIcon: Icon(Icons.email),
                        counterText: "",
                      ),
                      keyboardType: TextInputType.emailAddress,
                      inputFormatters: <TextInputFormatter>[
                        //  FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (value) {
                        if (value.isEmpty) {
                          return translator.translate("enterEmail");
                        } else if (!value.contains(".") &&
                            !value.contains("@") &&
                            !value.contains("com")) {
                          return translator.translate("emailValidate");
                        }
                        /* else if (!isNumeric(value)) {
                          return 'Only number allow.';
                        }*/
                        return null;
                      },
                      onSaved: (value) => password = value,
                      //    maxLength: 6,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      obscureText: true,
                      controller: passController,
                      decoration: InputDecoration(
                        hintText: translator.translate("pass"),
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
                        }
                        /* else if (!isNumeric(value)) {
                          return 'Only number allow.';
                        }*/
                        return null;
                      },
                      onSaved: (value) => email = value,
                      maxLength: 6,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: translator.translate("verify_pass"),
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
                        }
                        /* else if (!isNumeric(value)) {
                          return 'Only number allow.';
                        }*/
                        return null;
                      },
                      onSaved: (value) => confirmPassword = value,
                      maxLength: 6,
                    ),
                    SizedBox(height: 10),
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
                        onPressed: () {
                          print(widget.mainApiModel.data.toString());
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            /*   print(
                                widget.mainApiModel.data["user"]["phone"].toString()+
                                this.email.toString() +
                                this.password.toString() +
                                this.confirmPassword.toString()
                                 );*/
                            Dio dio = Dio();

                            String phone = "";
                            if (!widget.isKYC) {
                              phone = widget.mainApiModel.data["inputs"]["phone"]
                                  .toString();
                            } else {
                              phone = widget.mainApiModel.data["inputs"]["phone"]
                                  .toString();
                            }
                            setState(() {
                              showLoad = true;
                            });
                            dio.post(
                                points.APIEndPoints
                                    .kApiIndividualChangeEmailPasswordEndPoint,
                                /*options: Options(headers: {
                                  "Authorization": "Bearer " + widget.token,
                                  "Accept": "application/json"
                                }),*/
                                data: {
                                  "phone": phone,
                                  "password": passController.text.toString(),
                                  "verify_password":
                                      passController.text.toString(),
                                  "email": emailController.text.toString(),
                                  "app_lang": translator.currentLanguage
                                }).then((value) async {
                              setState(() {
                                showLoad = false;
                              });
                              print(">   <>>><<  " + value.data.toString());
                              if (value.data["statuscode"] == 100) {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setString("token",
                                    value.data["data"]["token"].toString());
                                gd.userToken="Bearer "+value.data["data"]["token"].toString();
                                widget.isKYC
                                    ? Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                KYCUserVerificationScreen(
                                                  widget.mainApiModel,
                                                  token: value.data["data"]
                                                          ["token"]
                                                      .toString(),
                                                )),
                                        (route) => false)
                                    : Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MerchantPanelScreen(
                                                    widget.mainApiModel,
                                                    value.data["data"]["token"])),
                                        (route) => false);
                              } else {
                                List<String> da =
                                    value.data["data"]['errors']['email'] != null
                                        ? value.data["data"]['errors']['email']
                                            .cast<String>()
                                        : List();
                                List<String> da1 = value.data["data"]['errors']
                                            ['password'] !=
                                        null
                                    ? value.data["data"]['errors']['password']
                                        .cast<String>()
                                    : List();

                                List<String> da2 =
                                    value.data["data"]['errors']['phone'] != null
                                        ? value.data["data"]['errors']['phone']
                                            .cast<String>()
                                        : List();

                                da.addAll(da1);
                                da.addAll(da2);
                                setState(() {
                                  this.errorText = da.toString().replaceAll("[", "").replaceAll("]", '');
                                });
                              }
                            });

                            /*    http.post(
                              points.APIEndPoints.kApiIndividualChangeEmailPasswordEndPoint,
                              headers:{
                                "Authorization":"Bearer "+widget.token,

                                "Accept":"application/json"


                              },
                                body: {

                                "phone":widget.mainApiModel.data["phone"].toString(),
                                "password":this.password.toString(),
                                "verify_password":this.confirmPassword.toString(),
                                "email":this.email.toString(),
                                "app_lang":"en"//translator.currentLanguage

                            }


                            ).then((value) {

                              print(value.body.toString());

                          }

                            );*/
                          }
                        },
                        //onClickVerify(),
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
