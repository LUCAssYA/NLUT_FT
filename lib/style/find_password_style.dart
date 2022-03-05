import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var titleTextStyle = TextStyle(color: Colors.black54, fontSize: 40, fontWeight: FontWeight.bold);
var containerMargin = (context){
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;

  return EdgeInsets.symmetric(horizontal: width*0.1, vertical: height*0.2);
};


var buttonWidth = (context) {
  return MediaQuery.of(context).size.width;
};

var itemMargin = EdgeInsets.symmetric(vertical:20, horizontal: 0);