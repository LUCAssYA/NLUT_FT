import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var appBarBackgroundColor = Colors.white10;
var selectedColor = Colors.black87;
var unSelectedItemColor = Colors.grey;
var appBarIconColor = Colors.black54;
var titleStyle = TextStyle(color: Colors.black54, fontWeight: FontWeight.bold);
var appBarMargin = EdgeInsets.symmetric(vertical: 30);
var selectBoxMargin = EdgeInsets.symmetric(horizontal: 5);
var calendarWidth = (context) => MediaQuery.of(context).size.width*0.5;
var calendarMargin = EdgeInsets.fromLTRB(10, 10, 0,0);
var iconMargin = EdgeInsets.fromLTRB(10, 0, 0, 0);
var friendScheduleAppBarMargin = EdgeInsets.symmetric(vertical: 10);
var personMargin = EdgeInsets.symmetric(horizontal: 25);


var toastDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.white70
);
var toastTextStyle = TextStyle(color: Colors.black, fontSize: 20);

var dialogActionText = TextStyle(color: appBarIconColor, fontWeight: FontWeight.bold);

var dropDownItemMargin = EdgeInsets.symmetric(vertical: 5);