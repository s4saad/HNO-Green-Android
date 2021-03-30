import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:dio/dio.dart' as dio;
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersipay/corporate/dashboard/merchant_repo.dart';
import 'package:fluttersipay/corporate/dashboard/providers/corporate_profile_provider.dart';
import 'package:fluttersipay/corporate/dashboard/support.dart';
import 'package:fluttersipay/corporate/global_data.dart';
import 'package:fluttersipay/dashboard/drawerMenu.dart';
import 'package:fluttersipay/loading_widget.dart';
import 'package:fluttersipay/main_api_data_model.dart';
import 'package:fluttersipay/utils/api_endpoints.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:ola_like_country_picker/ola_like_country_picker.dart' as ola;
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class CorporateProfileSettingsScreen extends StatefulWidget {
  final MerchantMainRepository corporateRepo;
  final MainApiModel userModel;

  CorporateProfileSettingsScreen(this.corporateRepo, this.userModel);

  @override
  _CorporateProfileSettingsScreenState createState() =>
      _CorporateProfileSettingsScreenState();
}

class _CorporateProfileSettingsScreenState
    extends State<CorporateProfileSettingsScreen> {
///////////////////////////////////////////////

  upload2Image(CorporateProfileSettingsProvider snapshot, File image, context) async {
    try {
      ///[1] CREATING INSTANCE
      var dioRequest = dio.Dio();

      dioRequest.options.baseUrl =
          APIEndPoints.kApiCorporateUploadImageEndPoint;

      //[2] ADDING TOKEN
      dioRequest.options.headers = {
        'Accept': "application/json",
        'Authorization': userToken,
        'Content-Type': 'application/x-www-form-urlencoded'
      };

      //[3] ADDING EXTRA INFO
      var formData = new dio.FormData();

      //[4] ADD IMAGE TO UPLOAD
      var file = await dio.MultipartFile.fromFile(image.path,
          filename: basename(image.path),
          contentType: MediaType("image", basename(image.path)));

      formData.files.add(MapEntry('image', file));
snapshot.showLoad = true;
      //[5] SEND TO SERVER
      var response =
          await dioRequest.post(APIEndPoints.kApiCorporateUploadImageEndPoint,
              data: formData,
              options: dio.Options(headers: {
                'Accept': "application/json",
                'Authorization': userToken,
              }));
      snapshot.showLoad = false;
      final result = json.decode(response.toString())['data'];
      //  print("<<<<<<<<<<<<><<<<<<<<<<   "+result.toString());
      widget.userModel.data['user']['img_path'] = result['user']['img_path'];
      Flushbar(
          title: translator.translate("success"),
          message: translator.translate("imgsucc"),
          duration: Duration(seconds: 3))
        ..show(context);
    } catch (err) {
      snapshot.showLoad = false;
      // print('ERROR  $err');
      Flushbar(
          title: translator.translate("fail"),
          message: translator.translate("imgfail"),
          duration: Duration(seconds: 3))
        ..show(context);
    }
  }

/////////////////////////////////////////////////
/* Future uploadImage(File file)async{




    String base64Image =
  /*   'data:image/png;base64,'+ */
  base64Encode(file.readAsBytesSync());
var com=  GZipEncoder().encode(file.readAsBytesSync());
var copressed= base64.encode(com);
var comoresed64=base64Url.encode(file.readAsBytesSync());
print("G ZIP length "+copressed.length.toString() );

 print("no compress length = "+base64Image.toString().length.toString());


    Response response;
    String body = "";
    try {
  //    print("@# "+userToken);
      var request = {
    
        'Accept':'application/json',
       "Authorization": '$userToken' ,
  
      };
      response =
          await post(

            APIEndPoints.kApiCorporateUploadImageEndPoint,
           body: {'image':copressed,
           
              //    'Content-type': 'application/form-data'
           /* image.toString()*/},
            headers: request
           
           ,encoding: Encoding.getByName("form-data")
           );
      int statusCode = response
          .statusCode; // this API passes back the id of the new item added to the body
      if (statusCode == 200) { print("##@@###"+statusCode.toString());
        body = response.body;
      }
    } // request
    catch (e) {

print("E = "+e.toString() );

    }
    print("############ body "+body);
  
}



 */

  ola.CountryPicker countryPicker;
  ola.Country country; // se

  var local = ui.window.locale.countryCode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (local == null) local = 'tr';

    for (var element in ola.countryCodes) {
      if (local.toLowerCase() == element["ISO"]) {
        setState(() {
          country = ola.Country.fromJson(element);
//countrycode=country.dialCode;
        });
      }
    }
    countryPicker = ola.CountryPicker(onCountrySelected: (country) {
      print(country);
      setState(() {
        this.country = country as ola.Country;
        // countrycode=country.dialCode;
      });
    });
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
        create: (context) => CorporateProfileSettingsProvider(
            widget.corporateRepo,
            widget.userModel,
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
              title: Text(translator.translate("profSettings")),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Live_Support(),
                        ));
                    // do something
                  },
                )
              ],
            ),
            body: Consumer<CorporateProfileSettingsProvider>(
                builder: (context, snapshot, _) {
              return Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  SingleChildScrollView(
                    child: Padding(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(60),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: CircleAvatar(
                                    backgroundImage:
                                    snapshot.imageFromGallery != null
                                        ? FileImage(
                                      snapshot.imageFromGallery,
                                    )
                                        : snapshot.userProfileAvatar != null
                                            ? NetworkImage(
                                                snapshot.userProfileAvatar
                                                    .toString()
                                                    .trim(),
                                              )
                                            :  Image.asset(
                                                    'assets/user_avatar.png',
                                                    fit: BoxFit.cover,
                                                  ).image),
                                height: ScreenUtil.getInstance().setHeight(130),
                                width: ScreenUtil.getInstance().setHeight(130),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 30,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          snapshot.userName ?? '',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        width: ScreenUtil.getInstance()
                                            .setWidth(500),
                                      ),
                                      SizedBox(
                                        height: ScreenUtil.getInstance()
                                            .setHeight(10),
                                      ),
                                      Container(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            translator.translate('customerNumber').toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey,
                                                fontStyle: FontStyle.italic
                                            ),
                                          ),
                                        ),
                                        width: ScreenUtil.getInstance()
                                            .setWidth(300),
                                      ),
                                      Container(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            snapshot.customerNumber.toString(),
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        width: ScreenUtil.getInstance()
                                            .setWidth(300),
                                      ),
                                      // Container(
                                      //   child: Align(
                                      //     alignment: Alignment.centerLeft,
                                      //     child: Text(
                                      //       'ID: ${snapshot.userID ?? ''}',
                                      //       style: TextStyle(
                                      //         fontSize: 15,
                                      //         color: Colors.black45,
                                      //       ),
                                      //     ),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: FlatButton(
                              onPressed: () async {
                                print("############################");

                                //   File image=new

                                // ignore: deprecated_member_use
                                ImagePicker.pickImage(
                                        source: ImageSource.gallery)
                                    .then((image) {
                                  upload2Image(snapshot, image, context);

                                  snapshot.setImagegalary(image);
                                });

                                /*        snapshot.pickImageFromLibrary(() {
                                  Flushbar(
                                      title: "Successful",
                                      message: 'Image Uploaded!',
                                      duration: Duration(seconds: 3))
                                    ..show(context);
                                }, (description) {
                                  Flushbar(
                                      title: "Fail",
                                      message: "Image was not Uploaded",
                                      duration: Duration(seconds: 3))
                                    ..show(context);
                                });
                           */
                              },
                              color: Colors.blue,
                              disabledColor: Colors.blue,
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                translator.translate("updatelogo"),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            width: ScreenUtil.getInstance().setWidth(690),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextField(
                            style: TextStyle(color: Colors.black38),
                            controller: snapshot.currentPasswordController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              errorText: snapshot.currentPasswordErrorMessage,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black26, width: 0.3)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black38, width: 0.3)),
                              prefixIcon: const Icon(
                                FontAwesomeIcons.lockOpen,
                                color: Colors.black26,
                                size: 16,
                              ),
                              hintText: translator.translate("curntPass"),
                              hintStyle:
                                  TextStyle(color: Colors.black26, height: 1.3),
                            ),
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            style: TextStyle(color: Colors.black38),
                            controller: snapshot.newPasswordController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              errorText: snapshot.newPasswordErrorMessage,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black26, width: 0.3)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black38, width: 0.3)),
                              prefixIcon: const Icon(
                                FontAwesomeIcons.lock,
                                color: Colors.black26,
                                size: 16,
                              ),
                              hintText: translator.translate("newPass"),
                              hintStyle:
                                  TextStyle(color: Colors.black26, height: 1.3),
                            ),
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            style: TextStyle(color: Colors.black38),
                            controller: snapshot.confirmPasswordController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              errorText: snapshot.confirmPasswordErrorMessage,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black26, width: 0.3)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black38, width: 0.3)),
                              prefixIcon: const Icon(
                                Icons.refresh,
                                color: Colors.black26,
                                size: 20,
                              ),
                              hintText: translator.translate("ConfPass"),
                              hintStyle:
                                  TextStyle(color: Colors.black26, height: 1.3),
                            ),
                            obscureText: true,
                          ),
                          SizedBox(height: 10),
                          Text(snapshot.errorText,style: TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.w500),),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            child: FlatButton(
                              onPressed: () {
                                snapshot.savePasswordUpdate(() {
                                  Navigator.of(context).pop();
                                  Flushbar(
                                      title: translator.translate("success"),
                                      message:
                                          translator.translate("passupdated"),
                                      duration: Duration(seconds: 3))
                                    ..show(context);
                                }, (String response) {
                                  /*Flushbar(
                                      title: translator.translate("fail"),
                                      message: response,
                                      duration: Duration(seconds: 3))
                                    ..show(context);*/
                                });
                              },
                              color: Colors.blue,
                              disabledColor: Colors.blue,
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                translator.translate("changePassbtn"),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            width: ScreenUtil.getInstance().setWidth(690),
                          ),
                          SizedBox(
                            height: 60,
                          )
                        ],
                      ),
                      padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    ),
                  ),
                  LoadingWidget(
                    isVisible: snapshot.showLoad ?? false,
                  ),
                ],
              );
            })));
  }
}
