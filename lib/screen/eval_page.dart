import 'package:flutter/material.dart';
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

class LectureList extends StatelessWidget {
  const LectureList({Key? key}) : super(key: key);

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

