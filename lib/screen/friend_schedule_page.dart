import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:urooster/model/schedule_data_source.dart';
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

  CalendarController controller = CalendarController();
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
    print(context.read<FriendScheduleProvider>().currentGroup!.startDate);
    controller.displayDate = context.read<FriendScheduleProvider>().currentGroup!.startDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: friendScheduleAppbar(context, onChange, context.watch<FriendScheduleProvider>().groups, "Semester", null, context.watch<FriendScheduleProvider>().currentGroup, onClose),
      body: context.watch<FriendScheduleProvider>().currentGroup == null?Container():Schedules(controller: controller,)
    );
  }
}

class Schedules extends StatelessWidget {
  const Schedules({Key? key, this.controller}) : super(key: key);
  final controller;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: style.scheduleMargin(context),
      child: SfCalendar(
        dataSource: ScheduleDataSource(context.watch<FriendScheduleProvider>().schedules),
        controller: controller,
        minDate: context.watch<FriendScheduleProvider>().currentGroup?.startDate,
        maxDate: context.watch<FriendScheduleProvider>().currentGroup?.endDate,
        todayHighlightColor: style.defaultColor,
        view: CalendarView.workWeek,
          timeSlotViewSettings: TimeSlotViewSettings(
            startHour: 8.5,
            endHour: 18,
            timeInterval: Duration(minutes: 30),
            timeFormat: 'h:mm',
            timeIntervalHeight: -1
          ),
        monthViewSettings: MonthViewSettings(
          showAgenda: true
        ),
        scheduleViewSettings: ScheduleViewSettings(),
        showDatePickerButton: true,
        showCurrentTimeIndicator: false,
        onViewChanged: (ViewChangedDetails details) {
          context.read<FriendScheduleProvider>().getFriendScheduleList(details.visibleDates.first, details.visibleDates.last);
        },
        cellEndPadding: 0,
        appointmentTextStyle: style.appointmentTextStyle,
      ),
    );
  }
}

