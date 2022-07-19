import 'package:flutter/material.dart';

void modalBottomSheet(context,shape, widget) {
  showModalBottomSheet(context: context, builder: (BuildContext context) {
    return widget();
  }, shape: shape);
}