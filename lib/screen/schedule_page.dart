import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:urooster/provider/schedule_provider.dart';
import 'package:urooster/widget/custom_app_bar.dart';
import 'package:urooster/style/schedule_style.dart' as style;

class SchedulePage extends StatefulWidget {
  SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ScheduleProvider>().getGroups();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: scheduleAppBar(context.watch<ScheduleProvider>().currentGroup.name),
      body: Container(
        margin: style.contextMargin(context),
        child: SfCalendar(
          view: CalendarView.workWeek,
          monthViewSettings: MonthViewSettings(
            showAgenda: true,
          ),
          timeSlotViewSettings: TimeSlotViewSettings(
            startHour: 8.5,
            endHour: 18,
            nonWorkingDays: <int>[
              DateTime.saturday,
              DateTime.sunday,
            ],
            timeInterval: Duration(minutes: 30),
            timeFormat: 'h:mm',
            timeIntervalHeight: -1
          ),
          showDatePickerButton: true,
          minDate: context.watch<ScheduleProvider>().currentGroup.startDate,
          maxDate: context.watch<ScheduleProvider>().currentGroup.endDate,
          onViewChanged: (ViewChangedDetails details){
            print(details.visibleDates.first);
            print(details.visibleDates.last);
          },
        ),
      ),
    );
  }
}
