import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:urooster/model/lecture_list_model.dart';
import 'package:urooster/provider/auth_provider.dart';
import 'package:urooster/utils/constants.dart' as constants;
import "package:http/http.dart" as http;

class EvalProvider with ChangeNotifier {
  AuthProvider? auth;
  var header = {"content-type": "application/json"};
  int idx = 0;

  List<LectureListModel> lectureList = [];

  String name = "";


  EvalProvider update(AuthProvider auth) {
    this.auth = auth;
    header = {'content-type': 'application/json', constants.tokenHeaderName: auth.token};
    return this;
  }

  Future<void> findLecture(String? name, int idx) async {
    this.idx = idx;
    if(name != null) {
      lectureList = [];
      this.name = name;
    }

    var response = await http.get(Uri.parse(constants.lectureUrl+"/"+this.name+"?page="+idx.toString()+"&size=9"), headers: header);

    print(response.body);


    if(response.statusCode == 200 ){
      jsonDecode(response.body)['response'].forEach((element){
        lectureList.add(LectureListModel.fromJson(element));
      });
    }
    else
      print(response.body);

    notifyListeners();
  }

  void resetLecture() {
    lectureList = [];
    idx = 0;
  }
}