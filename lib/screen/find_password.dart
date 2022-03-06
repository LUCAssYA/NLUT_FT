import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urooster/provider/auth_provider.dart';
import 'package:urooster/style/find_password_style.dart' as style;

class FindPasswordPage extends StatelessWidget {
  FindPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
        body: Form(
            key: formKey,
            child: Container(
              margin: style.containerMargin(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Forgot password?", style: style.titleTextStyle),
                  Container(
                    margin: style.itemMargin,
                    child: TextFormField(
                      controller: controller,
                      validator: (text) =>
                          context.read<AuthProvider>().textValidator(text),
                      decoration: InputDecoration(
                          labelText: "Email", border: OutlineInputBorder()),
                    ),
                  ),
                  Container(
                      margin: style.itemMargin,
                      width: style.buttonWidth(context),
                      child: ElevatedButton(
                        onPressed: () => context
                            .read<AuthProvider>()
                            .findPassword(controller.text, formKey),
                        child: Text("Find password"),
                      ))
                ],
              ),
            )));
  }
}
