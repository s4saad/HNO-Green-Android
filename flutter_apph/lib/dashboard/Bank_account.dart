import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersipay/base_main_repo.dart';
import 'package:fluttersipay/dashboard/Live_support.dart';
import 'package:fluttersipay/dashboard/providers/bank_account_provider.dart';
import 'package:fluttersipay/utils/app_utils.dart';
import 'package:fluttersipay/utils/dialog_utils/delete_bank_account_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'drawerMenu.dart';
import 'add_new_account.dart';
import 'edit_bank_accounts.dart';

class BankAccountScreen extends StatefulWidget {
  final BaseMainRepository baseRepo;
  BankAccountScreen(this.baseRepo);

  @override
  _BankAccountScreenState createState() => _BankAccountScreenState();
}

class _BankAccountScreenState extends State<BankAccountScreen> {
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
        create: (context) => BankAccountProvider(widget.baseRepo),
        child: Scaffold(

      //  drawer:DrawerMenu().getDrawer ,
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
              title: Text(  translator.translate("accounts")),
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
            body:
                Consumer<BankAccountProvider>(builder: (context, snapshot, _) {
              return Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                 translator.translate("addAcc"),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AddNewBankAccountScreen(
                                                widget.baseRepo),
                                      ));
                                },
                                icon: Icon(
                                  Icons.add_circle,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: new ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.accountsList.length,
                            primary: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Accounts_list(
                                  baseMainRepository: widget.baseRepo,
                                  snapshot: snapshot,
                                  bankModel: snapshot.accountsList[index],
                                  context: context);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                  ),
                  //Dashboardbottom(context, null, null, UserTypes.Individual),
                ],
              );
            })));
  }
}

Widget Accounts_list(
    {var bankModel,
    BuildContext context,
    BankAccountProvider snapshot,
    BaseMainRepository baseMainRepository}) {
  return new Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(
        height: 15,
      ),
      Padding(
          padding: EdgeInsets.only(left: 30.0, right: 20.0),
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    bankModel['bank_name'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Text(
                            bankModel['iban'],
                            textAlign: TextAlign.left,
                          ),
                        ),
                        flex: 3,
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            AppUtils.mapCurrencyIDToText(
                                    bankModel['currency_id']) ??
                                  translator.translate("try"),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        flex: 2,
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(10),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Text(
                            bankModel['account_no'],
                            textAlign: TextAlign.left,
                          ),
                        ),
                        flex: 3,
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            bankModel['status'] == 1 ?   translator.translate("act") :   translator.translate("notact"),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        flex: 2,
                      )
                    ],
                  ),
                ],
              ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.edit,
                        color: Colors.black54,
                      ),
                      onPressed: () async {
                       await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditBankAccountScreen(
                                  bankModel, baseMainRepository),
                            ));
                        snapshot.refreshUI();
                      },
                    ),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.trash,
                          color: const Color(0xFFc14b6f)),
                      onPressed: () {
                        DeleteBankAccountDialog.showDeleteDialog(context, () {
                          snapshot.deleteBankAccount(bankModel['id']);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          )),
      SizedBox(
        height: 20,
      ),
      Divider(
        color: Colors.black26,
        height: 1.0,
      )
    ],
  );
}
