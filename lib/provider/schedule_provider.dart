import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:urooster/model/group_detail_model.dart';
import 'package:urooster/model/group_list_model.dart';
import 'package:urooster/provider/auth_provider.dart';
import 'package:urooster/utils/constants.dart' as constants;
import 'package:http/http.dart' as http;

import '../model/schedule_model.dart';

class ScheduleProvider with ChangeNotifier {
  AuthProvider? auth;
  var header = {"content-type": "application/json"};
  GroupDetail currentGroup = GroupDetail(-1, "", "0", "0", "0", null, null);
  List<GroupList> groupList = [];
  List<ScheduleModel> schedules = <ScheduleModel>[];
  
  ScheduleProvider update(AuthProvider auth) {
    this.auth = auth;
    header = {'content-type': 'application/json', constants.tokenHeaderName: auth.token};
    return this;
  }

  Future<void> getGroups() async{
    var response = await http.get(Uri.parse(constants.groupUrl+"/group-list"), headers: header);
    
    if(response.statusCode == 200) {
      checkToken(response);
      var body = jsonDecode(response.body)['response'];
      currentGroup = GroupDetail.fromJson(body['currentGroup']);

      if(groupList.length != body['groups'].length) {
        groupList = [];
        body['groups'].forEach((element) {
          groupList.add(GroupList.fromJson(element));
        });
      }

      notifyListeners();
    }
    else
      print(response.body);
  }

  Future<void> getLectures(DateTime start, DateTime end) async{
    print("response");
    print(start);
    DateFormat format = DateFormat("yyyy-MM-dd");
    print(format.format(start).toString());
    var response = await http.post(Uri.parse(constants.scheduleUrl+"/"+currentGroup.id.toString()), headers: header, body: jsonEncode({"start": format.format(start).toString(), "end": format.format(end).toString()}));
    print("response");
    if(response.statusCode == 200) {
      checkToken(response);
      schedules = [];
      var body = jsonDecode(response.body)['response'];
      print(body);

      body.forEach((element) {
        schedules.add(ScheduleModel.fromJson(element));
      });
      notifyListeners();

    }
    else
      print(response.body);


  }

  void checkToken(http.Response response) {
    String? token = response.headers[constants.tokenHeaderName];

    if(auth?.token != token && token != null) {
      auth?.changeToken(token);
    }
  }
}