import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urooster/provider/home_provider.dart';
import 'package:urooster/widget/custom_app_bar.dart';
import 'package:urooster/widget/custom_bottom_bar.dart';
import 'package:urooster/style/main_page_style.dart' as style;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeProvider>().getDday();
    context.read<HomeProvider>().getFriends();
    context.read<HomeProvider>().getToday();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: blankAppBar(),
        body: Container(
          margin: style.contextMargin(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 1, child: TodayScheduleList()),
              Expanded(
                child: DdayList(),
                flex: 1,
              ),
              Expanded(
                child: Friend(),
                flex: 1,
              )
            ],
          ),
        ),
        bottomNavigationBar: CustomBottom());
  }
}

class TodayScheduleList extends StatelessWidget {
  TodayScheduleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: style.itemPadding,
      margin: style.itemMargin,
      decoration: style.containerDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: style.labelHeight,
              child: Text(
                "Today's Schedule",
                style: style.labelTextStyle,
              )),
          Container(
            margin: style.listMargin,
            child: ListView.builder(
                itemCount: context.watch<HomeProvider>().schedule.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (c, i) {
                  return TodaySchedule(
                      schedule: context.watch<HomeProvider>().schedule[i]);
                }),
          )
        ],
      ),
    );
  }
}

class TodaySchedule extends StatelessWidget {
  const TodaySchedule({Key? key, this.schedule}) : super(key: key);

  final schedule;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        Expanded(
          child: Text(schedule.name),
          flex: 2,
        ),
        Expanded(
          child: Text(schedule.startTime + "~" + schedule.endTime),
          flex: 1,
        ),
        Expanded(
          child: Text(schedule.loaction),
          flex: 1,
        )
      ],
    ));
  }
}

class Friend extends StatelessWidget {
  const Friend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: style.itemPadding,
        margin: style.itemMargin,
        decoration: style.containerDecoration(),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: style.labelHeight,
                  child: Text(
                    "Friend",
                    style: style.labelTextStyle,
                  )),
              Container(
                  height: 16,
                  child: IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit,
                        size: 16,
                      )))
            ],
          ),
          Expanded(
              child: CustomScrollView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            slivers: [
              SliverFixedExtentList(
                  delegate: SliverChildBuilderDelegate((c, i) {
                    return Text(
                        context.watch<HomeProvider>().friend[i]['name']);
                  }, childCount: context.watch<HomeProvider>().friend.length),
                  itemExtent: style.labelHeight)
            ],
          ))
        ]));
  }
}

class DdayList extends StatelessWidget {
  DdayList({Key? key}) : super(key: key);

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: style.itemPadding,
        margin: style.itemMargin,
        decoration: style.containerDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: style.labelHeight,
                child: Text(
                  "D-Day",
                  style: style.labelTextStyle,
                )),
            Expanded(
                child: CustomScrollView(
              controller: scrollController,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              slivers: [
                SliverFixedExtentList(
                  delegate: SliverChildBuilderDelegate((c, i) {
                    return Dday(
                        index: i, data: context.watch<HomeProvider>().dday[i]);
                  }, childCount: context.watch<HomeProvider>().dday.length),
                  itemExtent: style.labelHeight,
                )
              ],
            ))
          ],
        ));
  }
}

class Dday extends StatelessWidget {
  const Dday({Key? key, this.index, this.data}) : super(key: key);

  final index;
  final data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: style.labelHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 1, child: Container(child: Text(data.name))),
          Expanded(
              flex: 1,
              child: Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("D" + data.dday.toString(), style: style.ddayText),
                  IconButton(
                    onPressed: () => context.read<HomeProvider>().deleteDday(index),
                    icon: Icon(Icons.delete),
                    iconSize: 16,
                  )
                ],
              )))
        ],
      ),
    );
  }
}
