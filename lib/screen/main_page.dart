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
                child: FriendList(),
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
          Expanded(
              child: Container(
            margin: style.listMargin,
            child: CustomScrollView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              slivers: [
                SliverFixedExtentList(
                    delegate: SliverChildBuilderDelegate((c, i) {
                      return TodaySchedule(
                          schedule: context.watch<HomeProvider>().schedule[i]);
                    },
                        childCount:
                            context.watch<HomeProvider>().schedule.length),
                    itemExtent: style.labelHeight)
              ],
            ),
          ))
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
          child: Text(schedule.startTime +
              "~" +
              schedule.endTime +
              "(" +
              schedule.location +
              ")"),
          flex: 1,
        )
      ],
    ));
  }
}

class Friend extends StatelessWidget {
  const Friend({Key? key, this.index, this.data}) : super(key: key);

  final data;
  final index;

  void removeFriend(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Remove friend?"),
          content:
              Text("Are you sure want to remove " + data + " as your friend?"),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text("Cancel")),
            TextButton(
                onPressed: () =>
                    context.read<HomeProvider>().deleteFriend(context, index),
                child: Text("OK"))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: style.labelHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(child: Text(data)),
          Container(
              child: IconButton(
            onPressed: () {
              removeFriend(context);
            },
            icon: Icon(Icons.person_remove),
            iconSize: 16,
          ))
        ],
      ),
    );
  }
}

class FriendList extends StatelessWidget {
  FriendList({Key? key}) : super(key: key);
  

  void addFriend(BuildContext context) {

    final controller = TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Enter the friend's email you want to add"),
            content: Container(
              margin: style.addFriendfieldMargin,
              height: 40,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel")),
              TextButton(onPressed: () => context.read<HomeProvider>().addFriend(context, controller.text), child: Text("OK"))
            ],
          );
        });
  }

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
                      onPressed: () =>addFriend(context),
                      icon: Icon(
                        Icons.add,
                        size: 16,
                      )))
            ],
          ),
          Expanded(
              child: Container(
            margin: style.listMargin,
            child: CustomScrollView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              slivers: [
                SliverFixedExtentList(
                    delegate: SliverChildBuilderDelegate((c, i) {
                      return Friend(
                          index: i,
                          data: context.watch<HomeProvider>().friend[i]
                              ['name']);
                    }, childCount: context.watch<HomeProvider>().friend.length),
                    itemExtent: style.labelHeight)
              ],
            ),
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
                child: Container(
              margin: style.listMargin,
              child: CustomScrollView(
                controller: scrollController,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                slivers: [
                  SliverFixedExtentList(
                    delegate: SliverChildBuilderDelegate((c, i) {
                      return Dday(
                          index: i,
                          data: context.watch<HomeProvider>().dday[i]);
                    }, childCount: context.watch<HomeProvider>().dday.length),
                    itemExtent: style.labelHeight,
                  )
                ],
              ),
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
                    onPressed: () =>
                        context.read<HomeProvider>().deleteDday(index),
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
