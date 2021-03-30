import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'drawerMenu.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ActivityDetailsScreen extends StatefulWidget {

  var body;

  ActivityDetailsScreen({this.body});

  @override
  _ActivityDetailsScreenState createState() => _ActivityDetailsScreenState();
}

class _ActivityDetailsScreenState extends State<ActivityDetailsScreen> {
var xx;
List<String> list=[];
 @override
  void initState() {
    // TODO: implement initState
   print(widget.body.toString());
    super.initState();
    list=translator.currentLanguage=='en'?[

"Transaction ID",
"Type",
"Updated at"

]:[
  "İşlem ID",
    "İşlem Türü",
    "Güncelleme Tarihi"
];

  }
    @override
  Widget build(BuildContext context) {
print(widget.body.toString());

    return Scaffold(



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
              title: Text( translator.translate("activity").toUpperCase()),
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


//drawer:DrawerMenu().getDrawer ,

body: Container(
  height: MediaQuery.of(context).size.height-50,
  child:   Column(

    children: <Widget>[

          Expanded(

                    child: ListView(







        children: <Widget>[




    Padding(

        padding: const EdgeInsets.all(0),

        child: ListTile(

        leading: Text(list[0],style: TextStyle(

          fontSize: 15,

          color: Colors.grey,fontWeight: FontWeight.bold),),



        trailing: Text("#"+widget.body["payment_id"].toString(),

        style: TextStyle(

          fontSize: 15,

          color: Colors.black,

          fontWeight: FontWeight.bold),

        ),

        ),

      ),







     //  Padding(
     //
     //    padding: const EdgeInsets.all(0),
     //
     //    child: ListTile(
     //
     //    leading: Text(list[1],style: TextStyle(
     //
     //      fontSize: 15,
     //
     //      color: Colors.grey,fontWeight: FontWeight.bold),),
     //
     //   // isThreeLine: true,
     //
     // /*    subtitle: Text("A7a"),
     //
     //    title:Text("xcxz"), */
     //
     //    trailing: Container(
     //      child: Text(widget.body["entity_name"]??"Not Found",
     //
     //      style: TextStyle(
     //
     //        fontSize: 15,
     //
     //        color: Colors.black,fontWeight: FontWeight.bold),
     //
     //      ),
     //    ),
     //
     //    ),
     //
     //  ),





      Padding(

        padding: const EdgeInsets.all(0),

        child: ListTile(

        leading: Text(list[1],style: TextStyle(

          fontSize: 15,

          color: Colors.grey,fontWeight: FontWeight.bold),),


        trailing: Text(translator.translate(widget.body["transactionable_type"].toString()
            .replaceAll("App", "").replaceAll("Models", "").replaceAll("\\", ""))??"Not Found",

        style: TextStyle(

          fontSize: 15,

          color: Colors.black,
          fontWeight: FontWeight.bold),

        ),

        ),

      ),



      // Padding(
      //
      //   padding: const EdgeInsets.all(0),
      //
      //   child: ListTile(
      //
      //   leading: Text(list[3],style: TextStyle(
      //
      //     fontSize: 15,
      //
      //     color: Colors.grey,fontWeight: FontWeight.bold),),
      //
      //
      //
      //   trailing: Text("#"+widget.body["payment_id"].toString()??"Not Found",
      //
      //   style: TextStyle(
      //
      //     fontSize: 13,
      //
      //     color: Colors.black,fontWeight: FontWeight.bold),
      //
      //   ),
      //
      //   ),
      //
      // ),



  /*     Padding(
  
        padding: const EdgeInsets.all(0),
  
        child: ListTile(   
  
        leading: Text("Status",style: TextStyle(
  
          fontSize: 15,
  
          color: Colors.grey,fontWeight: FontWeight.bold),),
  
      
  
        trailing: Text("#"+body["transactionable_id"],
  
        style: TextStyle(
  
          fontSize: 15,
  
          color: Colors.black,fontWeight: FontWeight.bold),
  
        ),
  
        ),
  
      ), */






      Padding(

        padding: const EdgeInsets.all(0),

        child: ListTile(

        leading: Text(translator.translate("amount"),style: TextStyle(

          fontSize: 15,

          color: Colors.grey,fontWeight: FontWeight.bold),),


        trailing: Text(widget.body["money_flow"]+" "+widget.body["net"].toString()+" "+widget.body["currency_symbol"].toString(),

        style: TextStyle(

          fontSize: 15,

          color: Colors.black,fontWeight: FontWeight.bold),

        ),

        ),

      ),



      Padding(

        padding: const EdgeInsets.all(0),

        child: ListTile(

        leading: Text(translator.translate("created1"),style: TextStyle(

          fontSize: 15,

          color: Colors.grey,fontWeight: FontWeight.bold),),

        trailing: Text(widget.body["created_at"].toString()??"Not Found",

        style: TextStyle(

          fontSize: 15,

          color: Colors.black,fontWeight: FontWeight.bold),

        ),

        ),

      ),




      Padding(

        padding: const EdgeInsets.all(0),

        child: ListTile(

        leading: Text(list[2],style: TextStyle(

          fontSize: 15,

          color: Colors.grey,fontWeight: FontWeight.bold),),

        trailing: Text(widget.body["updated_at"].toString()??"Not Found",

        style: TextStyle(

          fontSize: 15,

          color: Colors.black,fontWeight: FontWeight.bold),

        ),

        ),

      ),



































        ],



      ),

          ),




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