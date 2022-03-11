import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  SubmitButton({Key? key, this.label, this.onPress, this.width, this.margin, this.buttonTheme}) : super(key: key);

  final label;
  final onPress;
  final width;
  final margin;
  final buttonTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin,
      child: ElevatedButton(
        child: Text(label),
        onPressed: onPress,
        style: buttonTheme,
      ),
    );
  }
}
