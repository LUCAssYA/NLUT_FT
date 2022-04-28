import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:urooster/model/lecture_list_model.dart';
import 'package:urooster/model/simple_model.dart';
import 'package:urooster/provider/auth_provider.dart';
import 'package:urooster/provider/schedule_provider.dart';
import 'package:urooster/screen/lecture_list_page.dart';
import 'package:urooster/utils/constants.dart' as constants;
import 'package:http/http.dart' as http;

class LectureProvider with ChangeNotifier{
  List<LectureListModel> lectureList = [];
  SimpleModel? currentFaculty;
  List<SimpleModel> facultyList = [];
  List<SimpleModel> courses = [];
  SimpleModel? currentCourse;
  List<Map> controllerList = [];
  Map<int, TimeAndPlace> widgets = {};

  Map<int, Map<String, dynamic>> values = {};


  int tempIndex = 0;
  AuthProvider? auth;
  ScheduleProvider? scheduleProvider;

  String? customLectureName;
  String? customLectureLocation;

  int customIndex = 0;

  var header = {"content-type": "application/json"};

  LectureProvider update(AuthProvider auth, ScheduleProvider scheduleProvider) {
    this.scheduleProvider = scheduleProvider;
    this.auth = auth;
    header = {
      'content-type': 'application/json',
      constants.tokenHeaderName: auth.token
    };
    return this;
  }

  Future<void> getLecture(int i) async{
    tempIndex = i;

    var body = {"timetable": currentCourse?.id, "year": scheduleProvider?.currentGroup.year, "semester": scheduleProvider?.currentGroup.semester};

    var response = await http.post(Uri.parse(constants.lectureUrl+"/list?page="+tempIndex.toString()+"&size=20"), headers: header, body: jsonEncode(body));

    if(response.statusCode == 200) {
      checkToken(response);

      lectureList = [];

      jsonDecode(response.body)['response'].forEach((element){
        lectureList.add(LectureListModel.fromJson(element));
      });
    }
    else
      print(response.body);

    notifyListeners();


  }

  void onClickAddAndTime() {
    widgets[customIndex] = TimeAndPlace(index: customIndex);
    customIndex++;
    notifyListeners();
  }

  void checkToken(http.Response response) {
    String? token = response.headers[constants.tokenHeaderName];

    if (auth?.token != token && token != null) {
      auth?.changeToken(token);
    }
  }

  Future<void> getFaculty() async{
    var response = await http.get(Uri.parse(constants.getUniversitiesUrl+"/faculty"), headers: header);

    if(response.statusCode == 200) {
      checkToken(response);

      var body = jsonDecode(response.body)['response'];
      facultyList = [];
      body['facultyList'].forEach((element){
        facultyList.add(SimpleModel.fromJson(element));
      });
      currentFaculty = facultyList[body['idx'] as int];
    }
    else
      print(response.body);
    notifyListeners();
  }

  Future<void> getTimeTable() async {

    if(currentFaculty == {})
      return;

    var response = await http.get(Uri.parse(constants.timeTableUrl+"/"+currentFaculty!.id.toString()), headers: header);

    if(response.statusCode == 200){
      checkToken(response);

      courses = [];
      jsonDecode(response.body)['response'].forEach((element){
        courses.add(SimpleModel.fromJson(element));
      });

    }
    else
      print(response);

    notifyListeners();
  }

  void facultyOnChange(value) {
    currentFaculty = value;
    currentCourse = null;
    getTimeTable();

  }

  void courseOnChange(value) {
    currentCourse = value;
    getLecture(0);
  }

  Future<void> addLecture(int idx, BuildContext context) async {
    var body = {"group": scheduleProvider!.currentGroup.id, "lecture": lectureList[idx].id};
    var response = await http.post(Uri.parse(constants.scheduleUrl), body: jsonEncode(body), headers: header);

    if(response.statusCode != 200)
      print(response.body);

    scheduleProvider?.getLectures(null, null);
    Navigator.pop(context);
  }

  void removeWidget(int idx) {
    widgets.remove(idx);
    values.remove(idx);
    notifyListeners();
  }
  void lectureNameChange(value) {
    customLectureName = value;
  }

  void lectureLocationChange(value) {
    customLectureLocation = value;
  }

  void lectureDetailChange(index, name, value) {
    if(!values.keys.contains(index))
      values[index] = {};
    values[index]![name] = value;
  }
  void changeEveryweek(index, value) {
    if(!values.keys.contains(index))
      values[index] = {};
    values[index]!["everyWeek"] = value;
  }


}