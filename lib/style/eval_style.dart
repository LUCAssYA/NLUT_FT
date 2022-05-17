import 'package:flutter/material.dart';

var mainMargin = EdgeInsets.symmetric(vertical: 10, horizontal: 10);
var listMargin = EdgeInsets.symmetric(vertical: 10);
var lectureNameText = TextStyle(color: Colors.black, fontSize: 20);
var staffNameText = TextStyle(color: Colors.black54, fontSize: 15);
var detailNameText = TextStyle(color: Colors.black, fontSize: 25, height: 1);
var detailStaffText = TextStyle(color: Colors.black54, fontSize: 20, height: 1);
var labelHeight = 40.0;
var itemHeight = 60.0;
var descriptionText = TextStyle(color: Colors.black, fontSize: 15, height: 1.5);
var listItemMargin = EdgeInsets.symmetric(vertical: 5);

var reviewText = TextStyle(color: Colors.black87, fontSize: 20, height: 1);

var newReivewButton = ElevatedButton.styleFrom(primary: Colors.black38, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)));
var textFieldDecoration = InputDecoration(
  border: OutlineInputBorder(),
  hintText: "Review",
);
var maxWidth = (context) => MediaQuery.of(context).size.width;
var modalHeight = (context) => MediaQuery.of(context).size.height*0.45;

BoxDecoration containerDecoration() {
  return BoxDecoration(
    border: Border.all(
      width: 1,
      color: Colors.black54
    ),
    borderRadius: BorderRadius.circular(10)
  );
}

var submitButtonStyle = ElevatedButton.styleFrom(primary: Colors.black54);