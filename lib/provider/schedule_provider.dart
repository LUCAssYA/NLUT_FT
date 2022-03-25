import 'package:flutter/cupertino.dart';
import 'package:urooster/provider/auth_provider.dart';

class ScheduleProvider with ChangeNotifier {
  AuthProvider? auth;
  void update(AuthProvider auth) {
    this.auth = auth;
  }
}