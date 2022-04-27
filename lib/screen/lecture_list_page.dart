import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urooster/provider/lecture_provider.dart';
import 'package:urooster/widget/custom_app_bar.dart';
import 'package:urooster/style/lecture_list_style.dart' as style;

import '../widget/text_field.dart';

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
    if (context.read<LectureProvider>().currentFaculty == null) {
      context.read<LectureProvider>().getFaculty().then((value) {
        context.read<LectureProvider>().getTimeTable();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            SelectFaculty(),
            Expanded(child: LectureList()),
            AddCustomLecture()
          ])),
    );
  }
}

class CustomLectureAdd extends StatelessWidget {
  CustomLectureAdd({Key? key}) : super(key: key);

  final scrollController = ScrollController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: textWithCloseButton("Add By YourSelf",context),
        body: Container(
            padding: style.modalPadding,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 20,
                      child: Container(
                        alignment: Alignment.topRight,
                        child: CustomScrollView(
                          controller: scrollController,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          slivers: [
                            SliverToBoxAdapter(
                              child: CustomTextFormField(
                                label: "Lecture",
                                controller: null,
                                margin: style.textFieldMargin,
                                obscure: false,
                                suggestion: true,
                                autoCorrect: true,
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: CustomTextFormField(
                                label: "Staff",
                                controller: null,
                                margin: style.textFieldMargin,
                                obscure: false,
                                suggestion: true,
                                autoCorrect: true,
                              ),
                            ),
                            SliverFixedExtentList(
                                delegate: SliverChildBuilderDelegate((c, i) {
                                  return context
                                      .watch<LectureProvider>()
                                      .widgets.values.toList()[i];
                                },
                                    childCount: context
                                        .watch<LectureProvider>()
                                        .widgets
                                        .length),
                                itemExtent:
                                    MediaQuery.of(context).size.height / 4.5),
                            SliverToBoxAdapter(
                                child: Container(
                              alignment: Alignment.topRight,
                              child: TextButton(
                                  onPressed: () => context
                                      .read<LectureProvider>()
                                      .onClickAddAndTime(),
                                  child: Text("Add Time And Place",
                                      style: style.addTimeAndPlace)),
                            ))
                          ],
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                "Cancel",
                                style: style.defaultTextStyle,
                              ))),
                      Expanded(
                          child: TextButton(
                              onPressed: () {},
                              child: Text("OK", style: style.defaultTextStyle)))
                    ],
                  )
                ],
              ),
            )));
  }
}

class AddCustomLecture extends StatelessWidget {
  AddCustomLecture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: style.addButtonMargin,
      child: Row(
        children: [
          Expanded(
              child: Container(
                  height: style.buttonHeight,
                  child: OutlinedButton(
                      child: Text("Add by yourself",
                          style: style.addButtonTextStyle),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CustomLectureAdd())),
                      style: style.addButtonStyle))),
        ],
      ),
    );
  }
}

class TimeAndPlace extends StatefulWidget {
  TimeAndPlace({Key? key, this.index}) : super(key: key);

  final index;
  @override
  State<TimeAndPlace> createState() => _TimeAndPlaceState();
}

class _TimeAndPlaceState extends State<TimeAndPlace> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: style.timeAndPlaceMargin,
      decoration: style.containerDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DisabledTextBox(
                  margin: style.disabeldTextBox,
                  label: "Date",
                ),
                DisabledTextBox(
                  margin: style.disabeldTextBox,
                  label: "Start",
                ),
                Text("~"),
                DisabledTextBox(
                  margin: style.disabeldTextBox,
                  label: "End",
                ),
                // Container(
                //     width: style.checkBoxWidth(context),
                //     child: CheckboxListTile(
                //         controlAffinity: ListTileControlAffinity.leading,
                //         title: Text("Every week"),
                //         value: checked,
                //         onChanged: (bool? value) {
                //           checked = value!;
                //         })),
              ]
          ),
          Row(
            children: [
              Expanded(child: CustomTextFormField(
                label: "Location",
                controller: null,
                margin: style.locationMargin,
                obscure: false,
                suggestion: true,
                autoCorrect: true,
              )),
              Container(
                  width: style.checkBoxWidth(context),
                  child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text("Every week"),
                      value: checked,
                      onChanged: (bool? value) {
                        setState(() {
                          checked = value!;
                        });

                      })),
              Container(
                margin: style.locationMargin,
                  child: IconButton(onPressed: () => context.read<LectureProvider>().removeWidget(this.widget.index), icon: Icon(Icons.delete)))
            ],
          ),
          // Row(
          //   children: [
          //     CustomTextFormField(),
          //     Icon(Icons.delete)
          //   ],
          // )
        ],
      ),
    );
  }
}

class SelectFaculty extends StatelessWidget {
  SelectFaculty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: style.selectBoxMargin,
      child: Row(
        children: [
          Expanded(
            child: Container(
                child: SelectBox(
              validator: null,
              items: context.watch<LectureProvider>().facultyList,
              onChange: context.read<LectureProvider>().facultyOnChange,
              label: "Faculty",
              margin: null,
              value: context.read<LectureProvider>().facultyList.length == 0
                  ? null
                  : context.read<LectureProvider>().currentFaculty as Object?,
            )),
          ),
          Expanded(
              child: Container(
                  child: SelectBox(
                      value: context.read<LectureProvider>().currentCourse,
                      validator: null,
                      items: context.watch<LectureProvider>().courses,
                      onChange: context.read<LectureProvider>().courseOnChange,
                      label: "Courses",
                      margin: null))),
          IconButton(
              onPressed: () => Navigator.pop(context), icon: Icon(Icons.close))
        ],
      ),
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
      margin: style.listMargin,
      child: CustomScrollView(
          controller: scrollController,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          slivers: [
            SliverFixedExtentList(
                delegate: SliverChildBuilderDelegate((c, i) {
                  return Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              context
                                  .watch<LectureProvider>()
                                  .lectureList[i]
                                  .name,
                              style: style.lectureText),
                          Text(
                            context
                                .watch<LectureProvider>()
                                .lectureList[i]
                                .staff,
                            style: style.staffText,
                          )
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () => context
                            .read<LectureProvider>()
                            .addLecture(i, context),
                        child: Text("Add", style: style.buttonTextStyle),
                        style: style.buttonStyle,
                      )
                    ],
                  ));
                },
                    childCount:
                        context.watch<LectureProvider>().lectureList.length),
                itemExtent: (MediaQuery.of(context).size.height * 0.8) / 8)
          ]),
    );
  }
}
