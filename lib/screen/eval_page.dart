import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:urooster/provider/eval_provider.dart';
import 'package:urooster/provider/lecture_provider.dart';
import 'package:urooster/widget/custom_app_bar.dart';
import 'package:urooster/widget/text_field.dart';
import 'package:urooster/style/eval_style.dart' as style;

class EvalPage extends StatelessWidget {
  const EvalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: style.mainMargin,
        child: Column(
          children: [EvalSearch(), LectureList()],
        ),
      ),
    );
  }
}

class EvalSearch extends StatelessWidget {
  EvalSearch({Key? key}) : super(key: key);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
              child: CustomTextFormField(
            label: "Lecture or Staff",
            controller: controller,
            obscure: false,
            suggestion: true,
            autoCorrect: true,
            onSave: () {},
          )),
          IconButton(
              onPressed: () {
                if (controller.text != null)
                  context.read<EvalProvider>().findLecture(controller.text, 0);
              },
              icon: Icon(Icons.search))
        ],
      ),
    );
  }
}

class LectureList extends StatefulWidget {
  const LectureList({Key? key}) : super(key: key);

  @override
  State<LectureList> createState() => _LectureListState();
}

class _LectureListState extends State<LectureList> {
  final scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        context
            .read<EvalProvider>()
            .findLecture(null, context.read<EvalProvider>().idx + 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: style.listMargin,
      child: CustomScrollView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        slivers: [
          SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate((c, i) {
                return Container(
                  child: OutlinedButton(
                      child: Row(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(context
                                .read<EvalProvider>()
                                .lectureList[i]
                                .name, style: style.lectureNameText,),
                            Text(context
                                    .read<EvalProvider>()
                                    .lectureList[i]
                                    .staff ??
                                "", style: style.staffNameText,),
                            RatingBarIndicator(
                              rating: context
                                  .read<EvalProvider>()
                                  .lectureList[i]
                                  .score,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 15
                            ),
                          ],
                        )
                      ]),
                      onPressed: () {}),
                );
              }, childCount: context.watch<EvalProvider>().lectureList.length),
              itemExtent: MediaQuery.of(context).size.height / 10)
        ],
      ),
    );
  }
}

class EvalDetail extends StatefulWidget {
  EvalDetail({Key? key, this.lectureDetail}) : super(key: key);

  final lectureDetail;

  @override
  State<EvalDetail> createState() => _EvalDetailState();
}

class _EvalDetailState extends State<EvalDetail> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Container(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}

