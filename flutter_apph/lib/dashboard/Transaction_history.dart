import 'package:dio/dio.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttersipay/corporate/global_data.dart';
import 'package:fluttersipay/dashboard/providers/transaction_history_provider.dart';
import 'package:fluttersipay/utils/api_endpoints.dart' as global;
import 'package:fluttersipay/utils/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart' as tr;
import './Transaction_detailCor.dart';
import '../base_main_repo.dart';
import '../loading_widget.dart';
import 'Transaction_detail.dart';
import 'merchant_panel.dart';

class TransactionHistoryScreen extends StatefulWidget {
  final BaseMainRepository baseRepo;
  final List userWallets;
  final UserTypes userType;

  TransactionHistoryScreen(this.baseRepo, this.userWallets, this.userType);

  @override
  _TransactionHistoryScreenState createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  var amount = 1;
  bool loading = false;
  List<String> list = [translator.translate("curr"), "TRY", "USD", "EUR"];

  var _tryValue = translator.translate("curr");
  List<String> _listTryData;
  var _typeValue = "Purchase";
  List<String> _listTypeData = [
    // translator.translate("TYPES"),
    "Purchase",
    "Deposit",
    "Withdrawal",
    "Send",
    "Receive",
    "Exchange"
  ];
  var _statusValue = translator.translate("STATES");
  List<String> _listStatusData = [
    translator.translate("STATES"),
    "Completed",
    "Rejected",
    "Pending",
    "Stand By",
    "Refunded",
    "Awaiting",
    "Failed"
  ];
  DateTime endDate;
  DateTime startDate;

  @override
  void initState() {
    super.initState();
    _listTryData = [translator.translate("curr"), "TRY", "USD", "EUR"];
  }

  Future<dynamic> startDatePicker() async {
    var order = await getDate();
    setState(() {
      startDate = order;
    });
    return order;
  }

  Future<dynamic> endDatePicker() async {
    var order = await getDate();
    setState(() {
      endDate = order;
    });
    return order;
  }

