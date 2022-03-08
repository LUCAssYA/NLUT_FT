import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:urooster/model/register_model.dart';
import 'package:urooster/utils/constants.dart' as constant;

class RegisterProvider with ChangeNotifier {
  bool verified = false;
  Map<String, String> universities = new Map();
  List<String> faculties = [];
  var header = {"content-type": "application/json"};

  Future<void> getUniversities() async{
    var response = await http.get(Uri.parse(constant.getUniversitiesUrl ) ,headers: header);
    var body = jsonDecode(response.body)['response'];
    print(body);

    body.forEach((element) {
      universities[element['name'] as String] = element['domain'] as String;
    });

    notifyListeners();

  }

  String? defaultValidator(text) {
    if(text == null || text.isEmpty) {
      return "*required";
    }
    return null;
  }

  Future<void> uniOnChange(value) async{
    print(value);
    if(value != null && value.isNotEmpty) {
      var response = await http.get(Uri.parse(constant.getUniversitiesUrl+"/"+value), headers: header);
      faculties = jsonDecode(response.body)['response'].cast<String>();
      print(faculties);
      notifyListeners();
    }
  }



}