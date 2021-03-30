import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersipay/login_screens/login_registration.dart';
import 'package:fluttersipay/utils/constants.dart';
import 'package:fluttersipay/utils/custom_text_style.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class NoAccountWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(child: Text(translator.translate("haveAccount"))),
        Container(
          child: FlatButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserRegistrationScreen()));
            },
            child: Text(
              translator.translate("registerHere"),
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class IndividualWidget extends StatelessWidget {
  final loginProvider, countryCode;

  IndividualWidget(this.loginProvider, this.countryCode);

  @override
  Widget build(BuildContext context) {
    print("code>>>" + countryCode);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(0),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(left: 0.0, right: 10.0),
            child: !loginProvider.showIndividualLoginErrorMessage
                ? Container(
                    child: Text(
                      '',
                      style: TextStyle(
                        color: Colors.black38,
                      ),
                    ),
                    height: 0,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      /*             GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                   builder: (context) =>
                                      UserRegistrationScreen()));
                        },
                        child: Text(
                          'register',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ) */
                    ],
                  ),
          ),
        ),
        Container(
          width: 500,
          child: Padding(
            padding: EdgeInsets.only(),
            child: TextField(
              inputFormatters: [
                countryCode == "90"
                    ? LengthLimitingTextInputFormatter(10)
                    : LengthLimitingTextInputFormatter(12)
              ],
              style: TextStyle(
                  color: !loginProvider.showIndividualLoginErrorMessage
                      ? Colors.black
                      : Colors.red),
              controller: loginProvider.telephoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: translator.translate("phoneNo"),
                hintStyle: CustomTextStyle.formField(context),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: !loginProvider.showIndividualLoginErrorMessage
                            ? Colors.black38
                            : Colors.red,
                        width: 1.0)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: !loginProvider.showIndividualLoginErrorMessage
                            ? Colors.black38
                            : Colors.red,
                        width: 1.0)),

                /*   prefixIcon: !loginProvider.showIndividualLoginErrorMessage

                      ? const Icon(

                          Icons.phone,

                          color: Colors.black38,

                        )

                      : const Icon(

                          Icons.cancel,

                          color: Colors.red,

                        ), */
              ),

              /*    inputFormatters: [maskFormatter], */

              obscureText: false,
            ),
          ),
        )
      ],
    );
  }
}

class CorporateWidget extends StatelessWidget {
  final loginProvider;

  CorporateWidget(this.loginProvider);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginProvider.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: ScreenUtil.getInstance().setHeight(30),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: !loginProvider.showCorporateLoginErrorMessage
                  ? Container(
                      child: Text(
                        '',
                        style: TextStyle(
                          color: Colors.black38,
                        ),
                      ),
                      height: 0,
                    )
                  : Text(
                      translator.translate("infouEntred"),
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(),
              child: TextFormField(
                controller: loginProvider.emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: translator.translate("urEmail"),
                  errorText:
                      loginProvider.showCorporateLoginErrorMessage ? '' : null,
                  hintStyle: CustomTextStyle.formField(context),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: !loginProvider.showCorporateLoginErrorMessage
                              ? Colors.black38
                              : Colors.red,
                          width: 1.0)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: !loginProvider.showCorporateLoginErrorMessage
                              ? Colors.black38
                              : Colors.red,
                          width: 1.0)),
                  prefixIcon: !loginProvider.showCorporateLoginErrorMessage
                      ? const Icon(
                          Icons.email,
                          color: Colors.black38,
                        )
                      : const Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                ),
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
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtil.getInstance().setHeight(30),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(),
              child: TextFormField(
                style: TextStyle(color: Colors.black38),
                controller: loginProvider.passwordController,
                decoration: InputDecoration(
                  hintText: translator.translate("urPass"),
                  hintStyle: CustomTextStyle.formField(context),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.black38, width: 1.0)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.black38, width: 1.0)),
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.black38,
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return translator.translate('enterPassword');
                  }
                  return null;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
