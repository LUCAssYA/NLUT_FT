import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urooster/provider/signin_provider.dart';
import 'package:urooster/screen/signin_page.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (c) => SignInProvider())],
    child: MaterialApp(home: SignInPage()),
  ));
}
