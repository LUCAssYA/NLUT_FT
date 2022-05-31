import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urooster/provider/my_provider.dart';
import 'package:urooster/widget/custom_app_bar.dart';
import 'package:urooster/style/my_page_style.dart' as style;

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: textAppBar("My Page"),
      body: Container(
        margin: style.mainMargin,
        child: Column(
          children: [Profile(), AccountSetting()],
        ),
      ),
    );
  }
}

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<MyPageProvider>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: style.containerMargin,
      padding: style.itemPadding,
      decoration: style.containerDecoration(),
      child: Row(
        children: [
          Container(
            margin: style.itemMargin,
            child: CircleAvatar(
              backgroundColor: style.profileBackgroundColor,
              radius: 30,
              child: Icon(
                Icons.person,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            margin: style.itemMargin,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      context.watch<MyPageProvider>().user.name,
                      style: style.titleTextStyle,
                    ),
                    Text("/"),
                    Text(
                      context.watch<MyPageProvider>().user.nickName,
                      style: style.titleTextStyle,
                    ),
                  ],
                ),
                Text(
                  context.watch<MyPageProvider>().user.email,
                  style: style.itemTextStyle,
                ),
                Row(
                  children: [
                    Text(
                      context.watch<MyPageProvider>().user.faculty,
                      style: style.itemTextStyle,
                    ),
                    Text("/"),
                    Text(
                      context.watch<MyPageProvider>().user.university,
                      style: style.itemTextStyle,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AccountSetting extends StatelessWidget {
  const AccountSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: style.containerMargin,
      decoration: style.containerDecoration(),
      child: Column(
        children: [
          Text("Account"),
          Row(children: [
            Expanded(
                child: TextButton(
              onPressed: () {},
              child: Text("Change User Information"),
              style: style.textButtonStyle,
            )),
          ]),
          Row(children: [
            Expanded(
                child: TextButton(
              onPressed: () {},
              child: Text("Change Password"),
              style: style.textButtonStyle,
            )),
          ]),
          Row(children: [
            Expanded(
                child: TextButton(
                    onPressed: () {},
                    child: Text("Withdraw"),
                    style: style.textButtonStyle)),
          ]),
          Row(children: [
            Expanded(
                child: TextButton(
                    onPressed: () {},
                    child: Text("Sign out"),
                    style: style.textButtonStyle))
          ])
        ],
      ),
    );
  }
}
