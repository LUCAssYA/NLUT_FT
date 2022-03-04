import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:urooster/model/signin_model.dart';
import "package:urooster/utils/constants.dart" as constant;

class SignInProvider with ChangeNotifier {
  String? token;

  Future<void> signIn(String email, String password, GlobalKey<FormState> formKey) async {
    if(formKey.currentState!.validate()) {
      var header = {"content-type": "application/json"};
      var result = await http.post(Uri.parse(constant.signInUrl),
          body: jsonEncode(SignInModel(email, password).toJson()),
          headers: header);
      token = result.headers[constant.tokenHeaderName];
      notifyListeners();
    }

  }

  void changeToken(String token) {
    this.token = token;
    notifyListeners();
  }

  String? signInValidator(text) {
    if(text == null || text.isEmpty) {
      return "Can't be empty";
    }
    return null;
  }
}