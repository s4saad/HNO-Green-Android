import 'dart:convert';

class MainApiModel {
  int statusCode;
  String description;
  var data;

  MainApiModel(statusCode, description, data) {
    print(">>>>>>>>>>>>>desc>>>> "+description);
    this.statusCode = statusCode;
    this.description = description;
    this.data = data;
  }

  static MainApiModel mapJsonToModel(String jsonn) {
    print("Json>>>> >>>"+ jsonn.toString());

    var decodedJson = json.decode(jsonn.toString());
    print("Json Data>>>> "+ decodedJson['data'].toString());
    var code =int.parse(decodedJson["statuscode"].toString());
    return MainApiModel(code, decodedJson["description"], decodedJson['data']);
  }

  static MainApiModel mapJsonToModel2(dynamic data) {

    print("************ "+data.toString());
    return MainApiModel(data["statuscode"], data["description"], data['data']);
  }


}
