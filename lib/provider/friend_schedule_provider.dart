import 'package:flutter/material.dart';
import 'package:urooster/provider/auth_provider.dart';

class FriendScheduleProvider with ChangeNotifier {
  AuthProvider? auth;

  FriendScheduleProvider update(AuthProvider auth) {
    this.auth = auth;
    return this;
  }
}