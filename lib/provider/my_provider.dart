import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:urooster/model/simple_model.dart';
import 'package:urooster/model/user_model.dart';
import 'package:urooster/provider/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'package:urooster/utils/constants.dart' as constants;

class MyPageProvider with ChangeNotifier {
  AuthProvider? auth;
  var header = {"content-type": "application/json"};

  List<SimpleModel> facultyList = [];
  SimpleModel? currentFaculty;

  UserModel user = UserModel("", "", "", "", "");

  String? password;

  MyPageProvider update(AuthProvider auth) {
    this.auth = auth;
    header = {
      "content-type": "application/json",
      constants.tokenHeaderName: auth.token
    };
    return this;
  }

  Future<void> getProfile() async {
    var response =
        await http.get(Uri.parse(constants.getDetailUrl), headers: header);

    if (response.statusCode == 200) {
      checkToken(response);

      var body = jsonDecode(response.body)['response'];

      user = UserModel.fromJson(jsonDecode(response.body)['response']);

      notifyListeners();
    }
  }

  Future<void> getFaculty() async {
    var response = await http.get(
        Uri.parse(constants.getUniversitiesUrl + "/faculty"),
        headers: header);

    if (response.statusCode == 200) {
      checkToken(response);

      facultyList = [];

      var body = jsonDecode(response.body)['response'];
      body['facultyList'].forEach((element) {
        facultyList.add(SimpleModel.fromJson(element));
      });
      currentFaculty = facultyList[body['idx'] as int];
    } else
      print(response.body);

    notifyListeners();
  }

  void checkToken(http.Response response) {
    String? token = response.headers[constants.tokenHeaderName];

    if (auth?.token != token && token != null) {
      auth?.changeToken(token);
    }
  }

  void onChangeFaculty(value) {
    currentFaculty = value;
  }

  Future<void> changeUserDetail(String name, String nickName) async {
    var response = await http.put(Uri.parse(constants.getDetailUrl),
        headers: header,
        body: jsonEncode({
          "name": name,
          "nickName": nickName,
          "faculty": currentFaculty!.id
        }));
    if(response.statusCode == 200) {
      checkToken(response);

      var body = jsonDecode(response.body)['response'];

      user = UserModel.fromJson(body);
    }
    else
      print(response.body);
    notifyListeners();
  }

  String? defaultValidator(text) {
    if(text == null) {
      return "required";
    }
    if(text is String && text.isEmpty) {
      return "required";
    }
    return null;
  }

  String? passwordValidator(text) {
    if(text != null && text != password)
      return "Password does not match";
    if(text is String && text.isNotEmpty && text != password)
      return "Password does not match";
    return null;
  }

  Future<bool> changePassword(GlobalKey<FormState> formKey, old)  async{
    var response = await http.patch(Uri.parse(constants.changePasswordUrl), headers: header, body: jsonEncode({"password": old, "newPassword": password}));

    if(response.statusCode == 200) {
      checkToken(response);
      return true;
    }
    else{
      print(response.body);
      return false;
    }

  }

}
