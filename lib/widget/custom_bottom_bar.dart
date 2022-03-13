import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BottomNavigationBar CustomBottom() {
  return BottomNavigationBar(items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
      BottomNavigationBarItem(icon: Icon(Icons.table_chart), label: "timetable"),
      BottomNavigationBarItem(icon: Icon(Icons.school_outlined), label: "lecture evaluation")
    ]);
}