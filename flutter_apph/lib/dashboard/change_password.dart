import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersipay/base_main_repo.dart';
import 'package:fluttersipay/dashboard/providers/security_settings_provider.dart';
import 'package:fluttersipay/dashboard/security_otp_screen.dart';
import 'package:fluttersipay/utils/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart' as translator1;
import '../loading_widget.dart';
import '../main_api_data_model.dart';
import 'Live_support.dart';

class change_Password extends StatefulWidget {

  final BaseMainRepository mainRepository;

  change_Password(this.mainRepository);


  @override
  _change_PasswordState createState() => _change_PasswordState();
}

class _change_PasswordState extends State<change_Password> {
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

    return ChangeNotifierProvider(
      create: (context) => SecuritySettingsProvider(
          widget.mainRepository,
          TextEditingController(),
          TextEditingController(),
          TextEditingController(),
          TextEditingController(),
          TextEditingController()),
      child: Scaffold(
        appBar: AppBar(
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
          centerTitle: true,
          title:
          Text(translator.translate("changePassword").toUpperCase()),
          flexibleSpace: Image(
            image: AssetImage('assets/appbar_bg.png'),
            height: 100,
            fit: BoxFit.fitWidth,
          ),
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
        ),
        body: Consumer<SecuritySettingsProvider>(
          builder: (context,snapshot,_){
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          translator
                              .translate("Newpasswordshouldbe6digits"),
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.4),
                              fontSize: 17
                          ),
                        ),
                        SizedBox(
                          height:
                          ScreenUtil.getInstance().setHeight(50),
                        ),
                        TextFormField(
                          controller: snapshot.currentPassword,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              errorText: snapshot.currentPasswordErrorMessage,
                              hintText: translator.translate("curntPass"),
                              icon: Icon(Icons.lock_open)
                          ),
                          obscureText: true,
                        ),
                        SizedBox(
                          height:
                          ScreenUtil.getInstance().setHeight(20),
                        ),
                        TextFormField(
                          controller: snapshot.newPassword,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              errorText: snapshot.newPasswordErrorMessage,
                              hintText: translator.translate("newPass"),
                              icon: Icon(Icons.lock)
                          ),
                          obscureText: true,
                        ),
                        SizedBox(
                          height:
                          ScreenUtil.getInstance().setHeight(20),
                        ),
                        TextFormField(
                          controller: snapshot.confirmPassword,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              errorText: snapshot.confirmPasswordErrorMessage,
                              hintText: translator.translate("ConfPass"),
                              icon: Icon(Icons.replay)
                          ),
                          obscureText: true,
                        ),

                        SizedBox(
                          height:
                          ScreenUtil.getInstance().setHeight(70),
                        ),
                        InkWell(
                          onTap: (){
                            snapshot.changePassword(
                                    (MainApiModel passwordModel) {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SecurityOTPScreen(
                                          SecuritySettingsTypes.Password,
                                          passwordModel.data['user']['phone'],
                                          passwordModel,
                                          widget.mainRepository)));
                                }, (description) async{
                              var translation = await translator1.GoogleTranslator().translate(description, to: 'en');

                              Flushbar(
                                title: translator.translate("fail"),
                                message: translation.toString(),
                                duration: Duration(seconds: 3),
                              )..show(context);
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.blue
                            ),
                            child: Center(
                              child: Text(
                                translator.translate("changePassbtn").toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                LoadingWidget(
                  isVisible: snapshot.showLoad ?? false,
                ),
              ],

            );
          },
        ),
      ),
    );
  }
}
