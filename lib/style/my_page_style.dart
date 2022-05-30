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