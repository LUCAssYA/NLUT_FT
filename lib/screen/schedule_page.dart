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
import 'package:urooster/utils/format.dart' as format;

class SchedulePage extends StatefulWidget {
  SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  void showLectureDetail(ScheduleModel schedule, context) {
    bool dday = schedule.dday;

    showModalBottomSheet(
        shape: style.modalShape,
        context: context,
        builder: (BuildContext context) {
          return BottomModal(
            schedule: schedule
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

class BottomModal extends StatefulWidget {
  BottomModal({Key? key, this.schedule})
      : super(key: key);

  final schedule;


  @override
  State<BottomModal> createState() => _BottomModalState();
}

class _BottomModalState extends State<BottomModal> {

  late bool dday = widget.schedule.dday;

  @override
  Widget build(BuildContext context) {
    String date = format.ddMMMMyyyy.format(widget.schedule.start);
    String start = format.hhmm.format(widget.schedule.start);
    String end = format.hhmm.format(widget.schedule.end);

    return Container(
      padding: style.modalContainerPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.schedule.name,
            style: style.modalHeaderTextStyle,
          ),
          Text(date.toString(), style: style.modalItemTextStyle),
          Text(
            start.toString() +
                "~" +
                end.toString() +
                "(" +
                widget.schedule.location +
                ")",
            style: style.modalItemTextStyle,
          ),
          Text(
            widget.schedule.staff,
            style: style.modalItemTextStyle,
          ),
          Text(widget.schedule.note, style: style.modalItemTextStyle),
          Row(
            children: [
              Icon(Icons.calendar_month),
              Text("D-Day"),
              Switch(
                  value: dday,
                  onChanged: (value) {
                    setState(() {
                      dday = value;
                    });
                  })
            ],
          ),
         ElevatedButton(onPressed: (){}, child: Row(
           children: [
             Icon(Icons.delete),
             Text("Remove schedule")
           ],
         ))
        ],
      ),
    );
    ;
  }
}
