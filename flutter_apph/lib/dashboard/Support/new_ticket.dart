import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fluttersipay/dashboard/Support/support_tickets.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttersipay/corporate/global_data.dart';
import 'package:fluttersipay/utils/api_endpoints.dart' as global;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:path/path.dart';

class new_ticket extends StatefulWidget {
  @override
  _new_ticketState createState() => _new_ticketState();
}

class _new_ticketState extends State<new_ticket> {
  bool showLoad = false;
  var listOfTickets = [];
  var category, category_ID = 8;
  TextEditingController title = new TextEditingController();
  TextEditingController desc = new TextEditingController();
  File _image;
  var isUploading = false;
  String imageName = "";
  final GlobalKey<FormFieldState> _key = GlobalKey();
  Widget DropDown(List data) {
    if (data != null) {
      return DropdownButtonFormField(
key: _key,
        onSaved: (val) {
          if (val != null) {
            category = val; //int.parse(val.toString());

          } else {
/*
category=""; */

          }
        },
        /*
            validator: (val){


if(val==null)

            }, */
        items: data.map((item) {
          category = item;
          return new DropdownMenuItem(
            child: new Text(
              translator.translate(item),
              style: TextStyle(fontSize: 14.0),
            ),
            value: category.toString(),
          );
        }).toList(),
        hint: Text(
          translator.translate('pleaseSelect'),
          style: TextStyle(
            color: Colors.black45,
          ),
        ),
        onChanged: (newVal) {
          setState(() {
            category = newVal; //int.parse(newVal);

            switch (newVal) {
              case "Deposit":
                category_ID = 2;
                break;

              case "Withdraw":
                category_ID = 3;
                break;

              case "Refund":
                category_ID = 6;
                break;

              case "Money Transfer":
                category_ID = 10;
                break;
              case "Technical":
                category_ID = 7;
                break;
              case "Purchase":
                category_ID = 9;
                break;
              case "Other":
                category_ID = 8;
                break;
            }
          });
        },
        //    value: _mySelection,
      );
    } else {
      return new Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  File image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          translator.translate("NEW TICKET").toUpperCase(),
          style: TextStyle(fontSize: 15),
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    translator.translate("newTic"),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Text(
                    translator.translate("categoryTic"),
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  DropDown([
                    "Deposit",
                    "Withdraw",
                    "Refund",
                    "Technical",
                    "Other",
                    "Purchase",
                    "Money Transfer"
                  ]),
//Deposit Withdraw Refund Technical Other Purchase Money Transfer
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    translator.translate("titleTic"),
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  TextFormField(
                    enabled: !showLoad,
                    controller: title,
                    decoration: InputDecoration(
//prefixIcon: Icon(FontAwesomeIcons.commentDots),

                        hintText: translator.translate("ticketTichint")),
                  ),

                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      width: (MediaQuery.of(context).size.width / 3) * 1.8,
                      child: FlatButton(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          isUploading
                              ? "Uploading File..."
                              : translator.translate("attachTic"),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        color: Colors.blue,
                        onPressed: () async {
                          if (showLoad) {
                            return;
                          }
                          // NAVIGATE TO ADD TICKET SCREEN

                          print("Pressd");
/* setState(() {
  isUploading=true;
}); */

// ignore: deprecated_member_use
                          ImagePicker.pickImage(source: ImageSource.gallery)
                              .then((value) {
                            setState(() {
                              image = value;
                              print("path>>" + image.path.toString());
                              File file = new File(image.path);
                              imageName = file.path.split('/').last;

                              print("image name>>>" + imageName);
                              // isUploading=false;
                            });
                          });
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      imageName,
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Text(
                    translator.translate("desc"),
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),

                  TextFormField(
                    enabled: !showLoad,
                    controller: desc,
                    decoration: InputDecoration(
                        prefixIcon: Icon(FontAwesomeIcons.commentDots),
                        hintText: translator.translate("descTicHint")),
                  ),

                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 40),
                      width: (MediaQuery.of(context).size.width / 3) * 2.8,
                      child: FlatButton(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          translator.translate('submitTic').toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        color: Colors.blue,
                        onPressed: showLoad
                            ? null
                            : () async {
                                if (showLoad) {
                                  return;
                                }
                                if (title.value.text.isEmpty ||
                                    desc.value.text.isEmpty) {
                                  Flushbar(
                                    // title: "Eror",
                                    message: translator.translate("emptyField"),
                                    duration: Duration(seconds: 3),
                                  )..show(context);
                                } else {
                                  try {
                                    var dioRequest = dio.Dio();

                                    dioRequest.options.baseUrl = global
                                        .APIEndPoints.kApiSupportFormEndPoint;
                                    print("## 1");
                                    dioRequest.options.headers = {
                                      'Accept': "application/json",
                                      'Authorization': userToken,
                                      'Content-Type':
                                          'application/x-www-form-urlencoded'
                                    };
                                    print("## 2");
                                    var formData = new dio.FormData.fromMap({
                                      "title": title.text,
                                      "message": desc.text,
                                      "category": category_ID.toString()
                                    });
                                    print("## 3");
                                    //[4] ADD IMAGE TO UPLOAD
                                    if (image != null) {
                                      var file =
                                          await dio.MultipartFile.fromFile(
                                              image.path,
                                              filename: basename(image.path),
                                              contentType: MediaType(
                                                  "attachment",
                                                  basename(image.path)));

                                      formData.files
                                          .add(MapEntry('attachment', file));
                                    }
                                    setState(() {
                                      showLoad = true;
                                    });
                                    var response = await dioRequest.post(
                                        global.APIEndPoints
                                            .kApiSupportFormEndPoint,
                                        data: formData,
                                        options: dio.Options(headers: {
                                          'Accept': "application/json",
                                          'Authorization': userToken,
                                        }));
                                    final result =
                                        json.decode(response.toString());
                                    //   print("<<<<<<<<<<<<><##<<<<<<<<<   "+result.toString());

                                    setState(() {
                                      showLoad = false;
                                    });
                                    Flushbar(
                                        title:
                                            translator.translate("successful"),
                                        message:
                                            translator.translate("successTic"),
                                        duration: Duration(seconds: 3))
                                      ..show(context);
                                    desc.text = "";
                                    title.text = "";

                                    Timer(
                                        Duration(seconds: 3),
                                        () => Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    support_tickets())));
                                    setState(() {
                                      _key.currentState.reset();
                                      category = null;
                                      image = null;
                                      category_ID = null;
                                    });
                                  } catch (err) {
                                    setState(() {
                                      showLoad = true;
                                    });
                                    print('ERROR  $err');
                                    Flushbar(
                                        title: translator.translate("Failure"),
                                        message:
                                            translator.translate("failTic"),
                                        duration: Duration(seconds: 3))
                                      ..show(context);
                                  }

/*
http.post(

global.APIEndPoints.kApiSupportFormEndPoint
,headers:{

"Authorization":userToken
,
"Accept":"application/json"
,
},
body: {

"title":title.text
,
"message":desc.text
,
"category":category_ID.toString()
,
"attachment":base64Image

},
//encoding: Encoding.getByName("form-data")

).then((val){

var body=json.decode(val.body);
Timer(Duration(seconds: 3),(){
Navigator.pop(context);
});

print("NEW TICKET RESPONSE: "+val.body.toString());
if(body['statuscode']==100)
{



                 Flushbar(
          title: "Success",
                                              message:
                          'Your Support Ticket was opened successfully',
                         duration: Duration(seconds: 3),
                                            )..show(context);
}else{

              Flushbar(
           title: "Fail",
                                              message:
                          'Your Support Ticket was not opened successfully',
                         duration: Duration(seconds: 3),
                                            )..show(context);

}


});

 */

                                }
                              },
                      ),
                    ),
                  ),

/*
StreamBuilder<Object>(
  stream: null,
  builder: (context, snapshot) {
            return     ListView.builder(

              itemCount: 1,

              itemBuilder: (BuildContext context, int index) {

              return ;

             },

            );
  }
), */
                ],
              ),
            ),
          ),
          Visibility(
            visible: showLoad,
            child: SpinKitChasingDots(
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }
}
