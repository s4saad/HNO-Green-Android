import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersipay/dashboard/providers/security_settings_provider.dart';
import 'package:fluttersipay/dashboard/security_otp_screen.dart';
import 'package:fluttersipay/utils/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart' as translator1;
import '../base_main_repo.dart';
import '../loading_widget.dart';
import '../main_api_data_model.dart';
import 'Live_support.dart';

class change_email extends StatefulWidget {
  final BaseMainRepository mainRepository;

  change_email(this.mainRepository);
  @override
  _change_emailState createState() => _change_emailState();
}

class _change_emailState extends State<change_email> {
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
          Text(translator.translate("changeMail").toUpperCase()),
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
                              .translate("VerifyYourCurrentPasswordToChangeYourE-mailaddress"),
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
                          controller: snapshot.currentPasswordEmail,
                          decoration: InputDecoration(
                              errorText:
                              snapshot.currentPasswordEmailErrorMessage,
                              hintText:translator.translate("curntPass"),
                              icon: Icon(Icons.lock)
                          ),
                          obscureText: true,
                        ),
                        SizedBox(
                          height:
                          ScreenUtil.getInstance().setHeight(20),
                        ),
                        TextFormField(
                          controller: snapshot.newEmail,
                          decoration: InputDecoration(
                              errorText: snapshot.newEmailErrorMessage,
                              hintText: translator.translate("newEmailHint"),
                              icon: Icon(Icons.replay)
                          ),
                        ),
                        SizedBox(
                          height:
                          ScreenUtil.getInstance().setHeight(200),
                        ),
                        InkWell(
                          onTap: (){
                            snapshot.changeEmail((MainApiModel emailModel) {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SecurityOTPScreen(
                                      SecuritySettingsTypes.Email,
                                      emailModel.data['user']['phone'],
                                      emailModel,
                                      widget.mainRepository)));
                            }, (msg) async{
                              var translation = await translator1.GoogleTranslator().translate(msg, to: 'pl');

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
                                translator.translate("changeMail").toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17
                                ),
                              ),
                            ),
                          ),
                        )
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
        )
      ),
    );
  }
}
