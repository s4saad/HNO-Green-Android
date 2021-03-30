

import 'package:shared_preferences/shared_preferences.dart';

bool isASiPayUser = true;
bool isVerified = true;
var isIndividual;
var userName;
String  userToken;

setUserToken() async {
SharedPreferences.getInstance().then((prefs){


userToken="Bearer "+prefs.getString("token");


});


}








