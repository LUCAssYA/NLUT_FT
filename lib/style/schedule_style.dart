import 'package:flutter/cupertino.dart';

var contextMargin = (context) {
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;

  return EdgeInsets.fromLTRB(width*0.05, 0, width*0.05, height*0.05);

};