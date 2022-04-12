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
            onPressed: () => Navigator.pop(context), icon: Icon(Icons.close)),
      ]);
}

PreferredSizeWidget blankAppBar() {
  return AppBar(
    backgroundColor: style.appBarBackgroundColor,
    elevation: 0,
    automaticallyImplyLeading: false,
  );
}

PreferredSizeWidget scheduleAppBar(title, setting, list) {
  return AppBar(
    primary: false,
    title: Text(title, style: style.titleStyle),
    backgroundColor: style.appBarBackgroundColor,
    elevation: 0,
    automaticallyImplyLeading: false,
    actions: [
      IconButton(
        onPressed: () {},
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
      title: Text(title, style: style.titleStyle,),
      actions: [
        IconButton(
            onPressed: () => Navigator.pop(context), icon: Icon(Icons.close, color: style.appBarIconColor,)),
      ]);
}

PreferredSizeWidget lectureListAppBar(facultyItem, facultyOnChange, courseItem, courseOnChange) {
  return AppBar(
    actions: [
      SelectBox(
        validator: null,
        items: facultyItem,
        onChange: facultyOnChange,
        label: "Faculty",
        margin: null,
      ),
      SelectBox(
        validator: null,
        items: courseItem,
        onChange: courseOnChange,
        label: "Courses",
        margin: null
      )
    ],
  );
}
