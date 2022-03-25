import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urooster/style/widget_style.dart' as style;

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

PreferredSizeWidget scheduleAppBar(String title) {
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
        onPressed: () {},
        icon: Icon(Icons.settings),
        color: style.appBarIconColor,
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.list),
        color: style.appBarIconColor,
      )
    ],
  );
}
