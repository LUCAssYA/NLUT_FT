import 'package:flutter/material.dart';

var listMargin = EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0);
var selectBoxMargin = EdgeInsets.fromLTRB(5, 10, 0, 5);
var buttonStyle = ElevatedButton.styleFrom(primary: Colors.black54, onPrimary: Colors.black, padding: EdgeInsets.all(0), elevation: 0);
var buttonTextStyle = TextStyle(color: Colors.white);
var lectureText = TextStyle(fontSize: 20);
var staffText = TextStyle(fontSize: 15);
var addButtonMargin = EdgeInsets.symmetric(horizontal: 5, vertical: 10);
var buttonHeight = 45.0;
var addButtonTextStyle = TextStyle(color: Colors.black, letterSpacing: 1.5, fontSize: 15);
var addButtonStyle = OutlinedButton.styleFrom(side: BorderSide(
    width: 3.0,
    color: Colors.black54,
    style: BorderStyle.solid
));


var modalHeight = (context) => MediaQuery.of(context).size.height*0.5;



var modalShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(25.0),
      bottom: Radius.circular(25.0),
    )
);

var modalPadding =EdgeInsets.all(20);