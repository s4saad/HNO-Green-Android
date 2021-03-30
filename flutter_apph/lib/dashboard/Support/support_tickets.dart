import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ola_like_country_picker/ola_like_country_picker.dart';
import 'dart:ui' as ui;
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:country_provider/country_provider.dart' as pc;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './new_ticket.dart';
import './closed_support.dart';
import './support.dart';
import '../drawerMenu.dart';
import 'package:fluttersipay/utils/api_endpoints.dart' as global;
import 'package:http/http.dart' as http;
import 'package:fluttersipay/corporate/global_data.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:translator/translator.dart' as tr;

class support_tickets extends StatefulWidget {
  @override
  _support_ticketsState createState() => _support_ticketsState();
}

class _support_ticketsState extends State<support_tickets> {
  var listOfTickets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          translator.translate("supportTic").toUpperCase(),
          style: TextStyle(fontSize: 15),
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
              FontAwesomeIcons.commentAlt,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              width: (MediaQuery.of(context).size.width / 3) * 2,
              child: FlatButton(
                //padding: EdgeInsets.all(15.0),

                child: Text(
                  translator.translate("addTic"),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),

                color: Colors.blue,

                onPressed: () {
                  // NAVIGATE TO ADD TICKET SCREEN

                  print("Pressd");

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => new_ticket()));
//                  Navigator.pushReplacement(context,
//                      MaterialPageRoute(builder: (context) => new_ticket()));
                },
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: Container(
              child: FutureBuilder(
                  future: http.get(global.APIEndPoints.kApiSupportListEndPoint,
                      headers: {
                        "Authorization": userToken,
                        "Accept": "application/json"
                      }),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData)
                      return Container(
                          width: 30,
                          height: 30,
                          child: Center(child: CircularProgressIndicator()));
                    print("Data of tickets"+snapshot.data.body);
                    var responseMap = json.decode(snapshot.data.body);
                    if (responseMap["data"]["ticketdata"]["data"].length ==0)
                      return Container(
                          height: 30,
                          child: Center(child: Text(translator.translate("notFound"))));
                    var mylist = responseMap["data"]["ticketdata"]["data"];
                    print(mylist.toString());

                    return ListView.builder(
                      itemCount: mylist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            if (mylist[index]['status'] == 'open') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          support(mylist[index])));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          closed_ticket(mylist[index])));
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "#" +
                                          mylist[index]['ticket_id']
                                              .toString() +
                                          " " +
                                          translator.translate("supportTic"),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      translator.translate(mylist[index]
                                              ['status']
                                          .toString()
                                          .toUpperCase()),
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: mylist[index]['status'] ==
                                                  "closed"
                                              ? Colors.red
                                              : Colors.green
                                          //fontWeight: FontWeight.bold
                                          ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    /*
  Text(mylist[index]["ticketcategory_id"]==null?"Other":mylist[index]["ticketcategory"]["name"],

  style: TextStyle(

    fontSize: 13,

   color: Colors.grey,

    //fontWeight: FontWeight.bold),

  )

    ),

*/

                                    FutureBuilder(
                                        future: tr.GoogleTranslator().translate(
                                            mylist[index]["ticketcategory"]
                                                ["name"],
                                            to: 'tr'),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData)
                                            return Text("");
                                          var txt = snapshot.data.toString();
                                          if (snapshot.data
                                              .toString()
                                              .contains("Depozito")) {
                                            txt = "Para Yatırma";
                                          } else if (snapshot.data
                                              .toString()
                                              .contains("Çekil")) {
                                            txt = "Para Çekme";
                                          }

                                          return Text(
                                            translator.currentLanguage == 'tr'
                                                ? txt
                                                : mylist[index]
                                                    ["ticketcategory"]["name"],
                                            style: TextStyle(
                                              fontSize: 15,

                                              color: Colors
                                                  .grey, //mylist[index]['status']=="closed"? Colors.red:Colors.green

                                              //fontWeight: FontWeight.bold
                                            ),
                                          );
                                        }),
                                    Text(mylist[index]["created_at"],
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.grey

                                            //fontWeight: FontWeight.bold),

                                            ))
                                  ],
                                ),
                                Divider()
                              ],
                            ),
                          ),
                        );
                      },
                    );

                    /*  ListView.builder(



          itemCount: responseMap.,



          itemBuilder: (BuildContext context, int index) {



          return ;



         },



        );
     */
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
