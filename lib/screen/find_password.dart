import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FindPasswordPage extends StatelessWidget {
  FindPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
        body: Form(
            child: Container(
      child: Column(
        children: [
          Text("Forgot password?"),
          Container(
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: "Email", border: OutlineInputBorder()),
            ),
          ),
          Container(
              child: ElevatedButton(
            onPressed: () {},
            child: Text("Find password"),
          ))
        ],
      ),
    )));
  }
}
