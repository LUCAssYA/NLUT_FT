import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urooster/style/group_list_style.dart' as style;

import '../provider/schedule_provider.dart';
import '../widget/custom_app_bar.dart';

class GroupPage extends StatelessWidget {
  GroupPage({Key? key, this.controller, this.changeGroup}) : super(key: key);
  final controller;
  final changeGroup;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: textWithCloseButton("Schedule groups", context),
        body: Container(
          child: CustomScrollView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            slivers: [
              SliverFixedExtentList(
                  delegate: SliverChildBuilderDelegate((c, i) {
                    return ListPage(
                        group: context.watch<ScheduleProvider>().groupList[i], controller: controller, changeGroup: changeGroup,);
                  },
                      childCount:
                          context.watch<ScheduleProvider>().groupList.length),
                  itemExtent: MediaQuery.of(context).size.height / 12)
            ],
          ),
        ));
  }
}

class ListPage extends StatelessWidget {
  ListPage({Key? key, this.group, this.controller, this.changeGroup}) : super(key: key);

  final group;
  final controller;
  final changeGroup;

  @override
  Widget build(BuildContext context) {
    if (group.id == context.watch<ScheduleProvider>().currentGroup.id) {
      return OutlinedButton(
          onPressed: () {},
          child: Container(
            margin: style.buttonTextMargin,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(group.name, style: style.defaultTextStyle),
                  Text("current", style: style.currentTextStyle)
                ]),
          ));
    } else {
      return OutlinedButton(
        onPressed: () => context.read<ScheduleProvider>().getGroupDetail(group.id, context).then((value)  {
          changeGroup(context.read<ScheduleProvider>().currentDate);
        }),
        child: Container(
            margin: style.buttonTextMargin,
            child: Row(children: [Text(group.name, style: style.defaultTextStyle,)])),
      );
    }
  }
}
