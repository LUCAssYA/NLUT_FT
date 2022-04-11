import 'package:flutter/cupertino.dart';
import 'package:urooster/model/lecture_list_model.dart';
import 'package:urooster/provider/auth_provider.dart';
import 'package:urooster/utils/constants.dart' as constants;
import 'package:http/http.dart' as http;

class LectureProvider with ChangeNotifier{
  List<LectureListModel> lectureList = [];
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

}