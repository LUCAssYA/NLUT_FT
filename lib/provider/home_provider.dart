import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:urooster/model/dday_model.dart';
import 'package:urooster/model/today_schedule_model.dart';
import 'package:urooster/provider/auth_provider.dart';
import 'package:urooster/screen/main_page.dart';
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
    var response = await http.get(Uri.parse(constants.scheduleUrl+"/dday"), headers: header);

    if(response.statusCode == 200) {
      List dDayResponse = jsonDecode(response.body)['response'];

      checkToken(response);

      dDayResponse.forEach((element) {
        dday.add(DdayModel.fromJson(element));
      });

      notifyListeners();
    }

  }

  Future<void> getFriends() async{
    var response = await http.get(Uri.parse(constants.friendUrl+"/list"), headers: header);

    if(response.statusCode == 200) {
      List friends = jsonDecode(response.body)['response'];

      checkToken(response);


      friends.forEach((f){
        if(f['status'] == 'REQUESTED')
          requestedFriend.add(f);
        else
          friend.add(f);
      });

      notifyListeners();
    }



  }

  Future<void> getToday() async{
    var response = await http.get(Uri.parse(constants.scheduleUrl), headers: header);

    if(response.statusCode == 200) {
      checkToken(response);

      List today = jsonDecode(response.body)['response'];

      today.forEach((element) {
        schedule.add(TodayScheduleModel.fromJson(element));
      });

      notifyListeners();


    }

  }

  void checkToken(http.Response response) {
    String? token = response.headers[constants.tokenHeaderName];

    if(auth?.token != token && token != null) {
      auth?.changeToken(token);
    }
  }


}