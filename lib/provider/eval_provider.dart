import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:urooster/model/eval_detail_model.dart';
import 'package:urooster/model/lecture_list_model.dart';
import 'package:urooster/provider/auth_provider.dart';
import 'package:urooster/utils/constants.dart' as constants;
import "package:http/http.dart" as http;

class EvalProvider with ChangeNotifier {
  AuthProvider? auth;
  var header = {"content-type": "application/json"};
  int idx = 0;
  double newEvalScore = 0;

  List<LectureListModel> lectureList = [];
  List<EvalDetailModel> evalList = [];
  
  LectureListModel lecture = LectureListModel(-1, "", "", 0);

  String name = "";

  bool written = true;

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

  Future<void> evalDetail(int id) async {
    var response = await http.get(Uri.parse(constants.evalUrl+"/detail/"+id.toString()), headers: header);

    if(response.statusCode == 200){
      checkToken(response);
      evalList = [];
      var body = jsonDecode(response.body)['response'];
      print(body);
      
      lecture = LectureListModel.fromJson(body);
      written = body['written'];
      body['list'].forEach((element){
        evalList.add(EvalDetailModel.fromJson(element));
      });
    }
    else
      print(response.body);
    notifyListeners();
  }

  void checkToken(http.Response response) {
    String? token = response.headers[constants.tokenHeaderName];

    if (auth?.token != token && token != null) {
      auth?.changeToken(token);
    }
  }

  void changeScore(double rating) {
    newEvalScore = rating;
  }
  
  Future<void> submitNewEval(String description, BuildContext context, int? id) async{
    var response;
    if(newEvalScore == 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(behavior: SnackBarBehavior.floating,margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height-100),content: Text("Please check score")));
      return;
    }

    if(id == null)
      response = await http.post(Uri.parse(constants.evalUrl+"/"+lecture.id.toString()), headers: header, body: jsonEncode(EvalDetailModel.of(newEvalScore, description).toJson()));
    else
      response = await http.put(Uri.parse(constants.evalUrl+"/"+id.toString()), headers: header, body: jsonEncode(EvalDetailModel.of(newEvalScore, description).toJson()));

    if(response.statusCode == 200 ){
      checkToken(response);

      var body = jsonDecode(response.body)['response'];

      lecture = LectureListModel.fromJson(body);
      evalList = [];
      written = body['written'];
      body['list'].forEach((element){
        evalList.add(EvalDetailModel.fromJson(element));
      });
      newEvalScore = 0;

      notifyListeners();

      Navigator.pop(context);
    }
    else
      print(response.body);
  }

  Future<void> removeEval() async {
    var response = await http.delete(Uri.parse(constants.evalUrl+"/"+evalList[0].id.toString()), headers: header);

    if(response.statusCode == 200) {
      checkToken(response);

      var body = jsonDecode(response.body)['response'];
      print(body);

      lecture = LectureListModel.fromJson(body);
      evalList = [];
      written = body['written'];
      body['list'].forEach((element) {
        evalList.add(EvalDetailModel.fromJson(element));
      });

      notifyListeners();
    }
    else
      print(response.body);
  }

}