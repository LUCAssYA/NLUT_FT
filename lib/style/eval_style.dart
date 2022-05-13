import 'package:flutter/material.dart';

var mainMargin = EdgeInsets.symmetric(vertical: 10, horizontal: 10);
var listMargin = EdgeInsets.symmetric(vertical: 10);
var lectureNameText = TextStyle(color: Colors.black, fontSize: 20);
var staffNameText = TextStyle(color: Colors.black54, fontSize: 15);
var detailNameText = TextStyle(color: Colors.black, fontSize: 25, height: 1);
var detailStaffText = TextStyle(color: Colors.black54, fontSize: 20, height: 1);
var labelHeight = 35.0;
var itemHeight = 60.0;
var descriptionText = TextStyle(color: Colors.black, fontSize: 15, height: 1.5);

BoxDecoration containerDecoration() {
  return BoxDecoration(
    border: Border.all(
      width: 1,
      color: Colors.black54
    ),
    borderRadius: BorderRadius.circular(10)
  );
}