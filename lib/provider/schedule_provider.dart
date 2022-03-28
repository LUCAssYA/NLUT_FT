import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:urooster/model/group_detail_model.dart';
import 'package:urooster/model/group_list_model.dart';
import 'package:urooster/provider/auth_provider.dart';
import 'package:urooster/utils/constants.dart' as constants;
import 'package:http/http.dart' as http;

class ScheduleProvider with ChangeNotifier {
  AuthProvider? auth;
  var header = {"content-type": "application/json"};
  GroupDetail currentGroup = GroupDetail(-1, "", "0", "0", "0", null, null);
  List<GroupList> groupList = [];
  
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
      print(body);
      currentGroup = GroupDetail.fromJson(body['currentGroup']);

      if(groupList.length != body['groups'].length) {
        groupList = [];
        print(body['groups']);
        body['groups'].forEach((element) {
          groupList.add(GroupList.fromJson(element));
        });
      }

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