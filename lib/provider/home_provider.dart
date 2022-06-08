import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urooster/model/dday_model.dart';
import 'package:urooster/model/friend_model.dart';
import 'package:urooster/model/today_schedule_model.dart';
import 'package:urooster/provider/auth_provider.dart';
import 'package:urooster/screen/main_page.dart';
import 'package:urooster/utils/constants.dart' as constants;
import 'package:http/http.dart' as http;

class HomeProvider with ChangeNotifier {
  AuthProvider? auth;

  List schedule = [];
  List<FriendModel> friend = [];
  List dday = [];

  HomeProvider update(AuthProvider auth) {
    this.auth = auth;
    return this;
  }

  Future<void> getDday() async{
    var response = await http.get(Uri.parse(constants.scheduleUrl+"/dday"), headers: auth!.header);
    dday = [];

    if(response.statusCode == 200) {
      List dDayResponse = jsonDecode(response.body)['response'];

      checkToken(response);

      dDayResponse.forEach((element) {
        dday.add(DdayModel.fromJson(element));
      });

      notifyListeners();
    }

    else {
      print(response.body);
    }

  }

  Future<void> getFriends() async{
    friend = [];
    var response = await http.get(Uri.parse(constants.friendUrl+"/list"), headers: auth!.header);

    if(response.statusCode == 200) {
      List friends = jsonDecode(response.body)['response'];

      checkToken(response);


      friends.forEach((f){
        friend.add(FriendModel.fromJson(f));
      });

      notifyListeners();
    }
    else{
      print(response.body);
    }



  }

  Future<void> getToday() async{
    var response = await http.get(Uri.parse(constants.scheduleUrl), headers: auth!.header);
    schedule = [];

    if(response.statusCode == 200) {
      checkToken(response);

      List today = jsonDecode(response.body)['response'];

      today.forEach((element) {
        schedule.add(TodayScheduleModel.fromJson(element));
      });

      notifyListeners();


    }
    else {
      print(response.body);
    }
  }

  void checkToken(http.Response response) {
    String? token = response.headers[constants.tokenHeaderName];

    if(auth?.token != token && token != null) {
      auth?.changeToken(token);
    }
  }

  Future<void> deleteDday(int index) async{
    var response = await http.put(Uri.parse(constants.scheduleUrl+"/dday/delete/"+dday[index].id.toString()),
        headers: auth!.header);

    if(response.statusCode == 200) {
      dday = [];

      List dDayResponse = jsonDecode(response.body)['response'];
      print(dDayResponse);

      checkToken(response);

      dDayResponse.forEach((element) {
        dday.add(DdayModel.fromJson(element));
      });

      notifyListeners();
    }
    else {
      print(response.body);
    }

  }

  Future<void> deleteFriend(BuildContext context, int index) async {
    var response = await http.delete(Uri.parse(constants.friendUrl+"/delete/"+friend[index].id.toString()), headers: auth!.header);

    if(response.statusCode == 200) {
      List friends = jsonDecode(response.body)['response'];
      friend = [];

      checkToken(response);


      friends.forEach((f){
          friend.add(FriendModel.fromJson(f));
      });

      notifyListeners();
    }
    else{
      print(response.body);
    }

    Navigator.pop(context);

  }
  
  Future<void> addFriend(BuildContext context, String text) async {
    var response = await http.post(Uri.parse(constants.friendUrl+"/request"), headers: auth!.header, body: jsonEncode({"email": text}));
    var body = jsonDecode(response.body)['response'];


    if(response.statusCode == 200) {
      checkToken(response);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Request Complete")));
      Navigator.pop(context);
    }
    else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(body["error"])));
      Navigator.pop(context);
    }


  }
  void signOut() {
    auth = null;

    schedule = [];
    friend = [];
    dday = [];
  }

}