import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:urooster/model/schedule_model.dart';
import 'package:urooster/provider/auth_provider.dart';
import 'package:urooster/utils/constants.dart' as constants;
import 'package:http/http.dart' as http;
import 'package:urooster/utils/format.dart' as format;

import '../model/group_detail_model.dart';

class FriendScheduleProvider with ChangeNotifier {
  AuthProvider? auth;
  List<GroupDetail> groups = [];
  GroupDetail? currentGroup;

  List<ScheduleModel> schedules = [];

  FriendScheduleProvider update(AuthProvider auth) {
    this.auth = auth;
    return this;
  }

  Future<void> getFriendGroup(int id) async {
    var response = await http.get(Uri.parse(constants.groupUrl+"/friend/"+id.toString()), headers: auth!.header);

    if(response.statusCode == 200) {
      checkToken(response);

      var body = jsonDecode(response.body)['response'];

      body.forEach((element){
        groups.add(GroupDetail.fromJson(element));
      });

      notifyListeners();

    }
    else
      print(response.body);

  }

  void clear() {
    groups = [];
    currentGroup = null;
  }

  void checkToken(http.Response response) {
    String? token = response.headers[constants.tokenHeaderName];

    if (auth?.token != token && token != null) {
      auth?.changeToken(token);
    }
  }

  Future<void> getFriendScheduleList(DateTime start, DateTime end) async{
    var body = {"start": format.yyyyMMdd.format(start).toString(), "end": format.yyyyMMdd.format(end).toString()};
    var response = await http.post(Uri.parse(constants.scheduleUrl+"/friend/"+currentGroup!.id.toString()), headers: auth!.header, body: jsonEncode(body));

    if(response.statusCode == 200) {
      checkToken(response);
      var body =  jsonDecode(response.body)['response'];

      schedules = [];
      body.forEach((element) {
        schedules.add(ScheduleModel.fromJson(element));
      });
    }
    else
      print(response.body);

    notifyListeners();
  }

  void changeCurrentGroup(value) {
    currentGroup = value;
    notifyListeners();
  }

  void signOut() {
    auth = null;
    groups = [];
    currentGroup = null;

    schedules = [];
  }

}