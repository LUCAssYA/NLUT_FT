import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urooster/provider/lecture_provider.dart';
import 'package:urooster/widget/custom_app_bar.dart';

class LectureListPage extends StatefulWidget {
  const LectureListPage({Key? key}) : super(key: key);

  @override
  State<LectureListPage> createState() => _LectureListPageState();
}

class _LectureListPageState extends State<LectureListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (context.read<LectureProvider>().currentFaculty == {}) {
      context.read<LectureProvider>().getFaculty().then((value) {
        context.read<LectureProvider>().getTimeTable();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: lectureListAppBar(
          context.read<LectureProvider>().facultyList,
          context.read<LectureProvider>().getTimeTable,
          context.read<LectureProvider>().courses,
          context.read<LectureProvider>().courseOnChange),
      body: LectureList(),
    );
  }
}

class LectureList extends StatefulWidget {
  LectureList({Key? key}) : super(key: key);

  @override
  State<LectureList> createState() => _LectureList();
}

class _LectureList extends State<LectureList> {
  final scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        print("max");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
          controller: scrollController,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          slivers: [
            SliverFixedExtentList(
                delegate: SliverChildBuilderDelegate((c, i) {
                  return Container(
                    child: Column(
                      children: [
                        Text(context
                            .watch<LectureProvider>()
                            .lectureList[i]
                            .name),
                        Text(context
                            .watch<LectureProvider>()
                            .lectureList[i]
                            .staff)
                      ],
                    ),
                  );
                },
                    childCount:
                        context.watch<LectureProvider>().lectureList.length),
                itemExtent: (MediaQuery.of(context).size.height * 0.5) / 8)
          ]),
    );
  }
}
