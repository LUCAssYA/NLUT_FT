import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urooster/provider/lecture_provider.dart';

class LectureModal extends StatefulWidget {
  LectureModal({Key? key}) : super(key: key);

  @override
  State<LectureModal> createState() => _LectureModalState();
}

class _LectureModalState extends State<LectureModal> {
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
