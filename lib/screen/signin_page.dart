import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urooster/style/signin_page_style.dart' as style;
import 'package:urooster/provider/signin_provider.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            child: Container(
          margin: style.margin(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [SignInHeader(), SignInBody()],
          ),
        )));
  }
}

class SignInBody extends StatelessWidget {
  SignInBody({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          child: TextField(
            controller: emailController,
            decoration: InputDecoration(
                labelText: "Email", border: OutlineInputBorder()),
          ),
          margin: style.bodyColumnMargin,
        ),
        Container(
          child: TextField(
            controller: passwordController,
            decoration: InputDecoration(
                labelText: "Password", border: OutlineInputBorder()),
          ),
          margin: style.bodyColumnMargin,
        ),
        Container(
          child: TextButton(onPressed: () {}, child: Text("Forgot password?")),
          alignment: Alignment.bottomRight,
          margin: style.bodyColumnMargin,
        ),
        Container(
            width: style.signinButtonSize['buttonWidth'],
            height: style.signinButtonSize['buttonHeight'],
            child: ElevatedButton(
                onPressed: () => {
                      context
                          .read<SignInProvider>()
                          .signIn(emailController.text, passwordController.text)
                    },
                child: Text("Sign in"),
                style: style.signinButtonStyle),
            margin: style.bodyColumnMargin)
      ],
    );
  }
}

class SignInHeader extends StatelessWidget {
  const SignInHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("URooster", style: style.headerTextTheme.headline1),
        Row(
          children: [
            Container(
              child: Text("Don't have an account?",
                  style: style.headerTextTheme.bodyText1),
              margin: style.headerRowMargin,
            ),
            Container(
                child: TextButton(onPressed: () {}, child: Text("register")),
                margin: style.headerRowMargin)
          ],
        )
      ],
    );
  }
}
