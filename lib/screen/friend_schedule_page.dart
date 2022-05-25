import 'package:flutter/material.dart';
import 'package:urooster/widget/custom_app_bar.dart';

class FriendSchedulPage extends StatefulWidget {
  const FriendSchedulPage({Key? key, this.id}) : super(key: key);

  final id;
  @override
  State<FriendSchedulPage> createState() => _FriendSchedulPageState();
}

class _FriendSchedulPageState extends State<FriendSchedulPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: friendScheduleAppbar(context, (){}, [], "Semester", null, null),
      body: Container(),
    );
  }
}
