import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:urooster/model/register_model.dart';
import 'package:urooster/utils/constants.dart' as constant;

class RegisterProvider with ChangeNotifier {
  bool verified = false;
  late Map<String, String> universities;

  Future<void> getUniversities() async{
    var header = {"content-type": "application/json"};
    var response = await http.get(Uri.parse(constant.getUniversitiesUrl ) ,headers: header);
    List body = jsonDecode(response.body);
    
    body.forEach((element) {
      universities[element['name'] as String] = element['domain'] as String;
    });

    notifyListeners();

  }

}