import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:urooster/model/signin_model.dart';
import "package:urooster/utils/constants.dart" as constant;

class AuthProvider with ChangeNotifier {
  String token = "";

  Future<void> signIn(String email, String password, GlobalKey<FormState> formKey, BuildContext context) async {
    if(formKey.currentState!.validate()) {
      var header = {"content-type": "application/json"};
      var result = await http.post(Uri.parse(constant.signInUrl),
          body: jsonEncode(SignInModel(email, password).toJson()),
          headers: header);
      token = result.headers[constant.tokenHeaderName] ?? "";
      notifyListeners();

      Navigator.pushNamed(context, "/home");
    }

  }

  void changeToken(String token) {
    this.token = token;
    notifyListeners();
  }

  String? textValidator(text) {
    if(text == null || text.isEmpty) {
      return "Can't be empty";
    }
    return null;
  }

  Future<void> findPassword(String email, GlobalKey<FormState> formKey) async{
    if(formKey.currentState!.validate()) {
      var header = {"content-type": "application/json"};
      var body = {"email": email};
      var response = await http.post(Uri.parse(constant.findPasswordUrl),
      body: jsonEncode(body),
      headers: header);
      print(response.body);
    }
  }
}