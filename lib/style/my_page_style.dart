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

var defaultColor = Colors.black54;
var profileBackgroundColor = Colors.black26;

var mainMargin = EdgeInsets.symmetric(vertical: 10, horizontal: 20);
var itemPadding = EdgeInsets.symmetric(vertical: 10, horizontal: 10);
var itemMargin = EdgeInsets.symmetric(horizontal: 15);

var titleTextStyle = TextStyle(fontSize: 20, letterSpacing: 1.5, fontWeight: FontWeight.bold, height: 1.5);
var itemTextStyle = TextStyle(fontSize: 13, letterSpacing: 1.5, height: 1.5);

var containerMargin = EdgeInsets.symmetric(vertical: 10);

var containerWidth = (context) => MediaQuery.of(context).size.width;

var textButtonStyle = TextButton.styleFrom(alignment: Alignment.centerLeft, minimumSize: Size(100, 50));

var labelTextStyle = TextStyle(fontSize: 19, color: Colors.black87, fontWeight: FontWeight.bold);

var textButtonTextStyle = TextStyle(fontSize: 15, color: Colors.black, height: 1);


var actionButton = TextStyle(color: defaultColor, fontWeight: FontWeight.bold);

var toastDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.white70
);
var toastTextStyle = TextStyle(color: Colors.black, fontSize: 20);
