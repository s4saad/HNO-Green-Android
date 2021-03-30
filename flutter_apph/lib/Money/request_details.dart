import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersipay/Money/providers/request_details_provider.dart';
import 'package:fluttersipay/base_main_repo.dart';
import 'package:fluttersipay/dashboard/Live_support.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:fluttersipay/dashboard/drawerMenu.dart';
class MoneyTransferRequestDetailsScreen extends StatefulWidget {
  final String id;
  final String type;
  final BaseMainRepository baseRepo;
  MoneyTransferRequestDetailsScreen(this.baseRepo, this.id, this.type);
  @override
  _MoneyTransferRequestDetailsScreenState createState() =>
      _MoneyTransferRequestDetailsScreenState();
}

class _MoneyTransferRequestDetailsScreenState
    extends State<MoneyTransferRequestDetailsScreen> {
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
        create: (context) => MoneyTransferRequestDetailsProvider(
            widget.baseRepo, widget.id, widget.type),
        child: Scaffold(

            //drawer: DrawerMenu().getDrawer,
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
              title: Text( translator.translate("monReq")),
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
                          builder: (context) =>
                              Live_Support(),
                        ));

                  },
                )
              ],
            ),
            body: Consumer<MoneyTransferRequestDetailsProvider>(
                builder: (context, snapshot, _) {
                  return Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              child: new ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount:
                                snapshot.userTransactionsDetailsList().length,
                                primary: true,
                                itemBuilder: (BuildContext content, int index) {
                                  return detailsList(
                                      title: snapshot
                                          .userTransactionsDetailsList()[index]
                                      ["title"],
                                      value: snapshot
                                          .userTransactionsDetailsList()[index]
                                      ["value"]);
                                },
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Visibility(
                              visible: !snapshot.transactionNotFound ?? true,
                              child: Padding(
                                padding: EdgeInsets.only(left: 30.0, right: 30.0),
                                child: Container(
                                  child: FlatButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    color: Colors.blue,
                                    disabledColor: Colors.blue,
                                    padding: EdgeInsets.all(15.0),
                                    child: Text(
                                      translator.translate("transactionsList")[7],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  width: ScreenUtil.getInstance().setWidth(690),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ),
                      Consumer<MoneyTransferRequestDetailsProvider>(
                          builder: (context, snapshot, _) {
                            return Visibility(
                                visible: snapshot.transactionNotFound ?? false,
                                child: Center(
                                  child: Text(
                                    translator.translate("notfoundTr"),
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ));
                          })
                    ],
                  );
                })));
  }
}

Widget detailsList({String title, String value}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      SizedBox(
        height: 15,
      ),
      Padding(
        padding: EdgeInsets.only(left: 15.0, right: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
            Flexible(
              child: Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
      SizedBox(
        height: 15,
      ),
      Divider(
        color: Colors.black45,
        height: 1.0,
      )
    ],
  );
}
