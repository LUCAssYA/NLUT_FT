import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BoxDecoration containerDecoration() {
  return BoxDecoration(
    border: Border.all(
      width: 1,
      color: Colors.black54,
    ),
    borderRadius: BorderRadius.circular(10)
  );
}
var contextMargin = (context) {
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;

  return EdgeInsets.fromLTRB(width*0.05, 0, width*0.05, height*0.05);

};

var itemMargin = EdgeInsets.symmetric(vertical: 3);
var itemPadding = EdgeInsets.all(10);
var labelHeight = 35.0;
var labelTextStyle = TextStyle(color: Colors.black54, fontSize: 16);
var listMargin = EdgeInsets.symmetric(horizontal: 7, vertical: 3);
var ddayText = TextStyle(color:  Colors.red, letterSpacing: 1.5);
var addFriendfieldMargin = EdgeInsets.fromLTRB(0, 5, 0, 0);