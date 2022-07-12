import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urooster/provider/notification_provider.dart';
import 'package:urooster/style/notification_style.dart' as style;
import 'package:urooster/widget/custom_app_bar.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<NotificationProvider>().getRequestedFriend();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: style.topMargin(context),
      child: Column(
        children: [
          OutlinedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FriendListPage())),
              child: Container(
                padding: style.friendButtonPadding,
                height: style.friendButtonHeight(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Requested Friend",
                      style: style.friendButtonText,
                    ),
                    SizedBox(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                          if (context
                              .watch<NotificationProvider>()
                              .friendList
                              .isNotEmpty)
                            Icon(
                              Icons.circle,
                              size: 11.0,
                              color: Colors.pinkAccent,
                            ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: style.defaultColor,
                          )
                        ]))
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class FriendListPage extends StatelessWidget {
  const FriendListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Container(
        decoration: style.listContainerDecoration(),
        margin: style.listMargin,
        child: SingleChildScrollView(
          child: ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: style.listHeight(context),
                    margin: style.listMargin,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                              context
                                  .watch<NotificationProvider>()
                                  .friendList[index]
                                  .name,
                              style: style.listTextStyle),
                        ),
                        Expanded(
                          flex: 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  onPressed: () => context.read<NotificationProvider>().rejectAndAccept("accept", index),
                                  child: Text("Confirm"),
                                  style: style.confirmButtonStyle),
                              OutlinedButton(
                                  onPressed: () => context.read<NotificationProvider>().rejectAndAccept("reject", index),
                                  child: Text("Delete"),
                                  style: style.deleteButtonStyle)
                            ],
                          ),
                        )
                      ],
                    ));
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount:
                  context.watch<NotificationProvider>().friendList.length),
        ),
      ),
    );
  }
}
