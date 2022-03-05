import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urooster/style/find_password_style.dart' as style;

class FindPasswordPage extends StatelessWidget {
  FindPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
        body: Form(
            child: Container(
              margin: style.containerMargin(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Forgot password?", style: style.titleTextStyle),
          Container(
            margin: style.itemMargin,
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: "Email", border: OutlineInputBorder()),
            ),
          ),
          Container(
            margin: style.itemMargin,
            width: style.buttonWidth(context),
              child: ElevatedButton(
            onPressed: () {},
            child: Text("Find password"),
          ))
        ],
      ),
    )));
  }
}
