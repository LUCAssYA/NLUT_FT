import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BottomNavigationBar CustomBottom() {
  return BottomNavigationBar(items: [
      BottomNavigationBarItem(icon: Icon(Icons.home)),
      BottomNavigationBarItem(icon: Icon(Icons.table_chart)),
      BottomNavigationBarItem(icon: Icon(Icons.school_outlined))
    ]);
}