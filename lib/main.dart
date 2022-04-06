import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urooster/provider/auth_provider.dart';
import 'package:urooster/provider/home_provider.dart';
import 'package:urooster/provider/register_provider.dart';
import 'package:urooster/provider/schedule_provider.dart';
import 'package:urooster/screen/find_password_page.dart';
import 'package:urooster/screen/group_list_page.dart';
import 'package:urooster/screen/main_page.dart';
import 'package:urooster/screen/register_page.dart';
import 'package:urooster/screen/signin_page.dart';
import 'package:urooster/style/skeleton_page.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (c) => AuthProvider()),
      ChangeNotifierProvider(create: (c) => RegisterProvider()),
      ChangeNotifierProxyProvider<AuthProvider, HomeProvider>(
        create: (_) => HomeProvider(),
        update: (_, auth, home) => home!.update(auth),
      ),
      ChangeNotifierProxyProvider<AuthProvider, ScheduleProvider>(create: (_) => ScheduleProvider(), update: (_, auth, schedule) => schedule!.update(auth))
    ],
    child: MaterialApp(debugShowCheckedModeBanner: false,home: SignInPage(), routes: {
      "/signIn": (BuildContext context) => SignInPage(),
      "/findPassword": (BuildContext context) => FindPasswordPage(),
      "/resetComplete": (BuildContext context) => SendComplete(),
      "/register": (BuildContext context) => RegisterPage(),
      "/home": (BuildContext context) => SkeletonPage()
    }),
  ));
}