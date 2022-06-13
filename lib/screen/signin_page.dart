import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urooster/style/signin_page_style.dart' as style;
import 'package:urooster/provider/auth_provider.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<AuthProvider>().autoSignIn(context, "/home");
  }

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

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: TextFormField(
                controller: emailController,
                validator: (text) =>
                    context.read<AuthProvider>().textValidator(text),
                decoration: InputDecoration(
                    labelText: "Email", border: OutlineInputBorder()),
              ),
              margin: style.bodyColumnMargin,
            ),
            Container(
              child: TextFormField(
                controller: passwordController,
                validator: (text) =>
                    context.read<AuthProvider>().textValidator(text),
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              ),
              margin: style.bodyColumnMargin,
            ),
            Container(
              child: TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, "/findPassword"),
                  child: Text("Forgot password?")),
              alignment: Alignment.bottomRight,
              margin: style.bodyColumnMargin,
            ),
            Container(
                width: style.signinButtonSize['buttonWidth'],
                height: style.signinButtonSize['buttonHeight'],
                child: ElevatedButton(
                    onPressed: () => {
                          context.read<AuthProvider>().signIn(
                              emailController.text,
                              passwordController.text,
                              formKey,
                              context)
                        },
                    child: Text("Sign in"),
                    style: style.signinButtonStyle),
                margin: style.bodyColumnMargin)
          ],
        ));
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
                child: TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/register'),
                    child: Text("register")),
                margin: style.headerRowMargin)
          ],
        )
      ],
    );
  }
}
