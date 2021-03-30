import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersipay/dashboard/merchant_panel.dart';
import 'package:fluttersipay/loading_widget.dart';
import 'package:fluttersipay/main_api_data_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:quiver/pattern.dart';

import 'login_repo.dart';

class SecretQuestionScreen extends StatefulWidget {
  String token;

  SecretQuestionScreen(this.token);

  @override
  _SecretQuestionScreenState createState() => _SecretQuestionScreenState();
}

class _SecretQuestionScreenState extends State<SecretQuestionScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  bool showLoad = true;
  List<DropdownMenuItem> _dropDownItems = List();
  String selectedValue = '', answer = '', errorText = '';

  getSecretQuestion() async {
    //widget.token =
   //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjA5OGU1OWIyYjVjZTIyMzg4MDhkMjdmMDljZWUyNTdiZjZiODIzN2M1NjE5M2IxZDAyNmRmZjczYjNkNGVmMDA0ZjBlN2EyOGNmNGI5NDIyIn0.eyJhdWQiOiI5IiwianRpIjoiMDk4ZTU5YjJiNWNlMjIzODgwOGQyN2YwOWNlZTI1N2JmNmI4MjM3YzU2MTkzYjFkMDI2ZGZmNzNiM2Q0ZWYwMDRmMGU3YTI4Y2Y0Yjk0MjIiLCJpYXQiOjE2MDIxNTE0MTcsIm5iZiI6MTYwMjE1MTQxNywiZXhwIjoxNjMzNjg3NDE3LCJzdWIiOiIxOSIsInNjb3BlcyI6W119.xAdLeNrYf1zkZWJ963Xdsohvlqh_4fP4r6eX31Kq7Hrf0rr9GfQKHTSw-i7BS_FNVy_bDxHBBU6qvfhyFC6nZEG7kVyadEjD2TRAKkmcdJW5Yp00lnmu8JnelNquzW0gPNZj6Z0Ydslp4mkS2M_2MogO7sdi-x4PHFq26arlD5C88bdYW4wPIPfebJXSQCrEJqirkYc0uziHIeKRzM5wYk8L0EkTG5kk4SPIttJCq6jZ0ABVvexqe2Ys8rODDGIj4MvLEz21Cw-ngM0DUk2JownSag2VSIg50BqIiO3gWwIlYsiBjLDpHJw3lW4ECvnGFqL1s8KUoK-YdP9LUMXkMef34K3yiu7vR6g0X1_TMritMxt6mu8munzX-UcKwM52NG54U4x5i59p_GpMgWDUPwHfBb8rCIZlp2uQ-Qi5uGOqXbyHJhhhQIGE05P9eYW3bx95uzweVAOFpw2VukIzCdWz0GVatalTtFiWeIL_ZRdNl4oS2X3BhuMBRwb4IYXQf8fxRNl77Ai8_oICQO4uYC40VE4JWO0PCnnNmPldTaXS6wfxYONiEudOAbUePVCS1qmKqMvfY4y2F8pIncMqDP5ZyOYs1Nav8P1jFvB28UkExOj57vjAU5spDZXWZ_gHf3w4RxRclj1KCHSsgd9gevJMUWkcCzAdZ7GA_TA1ra8';
    LoginRepository _loginRepo = LoginRepository();
    MainApiModel model = await _loginRepo.getSecurityQuestion(widget.token);
    setState(() {
      showLoad = false;
    });
    buildDropDownItem(model);
  }

  buildDropDownItem(MainApiModel model) {
    _dropDownItems.add(DropdownMenuItem<String>(
        value: '1', child: Text(model.data['questions']['1'])));
    _dropDownItems.add(DropdownMenuItem<String>(
        value: '2', child: Text(model.data['questions']['2'])));
    _dropDownItems.add(DropdownMenuItem<String>(
        value: '3', child: Text(model.data['questions']['3'])));
    _dropDownItems.add(DropdownMenuItem<String>(
        value: '4', child: Text(model.data['questions']['4'])));
    _dropDownItems.add(DropdownMenuItem<String>(
        value: '5', child: Text(model.data['questions']['5'])));
    setState(() {});
  }

  onClickVerify() async {
   // widget.token =
  //      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjA5OGU1OWIyYjVjZTIyMzg4MDhkMjdmMDljZWUyNTdiZjZiODIzN2M1NjE5M2IxZDAyNmRmZjczYjNkNGVmMDA0ZjBlN2EyOGNmNGI5NDIyIn0.eyJhdWQiOiI5IiwianRpIjoiMDk4ZTU5YjJiNWNlMjIzODgwOGQyN2YwOWNlZTI1N2JmNmI4MjM3YzU2MTkzYjFkMDI2ZGZmNzNiM2Q0ZWYwMDRmMGU3YTI4Y2Y0Yjk0MjIiLCJpYXQiOjE2MDIxNTE0MTcsIm5iZiI6MTYwMjE1MTQxNywiZXhwIjoxNjMzNjg3NDE3LCJzdWIiOiIxOSIsInNjb3BlcyI6W119.xAdLeNrYf1zkZWJ963Xdsohvlqh_4fP4r6eX31Kq7Hrf0rr9GfQKHTSw-i7BS_FNVy_bDxHBBU6qvfhyFC6nZEG7kVyadEjD2TRAKkmcdJW5Yp00lnmu8JnelNquzW0gPNZj6Z0Ydslp4mkS2M_2MogO7sdi-x4PHFq26arlD5C88bdYW4wPIPfebJXSQCrEJqirkYc0uziHIeKRzM5wYk8L0EkTG5kk4SPIttJCq6jZ0ABVvexqe2Ys8rODDGIj4MvLEz21Cw-ngM0DUk2JownSag2VSIg50BqIiO3gWwIlYsiBjLDpHJw3lW4ECvnGFqL1s8KUoK-YdP9LUMXkMef34K3yiu7vR6g0X1_TMritMxt6mu8munzX-UcKwM52NG54U4x5i59p_GpMgWDUPwHfBb8rCIZlp2uQ-Qi5uGOqXbyHJhhhQIGE05P9eYW3bx95uzweVAOFpw2VukIzCdWz0GVatalTtFiWeIL_ZRdNl4oS2X3BhuMBRwb4IYXQf8fxRNl77Ai8_oICQO4uYC40VE4JWO0PCnnNmPldTaXS6wfxYONiEudOAbUePVCS1qmKqMvfY4y2F8pIncMqDP5ZyOYs1Nav8P1jFvB28UkExOj57vjAU5spDZXWZ_gHf3w4RxRclj1KCHSsgd9gevJMUWkcCzAdZ7GA_TA1ra8';
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      setState(() {
        showLoad = true;
      });
      LoginRepository _loginRepo = LoginRepository();
      MainApiModel model = await _loginRepo.setSecurityQuestion(
          selectedValue, answer, widget.token);
      if (model.statusCode == 100) {
        Flushbar(
            title: model.description,
            duration: Duration(seconds: 5));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => MerchantPanelScreen(model, widget.token)),
            (route) => false);
      } else {
        errorText = model.description;
      }
      setState(() {
        showLoad = false;
      });
    }
  }

  Future<bool> popCallback() async {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      SystemNavigator.pop();
    }
  }

  @override
  void initState() {
    getSecretQuestion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: popCallback,
      child: Scaffold(
        key: scaffoldKey,
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
          title: Text(translator.translate("secret_question").toUpperCase()),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 50, 10, 50),
                      child: Text(
                        translator.translate('doNotSecret'),
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(35),
                            color: Colors.grey[400]),
                      ),
                    ),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(200)),
                    Text(
                      translator.translate('secret_question'),
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(20),
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[500]),
                    ),
                    SizedBox(height: 5),
                    DropdownButtonFormField(
                      hint: Text(translator.translate('choose_one')),
                      decoration: InputDecoration(
                          prefixIcon: Icon(FontAwesomeIcons.lock)),
                      items: _dropDownItems,
                      onChanged: (value) {
                        print(value);
                        selectedValue = value;
                      },
                      onSaved: (value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return translator.translate("CHSEQ");
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: translator.translate('answer_here'),
                          prefixIcon: Icon(FontAwesomeIcons.lockOpen)),
                      onSaved: (value) => answer = value,
                      validator: (value) {
                        if (value.isEmpty) {
                          return translator.translate("enterAns");
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          errorText,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
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
