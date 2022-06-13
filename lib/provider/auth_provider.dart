import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:urooster/model/signin_model.dart';
import "package:urooster/utils/constants.dart" as constant;

class AuthProvider with ChangeNotifier {
  String token = "";
  var header = {"content-type": "application/json"};
  static final storage = new FlutterSecureStorage();

  Future<void> autoSignIn(BuildContext context, url) async{
    String? userInfo = await storage.read(key: "login");

    if(userInfo != null) {
      String email = userInfo.split(" ")[1];
      String password = userInfo.split(" ")[3];

      var result = await http.post(Uri.parse(constant.signInUrl), body: jsonEncode(SignInModel(email, password).toJson()), headers: header);

      if(result.statusCode == 200) {
        token = result.headers[constant.tokenHeaderName]??"";
        header[constant.tokenHeaderName] = token;
        notifyListeners();

        if(url != "") {
          Navigator.pushNamed(context, url);
        }
      }
    }


  }

  Future<void> signIn(String email, String password,
      GlobalKey<FormState> formKey, BuildContext context) async {
    if (formKey.currentState!.validate()) {
      header = {"content-type": "application/json"};
      var result = await http.post(Uri.parse(constant.signInUrl),
          body: jsonEncode(SignInModel(email, password).toJson()),
          headers: header);

      var body = jsonDecode(result.body);

      if (result.statusCode == 200) {
        await storage.write(key: "login", value: "id "+email+" "+"password "+password);
        token = result.headers[constant.tokenHeaderName] ?? "";
        header[constant.tokenHeaderName] = token;
        notifyListeners();

        Navigator.pushNamed(context, "/home");
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(body['error']['message'])));
      }
    }
  }

  void changeToken(String token) {
    this.token = token;
    notifyListeners();
  }

  String? textValidator(text) {
    if (text == null || text.isEmpty) {
      return "Can't be empty";
    }
    return null;
  }

  Future<void> findPassword(String email, GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      var header = {"content-type": "application/json"};
      var body = {"email": email};
      var response = await http.post(Uri.parse(constant.findPasswordUrl),
          body: jsonEncode(body), headers: header);
      print(response.body);
    }
  }

  void singOut() {
    token = "";
    notifyListeners();
  }
}
