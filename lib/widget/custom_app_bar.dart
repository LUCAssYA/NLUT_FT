import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urooster/style/widget_style.dart' as style;
import 'package:urooster/widget/text_field.dart';

PreferredSizeWidget customAppBar(BuildContext context) {
  return AppBar(
      backgroundColor: style.appBarBackgroundColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
            onPressed: () => Navigator.pop(context), icon: Icon(Icons.close, color: style.appBarIconColor,)),
      ]);
}

PreferredSizeWidget blankAppBar() {
  return AppBar(
    backgroundColor: style.appBarBackgroundColor,
    elevation: 0,
    automaticallyImplyLeading: false,
  );
}

PreferredSizeWidget scheduleAppBar(title, setting, list, add) {
  return AppBar(
    primary: false,
    title: Text(title, style: style.titleStyle),
    backgroundColor: style.appBarBackgroundColor,
    elevation: 0,
    automaticallyImplyLeading: false,
    actions: [
      IconButton(
        onPressed: () => add(),
        icon: Icon(Icons.add),
        color: style.appBarIconColor,
      ),
      IconButton(
        onPressed: () => setting(),
        icon: Icon(Icons.settings),
        color: style.appBarIconColor,
      ),
      IconButton(
        onPressed: () => list(),
        icon: Icon(Icons.list),
        color: style.appBarIconColor,
      )
    ],
  );
}

PreferredSizeWidget textWithCloseButton(String title, BuildContext context) {
  return AppBar(
      centerTitle: true,
      backgroundColor: style.appBarBackgroundColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: style.titleStyle,
      ),
      actions: [
        IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.close,
              color: style.appBarIconColor,
            )),
      ]);
}

PreferredSizeWidget lectureListAppBar(
    facultyItem, facultyOnChange, courseItem, courseOnChange, context) {
  return AppBar(
    backgroundColor: style.appBarBackgroundColor,
    primary: false,
    elevation: 0,
    automaticallyImplyLeading: false,
    title: Container(
      margin: style.appBarMargin,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: style.selectBoxMargin,
                child: SelectBox(
              validator: null,
              items: facultyItem,
              onChange: facultyOnChange,
              label: "Faculty",
              margin: null,
            )),
          ),
          Expanded(
              child: Container(
                margin: style.selectBoxMargin,
                  child: SelectBox(
                      validator: null,
                      items: courseItem,
                      onChange: courseOnChange,
                      label: "Courses",
                      margin: null))),
        ],
      ),
    ),
    actions: [
      IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.close,
            color: style.appBarIconColor,
          ))
    ],
  );
}
