import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:urooster/model/signin_model.dart';

class LoginProvider with ChangeNotifier {
  String? token;

  Future<void> signIn(String email, String password) async {
    var result = await http.post(Uri.parse("http://localhost:8080/api/users/login"), body: SignInModel(email, password).toJson());
    print(result.headers);
  }
}