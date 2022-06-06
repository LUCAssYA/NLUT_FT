import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urooster/provider/my_provider.dart';
import 'package:urooster/widget/custom_app_bar.dart';
import 'package:urooster/style/my_page_style.dart' as style;
import 'package:urooster/widget/text_field.dart';

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

class AccountSetting extends StatefulWidget {
  const AccountSetting({Key? key}) : super(key: key);

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {

  void changeUserInfoDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Text("Change User Information"),
              content: UserInfoChange(),
              actions: [
                Row(
                  children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              "Cancel",
                              style: style.actionButton,
                            ))),
                    Expanded(
                        child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "OK",
                        style: style.actionButton,
                      ),
                    ))
                  ],
                )
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: style.containerMargin,
      padding: style.itemPadding,
      decoration: style.containerDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: style.itemPadding,
              child: Text(
                "Account",
                style: style.labelTextStyle,
              )),
          Row(children: [
            Expanded(
                child: TextButton(
              onPressed: () => changeUserInfoDialog(),
              child: Text(
                "Change User Information",
                style: style.textButtonTextStyle,
              ),
              style: style.textButtonStyle,
            )),
          ]),
          Row(children: [
            Expanded(
                child: TextButton(
              onPressed: () {},
              child: Text(
                "Change Password",
                style: style.textButtonTextStyle,
              ),
              style: style.textButtonStyle,
            )),
          ]),
          Row(children: [
            Expanded(
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Withdraw",
                      style: style.textButtonTextStyle,
                    ),
                    style: style.textButtonStyle)),
          ]),
          Row(children: [
            Expanded(
                child: TextButton(
              onPressed: () {},
              child: Text(
                "Sign out",
                style: style.textButtonTextStyle,
              ),
              style: style.textButtonStyle,
            ))
          ])
        ],
      ),
    );
  }
}

class UserInfoChange extends StatefulWidget {
  UserInfoChange({Key? key}) : super(key: key);

  @override
  State<UserInfoChange> createState() => _UserInfoChangeState();
}

class _UserInfoChangeState extends State<UserInfoChange> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<MyPageProvider>().getFaculty();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomTextFormField(
              label: "Name",
              obscure: false,
              suggestion: true,
              autoCorrect: true,
              value: context.read<MyPageProvider>().user.name,
            ),
            CustomTextFormField(
              label: "Nickname",
              obscure: false,
              suggestion: true,
              autoCorrect: true,
              value: context.read<MyPageProvider>().user.nickName,
            ),
            SelectBox(
              label: "Faculty",
              items: context.watch<MyPageProvider>().facultyList,
              value: context.watch<MyPageProvider>().facultyList.length == 0?null:context.read<MyPageProvider>().currentFaculty as Object?,
              onChange: (){},
            ),
          ],
        ),
      )
    );
  }
}
