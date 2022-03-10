import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:urooster/model/register_model.dart';
import 'package:urooster/utils/constants.dart' as constant;

class RegisterProvider with ChangeNotifier {
  bool verified = false;
  Map<String, String> universities = new Map();
  List<String> faculties = [];
  String? domain = "";
  String? faculty;
  String? password;
  String? uni;

  var header = {"content-type": "application/json"};

  Future<void> getUniversities() async {
    var response =
        await http.get(Uri.parse(constant.getUniversitiesUrl), headers: header);
    var body = jsonDecode(response.body)['response'];

    body.forEach((element) {
      universities[element['name'] as String] = element['domain'] as String;
    });

    notifyListeners();
  }

  String? defaultValidator(text) {
    if (text == null || text.isEmpty) {
      return "*required";
    }
    return null;
  }

  Future<void> uniOnChange(value) async {
    if (value != null && value.isNotEmpty) {
      var response = await http.get(
          Uri.parse(constant.getUniversitiesUrl + "/" + value),
          headers: header);
      faculties = jsonDecode(response.body)['response'].cast<String>();
      domain = universities[value];
      uni = value;
      notifyListeners();
    }
  }

  void facultyOnChange(value) {
    faculty = value;
    notifyListeners();
  }

  String? emailValidator(text) {
    if (!verified) {
      return "Please verify your Email";
    }
    return null;
  }

  String? passwordValidator(text) {
    if (text == null || text.isEmpty)
      return "*required";
    else if (text != password) return "Password does not match";
    return null;
  }

  void passwordChange(text) {
    password = text;
    notifyListeners();
  }

  Future<void> onButtonPress(
      String email,
      String password,
      String name,
      String nickName,
      GlobalKey<FormState> formKey,
      BuildContext context) async {
    if (formKey.currentState!.validate()) {
      var result = await http.post(Uri.parse(constant.signUpUrl),
          headers: header,
          body: jsonEncode(RegisterModel(email + "@" + domain!, name, faculty!,
              uni!, nickName, password)));
      var body = jsonDecode(result.body);

      if (result.statusCode == 200)
        Navigator.pushNamed(context, "/signIn");
      else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(body['error'])));
      }
    }
  }

  Future<void> sendVerifitionCode(String email, BuildContext context) async {
    if (domain != null || domain!.isNotEmpty) {
      var result = await http.post(Uri.parse(constant.emailAuthUrl),
          headers: header, body: jsonEncode({"email": email + "@" + domain!}));
      var body = jsonDecode(result.body);
      if (result.statusCode != 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(body['error'])));
      }
    }
  }

  Future<void> verifyCode(String email, String code, BuildContext context) async{
    var result = await http.post(Uri.parse(constant.verifyCodeUrl), headers: header, body: jsonEncode({"email": email, "code": code}));
    
    if(result.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Success")));
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Verify Failed")));
    }
  }
}
