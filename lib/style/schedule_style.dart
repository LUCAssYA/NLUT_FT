import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var contextMargin = (context) {
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;

  return EdgeInsets.fromLTRB(width*0.05, 0, width*0.05, height*0.05);

};

var modalShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(25.0),
      bottom: Radius.circular(25.0),
    )
);

var modalContainerPadding = EdgeInsets.all(20);
var defaultColor = Colors.black54;
var appointmentTextStyle = TextStyle(color: defaultColor);

var modalHeaderTextStyle = TextStyle(color: Colors.black87, fontSize: 20, height: 1.5);
var modalItemTextStyle = TextStyle(color: Colors.black54, fontSize: 16, height: 1.5);
var modalBackgroudColor = Colors.black54;