import 'package:flutter/material.dart';
import 'package:urooster/style/widget_style.dart' as style;

void dialog(context, title, content, onClickOk) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: title,
          content: content,
          actions: [
            Row(
              children: [
                Expanded(
                    child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel", style: style.dialogActionText,),
                )),
                Expanded(child: TextButton(child: Text("OK"), onPressed: () => onClickOk(),))
              ],
            )
          ],
        );
      });
}