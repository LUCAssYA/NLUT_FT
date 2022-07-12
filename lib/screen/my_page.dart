import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:urooster/provider/auth_provider.dart';
import 'package:urooster/provider/eval_provider.dart';
import 'package:urooster/provider/friend_schedule_provider.dart';
import 'package:urooster/provider/home_provider.dart';
import 'package:urooster/provider/lecture_provider.dart';
import 'package:urooster/provider/my_provider.dart';
import 'package:urooster/provider/notification_provider.dart';
import 'package:urooster/provider/register_provider.dart';
import 'package:urooster/provider/schedule_provider.dart';
import 'package:urooster/widget/custom_app_bar.dart';
import 'package:urooster/style/my_page_style.dart' as style;
import 'package:urooster/widget/dialog.dart';
import 'package:urooster/widget/text_field.dart';
import 'package:urooster/widget/toast.dart';

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
                  ],
                ),
                Text(
                  context.watch<MyPageProvider>().user.university,
                  style: style.itemTextStyle,
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
  final nameController = TextEditingController();
  final nickNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final oldController = TextEditingController();
  final newController = TextEditingController();

  final confirmController = TextEditingController();

  void onClickUserInfoOK() {
    context
        .read<MyPageProvider>()
        .changeUserDetail(nameController.text, nickNameController.text);
    Navigator.pop(context);
  }

  void onClickChangePasswordOK() async {
    String result = await context
        .read<MyPageProvider>()
        .changePassword(formKey, oldController.text);
    if (result != "") {
      showToast(context, result);
      return;
    }
    Navigator.pop(context);
  }

  void onClickWithDrawOK() {
    context.read<MyPageProvider>().withDraw().then((value) {
      context.read<EvalProvider>().signOut();
      context.read<AuthProvider>().singOut();
      context.read<FriendScheduleProvider>().signOut();
      context.read<HomeProvider>().signOut();
      context.read<LectureProvider>().signOut();
      context.read<NotificationProvider>().signOut();
      context.read<ScheduleProvider>().signOut();
      Navigator.popUntil(context, (route) => route.isFirst);
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
              onPressed: () => dialog(
                  context,
                  Text("Change User Information"),
                  UserInfoChange(
                    nameController: nameController,
                    nickNameController: nickNameController,
                  ),
                  onClickUserInfoOK),
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
              onPressed: () => dialog(
                  context,
                  Text("Change Password"),
                  ChangePassword(
                    controller: oldController,
                    newController: newController,
                    confirmController: confirmController,
                    formKey: formKey,
                  ),
                  onClickChangePasswordOK),
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
                    onPressed: () => dialog(context, Text("Withdraw"), Text("Do you really want to withdraw?"), onClickWithDrawOK),
                    child: Text(
                      "Withdraw",
                      style: style.textButtonTextStyle,
                    ),
                    style: style.textButtonStyle)),
          ]),
          Row(children: [
            Expanded(
                child: TextButton(
              onPressed: () {
                context.read<MyPageProvider>().signOut();
                context.read<EvalProvider>().signOut();
                context.read<AuthProvider>().singOut();
                context.read<FriendScheduleProvider>().signOut();
                context.read<HomeProvider>().signOut();
                context.read<LectureProvider>().signOut();
                context.read<NotificationProvider>().signOut();
                context.read<ScheduleProvider>().signOut();
                Navigator.popUntil(context, (route) => route.isFirst);
              },
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
  UserInfoChange({Key? key, this.nameController, this.nickNameController})
      : super(key: key);

  final nameController;
  final nickNameController;

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
    widget.nameController.text = context.read<MyPageProvider>().user.name;
    widget.nickNameController.text =
        context.read<MyPageProvider>().user.nickName;
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
                autoCorrect: true,
                suggestion: true,
                controller: widget.nameController,
              ),
              CustomTextFormField(
                label: "Nickname",
                obscure: false,
                suggestion: true,
                autoCorrect: true,
                controller: widget.nickNameController,
              ),
              SelectBox(
                label: "Faculty",
                items: context.watch<MyPageProvider>().facultyList,
                value: context.watch<MyPageProvider>().facultyList.length == 0
                    ? null
                    : context.read<MyPageProvider>().currentFaculty as Object?,
                onChange: context.read<MyPageProvider>().onChangeFaculty,
              ),
            ],
          ),
        ));
  }
}

class ChangePassword extends StatefulWidget {
  ChangePassword(
      {Key? key,
      this.formKey,
      this.controller,
      this.newController,
      this.confirmController})
      : super(key: key);

  final formKey;
  final controller;
  final newController;
  final confirmController;

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Form(
          key: widget.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomTextFormField(
                obscure: true,
                suggestion: false,
                autoCorrect: false,
                label: "Old Password",
                validator: context.read<MyPageProvider>().defaultValidator,
                controller: widget.controller,
              ),
              CustomTextFormField(
                obscure: true,
                suggestion: false,
                autoCorrect: false,
                label: "New Password",
                validator: context.read<MyPageProvider>().defaultValidator,
                controller: widget.newController,
                onChange: context.read<MyPageProvider>().onChangePassword,
              ),
              CustomTextFormField(
                obscure: true,
                suggestion: false,
                autoCorrect: false,
                label: "Confirm New Password",
                validator: context.read<MyPageProvider>().passwordValidator,
                controller: widget.confirmController,
              )
            ],
          ),
        ));
  }
}
