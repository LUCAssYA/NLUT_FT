import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urooster/widget/custom_app_bar.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: SingleChildScrollView(
        child: Container(
        )
      ), 
    );
  }
}
