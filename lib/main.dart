import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urooster/provider/auth_provider.dart';
import 'package:urooster/screen/find_password.dart';
import 'package:urooster/screen/register_page.dart';
import 'package:urooster/screen/signin_page.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (c) => SignInProvider())],
    child: MaterialApp(home: SignInPage(), routes: {
      "/signIn": (BuildContext context) => SignInPage(),
      "/findPassword": (BuildContext context) => FindPasswordPage(),
      "/register": (BuildContext context) => RegisterPage()
    }),
  ));
}
