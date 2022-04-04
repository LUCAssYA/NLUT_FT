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
          return BottomModal(schedule: schedule);
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
  BottomModal({Key? key, this.schedule}) : super(key: key);

  final schedule;

  @override
  State<BottomModal> createState() => _BottomModalState();
}

class _BottomModalState extends State<BottomModal> {
  late bool dday = widget.schedule.dday;
  bool check = false;

  void removeMessage(schedule) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter setState){
            return RemoveDialog(schedule: schedule);
          },);
        });
  }

  @override
  Widget build(BuildContext context) {
    String date = format.ddMMMMyyyy.format(widget.schedule.start);
    String start = format.hhmm.format(widget.schedule.start);
    String end = format.hhmm.format(widget.schedule.end);
    return Container(
      height: style.modalHeight(context),
      padding: style.modalContainerPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Text(
            widget.schedule.name,
            style: style.modalHeaderTextStyle,
          )),
          Expanded(
              child: Text(date.toString(), style: style.modalItemTextStyle)),
          Expanded(
              child: Text(
            start.toString() +
                "~" +
                end.toString() +
                "(" +
                widget.schedule.location +
                ")",
            style: style.modalItemTextStyle,
          )),
          Expanded(
              child: Text(
            widget.schedule.staff,
            style: style.modalItemTextStyle,
          )),
          Expanded(
              child:
                  Text(widget.schedule.note, style: style.modalItemTextStyle)),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(flex: 1, child: Icon(Icons.calendar_today)),
              Expanded(
                  flex: 15,
                  child: Container(
                      margin: style.modalTextMargin,
                      child: Text(
                        "D-Day",
                        style: style.modalItemTextStyle,
                      ))),
              Expanded(
                  flex: 1,
                  child: Switch(
                      value: dday,
                      onChanged: (value) {
                        setState(() {
                          dday = value;
                        });
                      }))
            ],
          )),
          Expanded(
              child: ElevatedButton(
                  style: style.removeButtonStyle,
                  onPressed: () => removeMessage(widget.schedule),
                  child: Row(
                    children: [
                      Icon(Icons.delete),
                      Container(
                          margin: style.modalTextMargin,
                          child: Text(
                            "Remove schedule",
                            style: style.modalItemTextStyle,
                          ))
                    ],
                  ))),
          Expanded(
              child: Container(
            margin: style.modalButtonMargin,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: style.modalItemTextStyle,
                    )),
                TextButton(
                    onPressed: () => context
                        .read<ScheduleProvider>()
                        .changeDday(widget.schedule, dday, context),
                    child: Text(
                      "OK",
                      style: style.modalItemTextStyle,
                    ))
              ],
            ),
          ))
        ],
      ),
    );
    ;
  }
}

class RemoveDialog extends StatefulWidget {
  const RemoveDialog({Key? key, this.schedule}) : super(key: key);

  final schedule;
  @override
  State<RemoveDialog> createState() => _RemoveDialogState();
}

class _RemoveDialogState extends State<RemoveDialog> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Do you want to remove this schedule?"),
      content: Row(children: [
        Expanded(
            child: CheckboxListTile(
              title: Text("Remove all this schedule from your schedule"),
              value: checked,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {

                setState(() {
                  checked = value!;
                });
              },
            ))
      ]),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel")),
        TextButton(
            onPressed: () => context
                .read<ScheduleProvider>()
                .removeSchedule(widget.schedule, context, checked),
            child: Text("OK"))
      ],
    );
  }
}

