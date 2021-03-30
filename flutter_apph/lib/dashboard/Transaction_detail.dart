import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'dart:convert';
import 'drawerMenu.dart';

class TransactionDetailsScreen extends StatefulWidget {
  var body, type;

  TransactionDetailsScreen({this.body, this.type});

  @override
  _TransactionDetailsScreenState createState() =>
      _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen> {
  List<String> list = translator.currentLanguage == 'en'
      ? [
          "Transaction ID",
          "Status",
          "Transaction Type",
          "Amount",
          "Commission",
          "Net Amount",
          "Date",
          "Processed Date & Time"
        ]
      : [
          "İşlem ID",
          "Durum",
          "İşlem Tipi",
          "Tutar",
          "Komisyon",
          "Net Tutar",
          "Tarih",
          "İşlem Tarihi"
        ];

  String type = "";

  @override
  Widget build(BuildContext context) {
    //  var k=widget.body["data"]["transaction"].keys.toList();
    print(">>> here is <<< " + widget.body["data"][widget.type].toString());

    /*  type=widget.body["data"]["data"]["transaction_type"].toString().trim()??"";
   */
    return Scaffold(
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
        title: Text(translator.translate("transHis")),
        flexibleSpace: Image(
          image: AssetImage('assets/appbar_bg.png'),
          height: 100,
          fit: BoxFit.fitWidth,
        ),

        /*       actions: <Widget>[
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

      body: Container(
        height: MediaQuery.of(context).size.height - 50,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: ListTile(
                      leading: Text(
                        list[0],
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        widget.body["data"][widget.type]["payment_id"]
                                .toString() ??
                            "",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: ListTile(
                      leading: Text(
                        list[1],
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        // widget.body["data"]["searchdata"]["transaction_type"]
                        widget.body["data"][widget.type]["state_name"]
                            .toString(),
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: ListTile(
                      leading: Text(
                        list[2],
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Container(
                        width: 200,
                        child: Text(
                          widget.type.toString().toUpperCase(),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: ListTile(
                      leading: Text(
                        list[3],
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Container(
                        width: 180,
                        alignment: Alignment.centerRight,
                        child: Text(
                          widget.body["data"][widget.type]["gross"].toString(),
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: ListTile(
                      leading: Text(
                        list[4],
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),

                      // isThreeLine: true,

                      /*    subtitle: Text("A7a"),

        title:Text("xcxz"), */

                      trailing: Text(
                        widget.body["data"][widget.type]["commission"]
                                .toString() ??
                            '0',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: ListTile(
                      leading: Text(
                        list[5],
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),

                      // isThreeLine: true,

                      /*

        title:Text("xcxz"), */

                      trailing: Text(
                        widget.body["data"][widget.type]["net"].toString(),
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: ListTile(
                      leading: Text(
                        list[6],
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),

                      // isThreeLine: true,

                      /*    subtitle: Text("A7a"),

        title:Text("xcxz"), */

                      trailing: Text(
                        widget.body["data"][widget.type]["created_at"]
                                .toString() ??
                            "",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: ListTile(
                      leading: Text(
                        list[7],
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),

                      isThreeLine: true,

                      subtitle: Text(""),

                      //    title:Text("xcxz"),

                      trailing: Text(
                        widget.body["data"][widget.type]["updated_at"]
                                .toString() ??
                            "",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //        Container(margin: EdgeInsets.symmetric(vertical: 10),
            // height: 50,
            //                             child: FlatButton(

            //                               onPressed: () {

            //                        Navigator.pop(context);

            //                               },

            //                               color: Colors.blue,

            //                               padding: EdgeInsets.all(0),

            //                               child: Text(

            //                          list[6].toString(),

            //                                 style: TextStyle(

            //                                   color: Colors.white,

            //                                   fontSize: 16,

            //                                 ),

            //                               ),

            //                             ),

            //                             width: ScreenUtil.getInstance().setWidth(690),

            //                           ),
          ],
        ),
      ),
    );
  }
}

/*FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Colors.blue,
                            disabledColor: Colors.blue,
                            padding: EdgeInsets.all(0),
                            child: Text(
                              "BACK",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ), */
