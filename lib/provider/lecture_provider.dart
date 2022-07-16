import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urooster/model/custom_lecture_model.dart';
import 'package:urooster/model/lecture_list_model.dart';
import 'package:urooster/model/simple_model.dart';
import 'package:urooster/provider/auth_provider.dart';
import 'package:urooster/provider/schedule_provider.dart';
import 'package:urooster/screen/lecture_list_page.dart';
import 'package:urooster/utils/constants.dart' as constants;
import 'package:http/http.dart' as http;

class LectureProvider with ChangeNotifier {
  List<LectureListModel> lectureList = [];
  SimpleModel? currentFaculty;
  List<SimpleModel> facultyList = [];
  List<SimpleModel> courses = [];
  SimpleModel? currentCourse;

  int tempIndex = 0;
  AuthProvider? auth;
  ScheduleProvider? scheduleProvider;
  List<Map> controllerList = [];
  Map<int, TimeAndPlace> widgets = {};

  Map<int, Map<String, dynamic>> values = {};

  String? customLectureName;
  String? customLectureStaff;
  int customIndex = 0;

  LectureProvider update(AuthProvider auth, ScheduleProvider scheduleProvider) {
    this.scheduleProvider = scheduleProvider;
    this.auth = auth;
    return this;
  }

  Future<void> getLecture(int i) async {
    tempIndex = i;

    var body = {
      "timetable": currentCourse?.id,
      "year": scheduleProvider?.currentGroup.year,
      "semester": scheduleProvider?.currentGroup.semester
    };

    var response = await http.post(
        Uri.parse(constants.lectureUrl +
            "/list?page=" +
            tempIndex.toString() +
            "&size=9"),
        headers: auth!.header,
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      checkToken(response);

      if (jsonDecode(response.body)['response'].length != 0) {

        jsonDecode(response.body)['response'].forEach((element) {
          lectureList.add(LectureListModel.fromJson(element));
        });
      }
    } else
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

  Future<void> getFaculty() async {

    var response = await http.get(
        Uri.parse(constants.getUniversitiesUrl + "/faculty"),
        headers: auth!.header);

    if (response.statusCode == 200) {
      checkToken(response);
      lectureList = [];
      var body = jsonDecode(response.body)['response'];
      facultyList = [];
      body['facultyList'].forEach((element) {
        facultyList.add(SimpleModel.fromJson(element));
      });
      currentFaculty = facultyList[body['idx'] as int];
    } else
      print(response.body);
    notifyListeners();
  }

  Future<void> getTimeTable() async {
    if (currentFaculty == {}) return;

    print(currentFaculty!.id.toString());

    var response = await http.get(
        Uri.parse(constants.timeTableUrl + "/" + currentFaculty!.id.toString()),
        headers: auth!.header);

    if (response.statusCode == 200) {
      checkToken(response);

      courses = [];
      jsonDecode(response.body)['response'].forEach((element) {
        courses.add(SimpleModel.fromJson(element));
      });


    } else {
      print(response.body);
    }

    notifyListeners();
  }

  void facultyOnChange(value) {
    lectureList = [];
    currentFaculty = value;
    currentCourse = null;
    getTimeTable();

    notifyListeners();
  }

  void courseOnChange(value) {
    lectureList = [];
    currentCourse = value;
    getLecture(0);

    notifyListeners();
  }

  Future<void> addLecture(int idx, BuildContext context) async {
    var body = {
      "group": scheduleProvider!.currentGroup.id,
      "lecture": lectureList[idx].id
    };
    var response = await http.post(Uri.parse(constants.scheduleUrl),
        body: jsonEncode(body), headers: auth!.header);

    if (response.statusCode != 200) print(response.body);
    else checkToken(response);

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

    notifyListeners();
  }

  void lectureStaffChange(value) {
    customLectureStaff = value;
    notifyListeners();
  }

  void lectureDetailChange(index, name, value) {
    if (!values.keys.contains(index)) values[index] = {};
    values[index]![name] = value;

    notifyListeners();
  }

  void changeEveryweek(index, value) {
    if (!values.keys.contains(index)) values[index] = {};
    values[index]!["everyWeek"] = value;


    notifyListeners();
  }

  Future<void> customSave(
      GlobalKey<FormState> formKey, BuildContext context) async {
    formKey.currentState!.save();
    List<Map<String, dynamic>> details = [];
    List<int> keys = values.keys.toList();

    keys.forEach((element) {
      details.add(CustomLectureDetail(
              values[element]!['date'],
              values[element]!['start'],
              values[element]!['end'],
              values[element]!['location'],
              values[element]!['everyWeek'])
          .toJson());
    });

    if (customLectureName == null || details.length == 0) return;

    var body = CustomLecture(customLectureName!, customLectureStaff!, details)
        .toJson();
    print(body);

    var response = await http.post(
        Uri.parse(constants.lectureUrl +
            "/custom/" +
            scheduleProvider!.currentGroup.id.toString()),
        body: jsonEncode(body),
        headers: auth!.header);

    if (response.statusCode != 200) {
      print(response.body);
    }
    else checkToken(response);
    Navigator.pop(context);
    Navigator.pop(context);
    scheduleProvider?.getLectures(null, null);
    widgets = {};
    values = {};

    notifyListeners();
  }

  void signOut() {
    lectureList = [];
    currentFaculty = null;
    facultyList = [];
    courses = [];
    currentCourse = null;

    tempIndex = 0;
    auth = null;
    scheduleProvider = null;
    controllerList = [];
    widgets = {};

    values = {};

    customLectureName = null;
    customLectureStaff = null;
    customIndex = 0;

    notifyListeners();
  }
}
