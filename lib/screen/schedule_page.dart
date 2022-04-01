import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:urooster/model/schedule_data_source.dart';
import 'package:urooster/model/schedule_model.dart';
import 'package:urooster/provider/schedule_provider.dart';
import 'package:urooster/widget/custom_app_bar.dart';
import 'package:urooster/style/schedule_style.dart' as style;

class SchedulePage extends StatefulWidget {
  SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  void showLectureDetail(ScheduleModel schedule, context) {
    showModalBottomSheet(
      shape: style.modalShape,
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: style.modalContainerPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(schedule.name, style: style.modalHeaderTextStyle,),
                Text(schedule.start.toString() +
                    "~" +
                    schedule.end.toString() +
                    "(" +
                    schedule.location +
                    ")", style: style.modalItemTextStyle,),
                Text(schedule.staff, style: style.modalItemTextStyle,),
                Text(schedule.note, style: style.modalItemTextStyle),
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ScheduleProvider>().getGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          scheduleAppBar(context.watch<ScheduleProvider>().currentGroup.name),
      body: Container(
        margin: style.contextMargin(context),
        child: SfCalendar(
          cellEndPadding: 0,
          todayHighlightColor: style.defaultColor,
          dataSource:
              ScheduleDataSource(context.watch<ScheduleProvider>().schedules),
          view: CalendarView.workWeek,
          scheduleViewSettings: ScheduleViewSettings(),
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
            timeIntervalHeight: -1,
          ),
          appointmentTextStyle: style.appointmentTextStyle,
          showDatePickerButton: true,
          minDate: context.watch<ScheduleProvider>().currentGroup.startDate,
          maxDate: context.watch<ScheduleProvider>().currentGroup.endDate,
          onViewChanged: (ViewChangedDetails details) {
            context.read<ScheduleProvider>().getLectures(
                details.visibleDates.first, details.visibleDates.last);
          },
          onTap: (CalendarTapDetails details) {
            dynamic appointments = details.appointments;
            if (appointments != null)
              showLectureDetail(appointments[0], context);
          },
        ),
      ),
    );
  }
}
