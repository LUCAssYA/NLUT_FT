import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:urooster/model/simple_model.dart';
import 'package:urooster/model/user_model.dart';
import 'package:urooster/provider/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'package:urooster/utils/constants.dart' as constants;

class MyPageProvider with ChangeNotifier {
  AuthProvider? auth;

  List<SimpleModel> facultyList = [];
  SimpleModel? currentFaculty;

  UserModel user = UserModel("", "", "", "", "");

  String? password;

  MyPageProvider update(AuthProvider auth) {
    this.auth = auth;
    return this;
  }

  Future<void> getProfile() async {
    var response =
        await http.get(Uri.parse(constants.getDetailUrl), headers: auth!.header);

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
        headers: auth!.header);

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
        headers: auth!.header,
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

  Future<String> changePassword(GlobalKey<FormState> formKey, old)  async{
    if(formKey.currentState!.validate()) {
      var response = await http.patch(
          Uri.parse(constants.changePasswordUrl), headers: auth!.header,
          body: jsonEncode({"password": old, "newPassword": password}));

      if (response.statusCode == 200) {
        checkToken(response);
        return "";
      }
      else {
        print(response.body);
        return jsonDecode(response.body)['error']['message'];
      }
    }
    return "";

  }

  void onChangePassword(value) {
    password = value;
  }

  Future<void> signOut() async{
    var response = await http.post(Uri.parse(constants.signOutUrl), headers: auth!.header);

    auth = null;

    facultyList = [];
    currentFaculty = null;

    user = UserModel("", "", "", "", "");

    password = null;

    notifyListeners();
  }
  
  Future<void> withDraw() async{
    var response = await http.delete(Uri.parse(constants.userUrl), headers: auth!.header);
    print(response.body);

    auth = null;

    facultyList = [];
    currentFaculty = null;

    user = UserModel("", "", "", "", "");

    password = null;

    notifyListeners();

  }

}
