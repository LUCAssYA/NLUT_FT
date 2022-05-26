import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:urooster/provider/schedule_provider.dart';
import 'package:urooster/widget/custom_app_bar.dart';
import 'package:urooster/style/friend_style.dart' as style;

import '../provider/friend_schedule_provider.dart';

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
    print(this.widget.id);
    context.read<FriendScheduleProvider>().getFriendGroup(this.widget.id);
  }

  void onClose() {
    context.read<FriendScheduleProvider>().clear();
    Navigator.pop(context);
  }

  void onChange(value) {
    context.read<FriendScheduleProvider>().changeCurrentGroup(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: friendScheduleAppbar(context, onChange, context.watch<FriendScheduleProvider>().groups, "Semester", null, context.watch<FriendScheduleProvider>().currentGroup, onClose),
      body: context.watch<FriendScheduleProvider>().currentGroup == null?Container():Schedules()
    );
  }
}

class Schedules extends StatelessWidget {
  const Schedules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: style.scheduleMargin(context),
      child: SfCalendar(
        minDate: context.watch<FriendScheduleProvider>().currentGroup?.startDate,
        maxDate: context.watch<FriendScheduleProvider>().currentGroup?.endDate,
        view: CalendarView.workWeek,
          timeSlotViewSettings: TimeSlotViewSettings(
            startHour: 8.5,
            endHour: 18,
            timeInterval: Duration(minutes: 30),
            timeFormat: 'h:mm',
            timeIntervalHeight: -1
          ),
        onViewChanged: (ViewChangedDetails details) {

        },
      ),
    );
  }
}

