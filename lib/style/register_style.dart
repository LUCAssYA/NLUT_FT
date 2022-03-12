import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

var textMargin = EdgeInsets.fromLTRB(0, 5, 0, 5);
var contextMargin = (context) {
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;

  return EdgeInsets.symmetric(horizontal: width*0.05, vertical: 0 );
};

var headerStyle = TextStyle(color: Colors.black54, fontSize: 30);
var headerMargin = EdgeInsets.fromLTRB(0, 0, 0, 20);
var itemMargin = EdgeInsets.fromLTRB(7, 0, 0, 0);
var domainTextStyle = TextStyle(color: Colors.black, fontSize: 20, letterSpacing: 1.5);
var buttonSize = (context) {
  return MediaQuery.of(context).size.width as double;
};
var buttonMargin = EdgeInsets.fromLTRB(0, 15, 0, 0);
var buttonTheme = ElevatedButton.styleFrom(primary: Colors.black54, onPrimary: Colors.white);
var buttonTextStyle = TextStyle(fontSize: 13);