  Future<DateTime> getDate() {
    // Imagine that this function is
    // more complex and slow.
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
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
    return ChangeNotifierProvider(
        create: (context) =>
            TransactionsHistoryProvider(widget.baseRepo, widget.userType),
        child: Scaffold(
            appBar: AppBar(
              centerTitle: false,
              actions: <Widget>[
                loading == true
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: CupertinoActivityIndicator(
                          animating: true,
                          radius: 10,
                        ),
                      )
                    : Container(),
              ],
              title: Text(
                translator.translate("transactionHisstory"),
                style: TextStyle(fontSize: 16),
              ),
              flexibleSpace: Image(
                image: AssetImage('assets/appbar_bg.png'),
                height: 100,
                fit: BoxFit.fitWidth,
              ),
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
              /*        actions: <Widget>[
                Consumer<TransactionsHistoryProvider>(
                    builder: (context, snapshot, _) {
                  return IconButton(
                    padding: const EdgeInsets.only(right: 20.0),
                    icon: Icon(
                      FontAwesomeIcons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      snapshot.searchUserTransactionList();
                    },
                  );
                })
              ], */
            ),
            body: Stack(
              children: <Widget>[
                Consumer<TransactionsHistoryProvider>(
                    builder: (context, snapshot, _) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                        padding:
                                            EdgeInsets.only(right: 5, left: 5),
                                        child: Container(
                                          decoration: new BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.black54,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Icon(
                                                FontAwesomeIcons.calendarAlt,
                                                color: Colors.black45,
                                                size: 16,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  startDate == null
                                                      ? ''
                                                      : startDate.day
                                                              .toString() +
                                                          '-' +
                                                          startDate.month
                                                              .toString(),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              IconButton(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  icon: Icon(
                                                    Icons.keyboard_arrow_down,
                                                    size: 16,
                                                    color: Colors.black45,
                                                  ),
                                                  onPressed: () async {
                                                    snapshot.startDate =
                                                        await startDatePicker();
                                                  }),
                                            ],
                                          ),
                                        )),
                                  ),
                                  Expanded(
                                    child: Padding(
                                        padding:
                                            EdgeInsets.only(right: 5, left: 5),
                                        child: Container(
                                          decoration: new BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.black54,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Icon(
                                                FontAwesomeIcons.calendarAlt,
                                                color: Colors.black45,
                                                size: 16,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  endDate == null
                                                      ? ''
                                                      : endDate.day.toString() +
                                                          '-' +
                                                          endDate.month
                                                              .toString(),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              IconButton(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  icon: Icon(
                                                    Icons.keyboard_arrow_down,
                                                    size: 16,
                                                    color: Colors.black45,
                                                  ),
                                                  onPressed: () async {
                                                    snapshot.endDate =
                                                        await endDatePicker();
                                                  }),
                                            ],
                                          ),
                                        )),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(right: 5, left: 5),
                                      child: Container(
                                        decoration: new BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.black54,
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            icon: Icon(
                                              Icons.keyboard_arrow_down,
                                              size: 13,
                                            ),
                                            items: _listTryData
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                      child: Text(
                                                        value,
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                35,
                                                            color:
                                                                Colors.black45),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                _tryValue = value;
                                              });
                                              snapshot.selectedCurrency = value;
                                            },
                                            value: _tryValue,
                                            isExpanded: true,
                                          ),
                                        ),
                                      ),
                                    ),
                                    flex: 1,
                                  ),
                                ],
                              ),
                              widget.userType == UserTypes.Individual
                                  ? Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                right: 5, left: 5),
                                            child: TextFormField(
                                              style: TextStyle(
                                                  color: Colors.black),
                                              onChanged: (key) {
                                                snapshot.searchKey = key;
                                              },
                                              decoration: InputDecoration(
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black45,
                                                            width: 1.0)),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black45,
                                                            width: 1.0)),
                                                prefixIcon: const Icon(
                                                  FontAwesomeIcons.search,
                                                  size: 16,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                right: 5, left: 5),
                                            child: Container(
                                              decoration: new BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Colors.black54,
                                                    width: 1.0,
                                                  ),
                                                ),
                                              ),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton<String>(
                                                  icon: Icon(
                                                    Icons.keyboard_arrow_down,
                                                    size: 16,
                                                  ),
                                                  items: _listStatusData.map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          SizedBox(width: 10),
                                                          Expanded(
                                                            child: Text(
                                                              translator
                                                                  .translate(
                                                                      value),
                                                              style: TextStyle(
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      35,
                                                                  color: Colors
                                                                      .black45),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _statusValue = value;
                                                      snapshot.selectedTransactionState =
                                                          value;
                                                    });
                                                  },
                                                  value: _statusValue,
                                                  isExpanded: true,
                                                ),
                                              ),
                                            ),
                                          ),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                right: 5, left: 5),
                                            child: Container(
                                              decoration: new BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Colors.black54,
                                                    width: 1.0,
                                                  ),
                                                ),
                                              ),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton<String>(
                                                  icon: Icon(
                                                    Icons.keyboard_arrow_down,
                                                    size: 16,
                                                  ),
                                                  items: _listTypeData.map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          SizedBox(width: 10),
                                                          Expanded(
                                                            child: Text(
                                                              translator
                                                                  .translate(
                                                                      value),
                                                              style: TextStyle(
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      35,
                                                                  color: Colors
                                                                      .black45),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _typeValue = value;
                                                    });
                                                    snapshot.selectedTransactionType =
                                                        value;
                                                  },
                                                  value: _typeValue,
                                                  isExpanded: true,
                                                ),
                                              ),
                                            ),
                                          ),
                                          flex: 1,
                                        ),
                                      ],
                                    )
                                  : SizedBox(
                                      width: 0.0,
                                    ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: TextFormField(
                                      maxLength: 8,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onChanged: (key) {
                                        snapshot.minAmount = key;
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          suffixIcon: Icon(
                                            FontAwesomeIcons.arrowDown,
                                            size: 10,
                                          ),
                                          hintText: translator.translate(
                                              translator
                                                  .translate("Min Amount")),
                                          hintStyle: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  35)),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5),
                                    width:
                                        MediaQuery.of(context).size.width / 2.8,
                                    child: TextFormField(
                                      maxLength: 12,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onChanged: (key) {
                                        snapshot.maxAmount = key;
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          suffixIcon: Icon(
                                            FontAwesomeIcons.arrowUp,
                                            size: 10,
                                          ),
                                          hintText: translator
                                              .translate("Max Amount"),
                                          hintStyle: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  35)),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: FlatButton.icon(
                                        color: Colors.blue,
                                        onPressed: () {
                                          snapshot.searchUserTransactionList();
                                        },
                                        label: Text('Search',style: TextStyle(color: Colors.white),),
                                        icon: Icon(Icons.search,color: Colors.white,),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Align(
                                child: Text(
                                  translator.translate("alltransaction"),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                alignment: Alignment.center,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      decoration: new BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.black26,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: new BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.blue,
                                            width: 2.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: new BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.black26,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    flex: 1,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: new ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.userTransactionsList().length,
                              primary: true,
                              itemBuilder: (BuildContext content, int index) {
                                return transactionsList(
                                        title: snapshot
                                                .getDataFromTransactionsList(
                                                    TransactionData.Title,
                                                    index) ??
                                            '',
                                        value: snapshot
                                                .getDataFromTransactionsList(
                                                    TransactionData.Value,
                                                    index) ??
                                            '',
                                        id: snapshot.getDataFromTransactionsList(
                                                TransactionData.ID, index) ??
                                            '',
                                        dates: snapshot
                                                .getDataFromTransactionsList(
                                                    TransactionData.Date,
                                                    index) ??
                                            '',
                                        type:
                                            snapshot.getDataFromTransactionsList(
                                                TransactionData.Type, index)) ??
                                    '';
                              }),
                        ),
                        SizedBox(
                          height: 60,
                        )
                      ],
                    ),
                  );
                }),

                loading
                    ? Center(
                        child: SpinKitChasingDots(
                        size: 100,
                        color: Colors.blue,
                      ))
                    : Container(),
                // Dashboardbottom(context, widget.baseRepo, widget.userWallets,
                //       widget.userType),
                Consumer<TransactionsHistoryProvider>(
                    builder: (context, snapshot, _) {
                  return LoadingWidget(isVisible: snapshot.showLoad ?? false);
                })
              ],
            )));
  }

  Widget transactionsList(
      {String title,
      String value,
      String id,
      String dates,
      String type,
      bool isUser}) {
    print("payment>>>>>>"+title);
    var _color;
    if (type == "0")
      _color = Colors.red;
    else if (type == "1")
      _color = Colors.green;
    else if (type == "2") _color = Colors.blue;

    return new GestureDetector(
      onTap: () {
        setState(() {
          loading = true;
        });
        if (isIndividual) {
          Dio()
              .get(
                  global.APIEndPoints.kApiIndividualTransactionDetailsEndPoint +
                      "/" +
                      id
                          .replaceAll("Transaction ID:", "")
                          .replaceAll("#", "")
                          .replaceAll("İşlem ID:", "")
                          .trim()
                          .toString() +
                      "?transactionType=${title.toLowerCase()}",
                  options: Options(headers: {
                    "Authorization": userToken,
                    "Accept": "application/json",
//"Content-Type":"application/json",
                  }))
              .then((val) {
            print("********** " + val.data.toString());
            setState(() {
              loading = false;
            });
            print("RESPONSE OF HISTORY :" + val.data.toString());

            if (val.data.toString().contains("statuscode: 422,")) {
              print("THIS TRANSACTION WAS DELETED OR CANCELED ");
              Flushbar(
                title: translator.translate("fail"),
                message: "This item was Deleted ",
                duration: Duration(seconds: 3),
              )..show(context);
            } else {
              setState(() {
                loading = false;
              });

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransactionDetailsScreen(
                        type: title.toLowerCase(), body: val.data),
                  ));
            }
          });
        } else {
////////////Cor
          Dio()
              .get(
                  global.APIEndPoints.kApiCorporateTransactionDetailsEndPoint +
                      "/" +
                      id
                          .replaceAll("Transaction ID:", "")
                          .replaceAll("#", "")
                          .replaceAll("İşlem ID:", "")
                          .trim()
                          .toString()
                  //+"?transactionType=${title.toLowerCase()}"
                  ,
                  options: Options(headers: {
                    "Authorization": userToken,
                    "Accept": "application/json",
//"Content-Type":"application/json",
                  }))
              .then((val) {
            setState(() {
              loading = false;
            });

            // print(id.replaceAll("Transaction ID:", "").replaceAll("#", "").replaceAll("İşlem ID:", "").trim().toString());
            // print("===================================");
            // print(val.data);

            if (val.data.toString().contains("statuscode: 422,")) {
              print("THIS TRANSACTION WAS DELETED OR CANCELED ");
              Flushbar(
                title: translator.translate("fail"),
                message: "This item was Deleted ",
                duration: Duration(seconds: 3),
              )..show(context);
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransactionDetailsCorScreen(
                      body: val.data,
                      type: title.toLowerCase(),
                    ),
                  ));
            }
          });
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Padding(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: FutureBuilder(
                          future:
                              tr.GoogleTranslator().translate(title, to: "tr"),
                          builder: (context, snapshot) {
                            var txt = snapshot.data.toString();
                            if (snapshot.data.toString().contains("Gönder")) {
                              txt = "Giden Para";
                            } else if (snapshot.data
                                .toString()
                                .contains("almak")) {
                              txt = "Gelen Para";
                            } else if (snapshot.data
                                .toString()
                                .contains("Depozito")) {
                              txt = "Para Yatırma";
                            }

                            if (!snapshot.hasData) return Text("");
                            return Text(
                              translator.currentLanguage == 'tr' ? txt : title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            );
                          }),
                    ),
                    Text(
                      value,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _color,
                      ),
                      textAlign: TextAlign.right,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        translator.currentLanguage == 'tr'
                            ? id.replaceFirst("Transaction ID", "İşlem ID")
                            : id,
                        //    id
                      ),
                    ),
                    Text(
                      dates,
                      textAlign: TextAlign.right,
                    )
                  ],
                )
              ],
            ),
            padding: EdgeInsets.only(right: 30, left: 30),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            color: Colors.black45,
            height: 1.0,
          )
        ],
      ),
    );
  }
}
