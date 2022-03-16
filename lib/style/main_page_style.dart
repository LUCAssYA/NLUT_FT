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

  return EdgeInsets.symmetric(horizontal: width*0.05, vertical: 0 );
};

var itemMargin = EdgeInsets.symmetric(vertical: 3);
var itemPadding = EdgeInsets.all(10);