import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:urooster/model/register_model.dart';
import 'package:urooster/model/simple_model.dart';
import 'package:urooster/model/university_model.dart';
import 'package:urooster/utils/constants.dart' as constant;

class RegisterProvider with ChangeNotifier {
  bool verified = false;
  List<UniversityModel> universities = [];
  List<SimpleModel> faculties = [];
  String? domain = "";
  int? faculty;
  String? password;
  int? uni;

  var header = {"content-type": "application/json"};

  Future<void> getUniversities() async {
    var response =
        await http.get(Uri.parse(constant.getUniversitiesUrl), headers: header);
    var body = jsonDecode(response.body)['response'];

    body.forEach((element) {
      universities.add(UniversityModel.fromJson(element));
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
    if (value != null) {
      var response = await http.get(
          Uri.parse(constant.getUniversitiesUrl + "/" + value.id.toString()),
          headers: header);
      var body = jsonDecode(response.body)['response'];
      faculties = [];
      print(body);
      body.forEach((element){
        faculties.add(SimpleModel.fromJson(element));
      });
      domain = value.domain;
      uni = value.id;
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

      if (result.statusCode == 200){
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Register Success")));
        Navigator.pushNamed(context, "/signIn");
      }

      else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(body['error'])));
      }
    }
  }

  Future<void> sendVerifitionCode(String email, BuildContext context) async {
    if (domain != null || domain!.isNotEmpty) {
      var result = await http.post(Uri.parse(constant.emailAuthUrl+"/auth"),
          headers: header, body: jsonEncode({"email": email + "@" + domain!}));
      var body = jsonDecode(result.body);
      if (result.statusCode != 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(body['error']['message'])));
      }
    }
  }

  Future<void> verifyCode(String email, String code, BuildContext context) async{
    var result = await http.post(Uri.parse(constant.emailAuthUrl+"/verifyCode"), headers: header, body: jsonEncode({"email": email+"@"+domain!, "code": code}));
    
    if(result.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Success")));
      verified = true;

      notifyListeners();
    }
    else {
      print(result.body);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Verify Failed")));
    }
  }
}
