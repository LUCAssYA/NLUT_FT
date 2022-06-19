import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urooster/provider/auth_provider.dart';
import 'package:urooster/provider/eval_provider.dart';
import 'package:urooster/provider/friend_schedule_provider.dart';
import 'package:urooster/provider/home_provider.dart';
import 'package:urooster/provider/lecture_provider.dart';
import 'package:urooster/provider/my_provider.dart';
import 'package:urooster/provider/notification_provider.dart';
import 'package:urooster/provider/register_provider.dart';
import 'package:urooster/provider/schedule_provider.dart';
import 'package:urooster/screen/find_password_page.dart';
import 'package:urooster/screen/friend_schedule_page.dart';
import 'package:urooster/screen/group_list_page.dart';
import 'package:urooster/screen/main_page.dart';
import 'package:urooster/screen/register_page.dart';
import 'package:urooster/screen/signin_page.dart';
import 'package:urooster/screen/skeleton_page.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("handling a background message ${message.messageId}");
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  channel = const AndroidNotificationChannel(
    "high_importance_channel",
    "High Importance Notification",
    description: "This channel is used for important notifications. ",
    importance: Importance.high,
  );
  
  var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

  // var initializationSettingsIOS = IOSInitializationSettings(
  //   requestSoundPermission: true,
  //   requestBadgePermission: true,
  //   requestAlertPermission: true
  // );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

  var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? token = prefs.getString("token");

  if(token ==  null) {
    token = await FirebaseMessaging.instance.getToken();
  }




  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (c) => AuthProvider(token)),
      ChangeNotifierProvider(create: (c) => RegisterProvider()),
      ChangeNotifierProxyProvider<AuthProvider, HomeProvider>(
        create: (_) => HomeProvider(),
        update: (_, auth, home) => home!.update(auth),
      ),
      ChangeNotifierProxyProvider<AuthProvider, ScheduleProvider>(
          create: (_) => ScheduleProvider(),
          update: (_, auth, schedule) => schedule!.update(auth)),
      ChangeNotifierProxyProvider2<AuthProvider, ScheduleProvider,
              LectureProvider>(
          create: (_) => LectureProvider(),
          update: (_, auth, schedule, lecture) =>
              lecture!.update(auth, schedule)),
      ChangeNotifierProxyProvider<AuthProvider, EvalProvider>(
          create: (_) => EvalProvider(),
          update: (_, auth, eval) => eval!.update(auth)),
      ChangeNotifierProxyProvider<AuthProvider, NotificationProvider>(
          create: (_) => NotificationProvider(),
          update: (_, auth, notification) => notification!.update(auth)),
      ChangeNotifierProxyProvider<AuthProvider, FriendScheduleProvider>(
          create: (_) => FriendScheduleProvider(),
          update: (_, auth, friend) => friend!.update(auth)),
      ChangeNotifierProxyProvider<AuthProvider, MyPageProvider>(
          create: (_) => MyPageProvider(),
          update: (_, auth, mypage) => mypage!.update(auth))
    ],
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SignInPage(),
        routes: {
          "/signIn": (BuildContext context) => SignInPage(),
          "/findPassword": (BuildContext context) => FindPasswordPage(),
          "/resetComplete": (BuildContext context) => SendComplete(),
          "/register": (BuildContext context) => RegisterPage(),
          "/home": (BuildContext context) => SkeletonPage()
        }),
  ));
}
