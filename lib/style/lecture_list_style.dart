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

var defaultColor = Colors.black54;
var colorBlack = Colors.black;

var defaultTextStyle = TextStyle(color: Colors.black87);
var addTimeAndPlace = TextStyle(color:Colors.deepOrange);

var modalHeight = (context) => MediaQuery.of(context).size.height*0.7;



var modalShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(25.0),
      bottom: Radius.circular(25.0),
    )
);

var modalPadding =EdgeInsets.all(20);
var textFieldMargin = EdgeInsets.fromLTRB(0, 5, 0, 5);
var labelHeight = 35.0;
var timeAndPlaceMargin = EdgeInsets.symmetric(vertical: 5);

BoxDecoration containerDecoration() {
  return BoxDecoration(
      border: Border.all(
        width: 0.5,
        color: Colors.black54,
      ),
      borderRadius: BorderRadius.circular(10)
  );
}

var checkBoxWidth = (context) => MediaQuery.of(context).size.width*0.33;
var disabeldTextBox = EdgeInsets.symmetric(horizontal: 10, vertical: 10);
var locationMargin = EdgeInsets.symmetric(horizontal: 10);

var dateModalMargin = EdgeInsets.symmetric(vertical: 20, horizontal: 20);
var dateModalHeight= (context) => MediaQuery.of(context).size.height*0.4;