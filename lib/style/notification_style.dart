import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var topMargin = (BuildContext context) => EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top, 0, 0);
var defaultColor = Colors.black54;
var friendButtonHeight = (context) => MediaQuery.of(context).size.height/12;
var friendButtonText = TextStyle(color: Colors.black87, fontSize: 18);
var friendButtonPadding = EdgeInsets.symmetric(horizontal: 10);
var listMargin = EdgeInsets.symmetric(horizontal: 10);
var listTextStyle = TextStyle(color: Colors.black, fontSize: 20);

var confirmButtonStyle = ElevatedButton.styleFrom(primary: defaultColor,minimumSize: Size(100, 40), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)));
var deleteButtonStyle = OutlinedButton.styleFrom(minimumSize: Size(100, 40), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)), primary: Colors.black);

BoxDecoration listContainerDecoration() {
  return BoxDecoration(
    border: Border.all(
      width: 1,
      color: Colors.black54
    ),
    borderRadius: BorderRadius.circular(10)
  );
}

var listHeight = (context) => MediaQuery.of(context).size.height/10;