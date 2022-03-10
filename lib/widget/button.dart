import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  SubmitButton({Key? key, this.label, this.onPress, this.width}) : super(key: key);

  final label;
  final onPress;
  final width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: ElevatedButton(
        child: Text(label),
        onPressed: onPress,
      ),
    );
  }
}
