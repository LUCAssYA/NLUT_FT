import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LectureModal extends StatefulWidget {
  LectureModal({Key? key}) : super(key: key);

  @override
  State<LectureModal> createState() => _LectureModalState();
}

class _LectureModalState extends State<LectureModal> {
  final scrollController =  ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        print("max");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        controller: scrollController,
        scrollDirection:  Axis.vertical,
        shrinkWrap: true,
        slivers: [
          SliverFixedExtentList(delegate: SliverChildBuilderDelegate((ci, i){
            return Container();
          }), itemExtent:( MediaQuery.of(context).size.height*0.5)/8)
        ]
      ),
    );
  }
}
