import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:urooster/model/signin_model.dart';

class SignInProvider with ChangeNotifier {
  String? token;

  Future<void> signIn(String email, String password) async {
    print(email+"   "+password);
    var header = {"content-type":"application/json"};
    var result = await http.post(Uri.parse("http://localhost:8080/api/users/login"), body: jsonEncode(SignInModel(email, password).toJson()), headers: header);
    token = result.headers['x-auth-token'];
    notifyListeners();
  }
}