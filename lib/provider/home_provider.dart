import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:urooster/provider/auth_provider.dart';
import 'package:urooster/utils/constants.dart' as constants;
import 'package:http/http.dart' as http;

class HomeProvider with ChangeNotifier {
  AuthProvider? auth;

  List schedule = [];
  List friend = [];
  List dday = [];
  List requestedFriend = [];

  var header = {"content-type": "application/json"};

  HomeProvider update(AuthProvider auth) {
    this.auth = auth;
    header = {'content-type': 'application/json', constants.tokenHeaderName: auth.token};
    return this;
  }

  Future<void> getDday() async{
    var response = await http.get(Uri.parse(constants.scheduleUrl+"/dday"));

  }

  Future<void> getFriends() async{
    var response = await http.get(Uri.parse(constants.friendUrl+"/list"), headers: header);
    List friends = jsonDecode(response.body)['response'];

    checkToken(response);


    friends.forEach((f){
      if(f['status'] == 'REQUESTED')
        requestedFriend.add({'id': f['id'], 'name': f['name']});
      else
        friend.add({'id': f['id'], 'name': f['name']});
    });

    notifyListeners();

  }

  Future<void> getToday() async{

  }

  void checkToken(http.Response response) {
    String? token = response.headers[constants.tokenHeaderName];

    if(auth?.token != token && token != null) {
      auth?.changeToken(token);
    }
  }


}