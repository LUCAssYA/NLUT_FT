import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:urooster/model/friend_model.dart';
import 'package:urooster/provider/auth_provider.dart';
import 'package:urooster/utils/constants.dart' as constants;
import 'package:http/http.dart' as http;

class NotificationProvider with ChangeNotifier {
  AuthProvider? auth;
  var header = {"content-type": "application/json"};
  List<FriendModel> friendList = [];

  NotificationProvider update(AuthProvider auth) {
    this.auth = auth;
    header = {
      'content-type': 'application/json',
      constants.tokenHeaderName: auth.token
    };
    return this;
  }

  Future<void> getRequestedFriend() async{
    var response = await http.get(Uri.parse(constants.friendUrl+"/request"), headers: header);

    if(response.statusCode == 200) {
      checkToken(response);

      friendList = [];
      var body = jsonDecode(response.body)['response'];

      body.forEach((element){
        friendList.add(FriendModel.fromJson(element));
      });

      notifyListeners();

    }
  }

  void checkToken(http.Response response) {
    String? token = response.headers[constants.tokenHeaderName];

    if (auth?.token != token && token != null) {
      auth?.changeToken(token);
    }
  }

}