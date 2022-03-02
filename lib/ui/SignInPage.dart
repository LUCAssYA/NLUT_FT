import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urooster/style/SigninPageStyle.dart' as style;


class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: style.mainMargin,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInHeader(),
            SignInBody()
          ],
        ),
      )
      // SizedBox(
      //   child: Column(
      //     children: [
      //       SignInHeader(),
      //       SignInBody()
      //     ],
      //   ),
      //
      // )
    );
  }
}

class SignInBody extends StatelessWidget {
  const SignInBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          child: TextField(
            decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder()
            ),
          ),
          margin: style.bodyColumnMargin,
        ),
        Container(
          child: TextField(
            decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder()
            ),
          ),
          margin: style.bodyColumnMargin,
        ),
        Container(
          child: TextButton(onPressed: (){}, child: Text("Forgot password?")),
          alignment: Alignment.bottomRight,
          margin: style.bodyColumnMargin,
        ),
        Container(
          width: style.buttonWidth,
          height: style.buttonHeight,
          child: ElevatedButton(onPressed: (){} , child: Text("Sign in")),
          margin: style.bodyColumnMargin
        )
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
      children:[
        Text("URooster", style: style.headerTextTheme.headline1),
        Row(
          children: [
            Container(

              child: Text("Don't have an account?", style: style.headerTextTheme.bodyText1),
              margin: style.headerRowMargin,
            ),
            Container(
              child: TextButton(
                  onPressed: (){},
                  child: Text("register")
              ),
              margin: style.headerRowMargin
            )
          ],
        )
      ],
    );
  }
}

