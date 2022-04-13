import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:urooster/model/lecture_list_model.dart';
import 'package:urooster/provider/auth_provider.dart';
import 'package:urooster/utils/constants.dart' as constants;
import 'package:http/http.dart' as http;

class LectureProvider with ChangeNotifier{
  List<LectureListModel> lectureList = [];
  Map currentFaculty = {};
  List facultyList = [];
  List courses = [];
  Map currentCourse = {};

  int tempIndex = 0;
  AuthProvider? auth;
  var header = {"content-type": "application/json"};

  LectureProvider update(AuthProvider auth) {
    this.auth = auth;
    header = {
      'content-type': 'application/json',
      constants.tokenHeaderName: auth.token
    };
    return this;
  }

  Future<void> getLecture(int i) async{
    tempIndex = i;




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
      facultyList = body['facultyList'];
      currentFaculty = body['userFaculty'];
    }
    notifyListeners();
  }

  Future<void> getTimeTable() async {

    if(currentFaculty == {})
      return;

    var response = await http.get(Uri.parse(constants.timeTableUrl+"/"+currentFaculty['id'].toString()), headers: header);

    if(response.statusCode == 200){
      checkToken(response);

      courses = jsonDecode(response.body)['response'];

    }

    notifyListeners();
  }

  void facultyOnChange(value) {
    print(value);

    currentFaculty = value;
    getTimeTable();

  }

  void courseOnChange(value) {
    print(value);
    currentCourse = value;
    getLecture(0);
  }

}