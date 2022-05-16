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
                            Text(
                              context.read<EvalProvider>().lectureList[i].name,
                              style: style.lectureNameText,
                            ),
                            Text(
                              context
                                      .read<EvalProvider>()
                                      .lectureList[i]
                                      .staff ??
                                  "",
                              style: style.staffNameText,
                            ),
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
                                itemSize: 15),
                          ],
                        )
                      ]),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EvalDetail(
                                    lectureDetail: context
                                        .read<EvalProvider>()
                                        .lectureList[i],
                                  )))),
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
    context.read<EvalProvider>().evalDetail(this.widget.lectureDetail.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Container(
          child: SingleChildScrollView(
        child: Column(
          children: [LectureDetail(), EvalList()],
        ),
      )),
    );
  }
}

class LectureDetail extends StatelessWidget {
  const LectureDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: style.mainMargin,
        width: MediaQuery.of(context).size.width,
        decoration: style.containerDecoration(),
        margin: style.mainMargin,
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 3,
                child: Text(
                  context.watch<EvalProvider>().lecture.name,
                  style: style.detailNameText,
                )),
            Expanded(
                flex: 2,
                child: Text(
                  context.watch<EvalProvider>().lecture.staff ?? "",
                  style: style.detailStaffText,
                )),
            Expanded(
                flex: 2,
                child: RatingBarIndicator(
                    rating: context.watch<EvalProvider>().lecture.score,
                    itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                    itemCount: 5,
                    itemSize: 20))
          ],
        ));
  }
}

class EvalList extends StatelessWidget {
  EvalList({Key? key}) : super(key: key);

  void newReview(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            margin: style.mainMargin,
            padding: style.mainMargin,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Review", style: style.detailNameText,),
                Text("Score"),
                RatingBar.builder(
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemCount: 5,
                ),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLength: 512,
                  decoration: style.textFieldDecoration,
                  maxLines: 5,
                ),
                ElevatedButton(onPressed: (){}, child: Text("Submit"))
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: style.containerDecoration(),
        margin: style.mainMargin,
        padding: style.mainMargin,
        child: Column(
          children: [
            Container(
              height: style.labelHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Review", style: style.reviewText),
                  ElevatedButton(
                      onPressed: () => newReview(context),
                      child: Text("New Review"),
                      style: style.newReivewButton)
                ],
              ),
            ),
            Container(
              padding: style.mainMargin,
              child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: RatingBarIndicator(
                              rating: context
                                  .watch<EvalProvider>()
                                  .evalList[index]
                                  .score,
                              itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                              itemCount: 5,
                              itemSize: 15),
                          margin: style.listItemMargin,
                        ),
                        Container(
                          child: Text(
                            context
                                .watch<EvalProvider>()
                                .evalList[index]
                                .description,
                            style: style.descriptionText,
                          ),
                          margin: style.listItemMargin,
                        )
                      ],
                    ));
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: context.watch<EvalProvider>().evalList.length),
            ),
          ],
        ));
  }
}
