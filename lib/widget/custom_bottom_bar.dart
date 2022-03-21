import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urooster/style/widget_style.dart' as style;

BottomNavigationBar CustomBottom() {
  return BottomNavigationBar(
      selectedItemColor: style.selectedColor,
      unselectedItemColor: style.unSelectedItemColor,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.table_chart), label: "timetable"),
        BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined), label: "lecture evaluation"),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications), label: "Notification"),
      ]);
}
