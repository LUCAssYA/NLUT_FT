import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:urooster/model/group_detail_model.dart';
import 'package:urooster/model/group_list_model.dart';
import 'package:urooster/provider/auth_provider.dart';
import 'package:urooster/utils/constants.dart' as constants;
import 'package:http/http.dart' as http;
import 'package:urooster/utils/format.dart' as format;

import '../model/schedule_model.dart';

class ScheduleProvider with ChangeNotifier {
  AuthProvider? auth;
  var header = {"content-type": "application/json"};
  GroupDetail currentGroup = GroupDetail(-1, "", "0", "0", "0", DateTime.now().add(Duration(days: -50)), DateTime.now().add(Duration(days:50)));
  List<GroupList> groupList = [];
  List<ScheduleModel> schedules = <ScheduleModel>[];
  DateTime? start;
  DateTime? end;
  DateTime? currentDate;

  ScheduleProvider update(AuthProvider auth) {
    this.auth = auth;
    header = {
      'content-type': 'application/json',
      constants.tokenHeaderName: auth.token
    };
    return this;
  }

  Future<void> getGroups() async {
    var response = await http.get(Uri.parse(constants.groupUrl + "/group-list"),
        headers: header);

    if (response.statusCode == 200) {
      checkToken(response);
      var body = jsonDecode(response.body)['response'];
      currentGroup = GroupDetail.fromJson(body['currentGroup']);

      if (groupList.length != body['groups'].length) {
        groupList = [];
        body['groups'].forEach((element) {
          groupList.add(GroupList.fromJson(element));
        });
      }

      notifyListeners();
    } else
      print(response.body);
  }

  Future<void> getLectures(DateTime start, DateTime end) async {
    this.start = start;
    this.end = end;
    if(currentGroup.endDate.isAfter(end))
      this.currentDate = start;

    var response = await http.post(
        Uri.parse(constants.scheduleUrl + "/" + currentGroup.id.toString()),
        headers: header,
        body: jsonEncode({
          "start": format.yyyyMMdd.format(start).toString(),
          "end": format.yyyyMMdd.format(end).toString()
        }));
    if (response.statusCode == 200) {
      checkToken(response);
      schedules = [];
      var body = jsonDecode(response.body)['response'];

      body.forEach((element) {
        schedules.add(ScheduleModel.fromJson(element));
      });
    } else
      print(response.body);

    notifyListeners();
  }

  void checkToken(http.Response response) {
    String? token = response.headers[constants.tokenHeaderName];

    if (auth?.token != token && token != null) {
      auth?.changeToken(token);
    }
  }

  Future<void> changeDday(schedule, dday, context) async {
    var response = await http.put(
        Uri.parse(constants.scheduleUrl + "/dday/" + schedule.id.toString()),
        headers: header,
        body: jsonEncode({"dDay": dday}));

    if (response.statusCode == 200) {
      checkToken(response);
      schedule.dday = dday;
    } else
      print(response.body);
    Navigator.pop(context);
  }

  Future<void> removeOneSchedule(schedule, context) async{
    var response =  await http.delete(
        Uri.parse(constants.scheduleUrl + "/" + schedule.id.toString()),
        headers: header);
    if(response.statusCode == 200) {
      checkToken(response);
      schedules.remove(schedule);
    }
    else
      print(response.body);
    notifyListeners();

    Navigator.pop(context);
    Navigator.pop(context);
  }

  Future<void> removeAllSchedule(schedule, context) async {
    var response = await http.post(
        Uri.parse(constants.scheduleUrl + "/all/" + schedule.id.toString()),
        headers: header,
        body: jsonEncode({
          "start": format.yyyyMMdd.format(start!).toString(),
          "end": format.yyyyMMdd.format(end!).toString()
        }));

    if (response.statusCode == 200) {
      checkToken(response);
      schedules = [];
      var body = jsonDecode(response.body)['response'];

      body.forEach((element) {
        schedules.add(ScheduleModel.fromJson(element));
      });
    }
    else
      print(response.body);
    notifyListeners();

    Navigator.pop(context);
    Navigator.pop(context);
  }

  Future<void> updateScope(String scope, BuildContext context) async{
    var response = await http.patch(Uri.parse(constants.groupUrl+"/update-scope/"+currentGroup.id.toString()), headers: header, body: jsonEncode({"scope": scope}));

    if(response.statusCode == 200){
      checkToken(response);
      var body = jsonDecode(response.body)['response'];
      currentGroup = GroupDetail.fromJson(body);
    }
    else
      print(response.body);

    notifyListeners();
    Navigator.pop(context);
  }

  Future<void> getGroupDetail(int id, BuildContext context, CalendarController controller) async{
    var response = await http.get(Uri.parse(constants.groupUrl+"/detail/"+id.toString()), headers: header);

    if(response.statusCode == 200) {
      checkToken(response);
      currentGroup = GroupDetail.fromJson(jsonDecode(response.body)['response']);
    }
    else
      print(response.body);
    if(currentGroup.startDate.isBefore(DateTime.now()) && currentGroup.endDate.isAfter(DateTime.now()))
      currentDate = DateTime.now();
    else
      currentDate = currentGroup.startDate;

    notifyListeners();
    Navigator.pop(context);
    print(currentDate);
    controller.displayDate = currentDate;

  }


}
