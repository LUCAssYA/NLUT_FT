import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var textMargin = EdgeInsets.fromLTRB(0, 5, 0, 5);
var contextMargin = (context) {
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;

  return EdgeInsets.symmetric(horizontal: width*0.1, vertical: height*0.1 );
};

var headerStyle = TextStyle(color: Colors.black54, fontSize: 30);
var headerMargin = EdgeInsets.fromLTRB(0, 0, 0, 20);