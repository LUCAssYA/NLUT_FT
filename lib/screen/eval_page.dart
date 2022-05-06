import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urooster/provider/eval_provider.dart';
import 'package:urooster/provider/lecture_provider.dart';
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
          children: [
            EvalSearch(),
            LectureList()
          ],
        ),
      ),
    );
  }
}

class EvalSearch extends StatelessWidget {
  const EvalSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(child: CustomTextFormField(
            label: "Lecture or Staff",
            controller: null,
            obscure: false,
            suggestion: true,
            autoCorrect: true,
            onSave: () {},
          )),
          IconButton(onPressed: (){}, icon: Icon(Icons.search))
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
      if(scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        context.read<EvalProvider>().findLecture(null, context.read<EvalProvider>().idx+1);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        slivers: [],
      ),
    );
  }
}

