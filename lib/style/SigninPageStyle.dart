import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var mainMargin = EdgeInsets.symmetric(horizontal: 30, vertical: 40);
var titleTextStyle = TextStyle(color: Colors.black, fontSize: 30);
var headerTextTheme = TextTheme(
    headline1: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black54),
    bodyText1: TextStyle(fontSize: 15, color: Colors.black54)
);


var margin = (context) {
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;

  return EdgeInsets.symmetric(horizontal: width*0.1, vertical: height*0.2  );
};

var headerRowMargin = EdgeInsets.fromLTRB(0, 5, 0, 10);
var bodyColumnMargin = EdgeInsets.symmetric(vertical: 5);
var buttonWidth = 500.0;
var buttonHeight = 30.0;