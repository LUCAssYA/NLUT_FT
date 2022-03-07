import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urooster/style/widget_style.dart' as style;

PreferredSizeWidget customAppBar(BuildContext context) {
  return AppBar(
      backgroundColor: style.appBarBackgroundColor,
      elevation: 0,
      automaticallyImplyLeading: false, actions: [
    IconButton(
        onPressed: () => Navigator.pop(context), icon: Icon(Icons.close)),

  ]
  );
}