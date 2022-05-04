import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urooster/screen/eval_page.dart';
import 'package:urooster/screen/main_page.dart';
import 'package:urooster/screen/schedule_page.dart';
import 'package:urooster/style/widget_style.dart' as style;

class SkeletonPage extends StatefulWidget {
  SkeletonPage({Key? key}) : super(key: key);

  @override
  State<SkeletonPage> createState() => _SkeletonPageState();
}

class _SkeletonPageState extends State<SkeletonPage> {
  final List pages = [
    MainPage(),
    SchedulePage(),
    EvalPage(),
    Text("Notification")
  ];
  int index = 0;

  void onTab(int idx) {
    setState(() {
      index = idx;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: style.selectedColor,
          unselectedItemColor: style.unSelectedItemColor,
          currentIndex: index,
          onTap: onTab,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.table_chart), label: "timetable"),
            BottomNavigationBarItem(
                icon: Icon(Icons.school_outlined), label: "lecture evaluation"),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: "Notification"),
          ]
      ),

    );
  }
}
