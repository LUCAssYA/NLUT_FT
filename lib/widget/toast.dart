import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:urooster/style/widget_style.dart' as style;

void showToast(BuildContext context, String message) {
  FToast fToast = FToast();
  fToast.init(context);

  fToast.showToast(
      child: Container(
        height: 50,
        width: 300,
        decoration: style.toastDecoration,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            message,
            style: style.toastTextStyle,
            textAlign: TextAlign.center,
          )
        ]),
      ),
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 1));
  return;
}
