import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urooster/widget/custom_bottom_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(),
      bottomNavigationBar: CustomBottom()
    );
  }
}


class TodaySchedule extends StatelessWidget {
  TodaySchedule({Key? key, this.label}) : super(key: key);
  final label;

  @override
  Widget build(BuildContext context) {
    return Container(child: Column(
      children: [
        Text(label),
        ListView.builder(itemBuilder: (c, i){})
      ],
    ),);
  }
}

class Friend extends StatelessWidget {
  const Friend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class Dday extends StatelessWidget {
  Dday({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

