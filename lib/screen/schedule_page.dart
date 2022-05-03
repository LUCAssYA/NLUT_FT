import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:urooster/model/schedule_data_source.dart';
import 'package:urooster/model/schedule_model.dart';
import 'package:urooster/provider/schedule_provider.dart';
import 'package:urooster/screen/group_list_page.dart';
import 'package:urooster/screen/lecture_list_page.dart';
import 'package:urooster/widget/custom_app_bar.dart';
import 'package:urooster/style/schedule_style.dart' as style;
import 'package:urooster/utils/format.dart' as format;

class SchedulePage extends StatefulWidget {
  SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime? start;
  DateTime? end;
  CalendarController _calendarController = CalendarController();
  DateTime initDate = DateTime.now();

  void showLectureDetail(ScheduleModel schedule, context) {
    bool dday = schedule.dday;

    showModalBottomSheet(
        shape: style.modalShape,
        context: context,
        builder: (BuildContext context) {
          return BottomModal(schedule: schedule);
        });
  }

  void showGroupList() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GroupPage(
                  controller: _calendarController,
                  changeGroup: changeGroup,
                )));
  }

  void showAddLecture() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LectureListPage()));
  }

  void changeGroup(currentDate) {
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      setState(() {
        start = context.read<ScheduleProvider>().currentGroup.startDate;
        end = context.read<ScheduleProvider>().currentGroup.endDate;
        _calendarController.view = CalendarView.day;
      });
      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
        print(context.read<ScheduleProvider>().currentDate);
        _calendarController.displayDate = currentDate;
        _calendarController.view = CalendarView.workWeek;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (context.read<ScheduleProvider>().currentGroup.id == -1) {
      context.read<ScheduleProvider>().getGroups().then((value) {
        setState(() {
          start = context.read<ScheduleProvider>().currentGroup.startDate;
          end = context.read<ScheduleProvider>().currentGroup.endDate;
        });
      });
    }
    else
      print(context.read<ScheduleProvider>().currentGroup.toJson());
  }

  void showSetting() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return GroupScope();
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: scheduleAppBar(
          context.watch<ScheduleProvider>().currentGroup.name,
          showSetting,
          showGroupList,
          showAddLecture),
      body: Calendar(
        calendarController: _calendarController,
        showLectureDetail: showLectureDetail,
        start: start,
        end: end,
      ),
    );
  }
}

class Calendar extends StatefulWidget {
  Calendar(
      {Key? key,
      this.calendarController,
      this.showLectureDetail,
      this.start,
      this.end})
      : super(key: key);

  final calendarController;
  final showLectureDetail;
  final start;
  final end;

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late CalendarController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = widget.calendarController;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: style.contextMargin(context),
        child: SfCalendar(
          controller: widget.calendarController,
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
          showCurrentTimeIndicator: false,
          onViewChanged: (ViewChangedDetails details) {
            context.read<ScheduleProvider>().getLectures(
                details.visibleDates.first, details.visibleDates.last);
          },
          onTap: (CalendarTapDetails details) {
            dynamic appointments = details.appointments;
            if (appointments != null)
              widget.showLectureDetail(appointments[0], context);
          },
        ));
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
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return RemoveDialog(schedule: schedule);
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    String date = widget.schedule.start!= null?format.ddMMMMyyyy.format(widget.schedule.start):"";
    String start = widget.schedule.start!=null?format.hhmm.format(widget.schedule.start):"";
    String end = widget.schedule.start!=null?format.hhmm.format(widget.schedule.end):"";
    String note = widget.schedule.note??"";
    String staff = widget.schedule.staff??"";

    print(widget.schedule.toJson());
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
            staff,
            style: style.modalItemTextStyle,
          )),
          Expanded(
              child:
                  Text(note, style: style.modalItemTextStyle)),
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
                      activeColor: style.switchColor,
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
            onPressed: () => Navigator.pop(context), child: Text("Cancel")),
        TextButton(
            onPressed: () {
              if (checked)
                context
                    .read<ScheduleProvider>()
                    .removeAllSchedule(widget.schedule, context);
              else
                context
                    .read<ScheduleProvider>()
                    .removeOneSchedule(widget.schedule, context);
            },
            child: Text("OK"))
      ],
    );
  }
}

class GroupScope extends StatefulWidget {
  GroupScope({Key? key, this.scope}) : super(key: key);

  final scope;

  @override
  State<GroupScope> createState() => _GroupScopeState();
}

class _GroupScopeState extends State<GroupScope> {
  String _scope = "PRIVATE";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scope = context.read<ScheduleProvider>().currentGroup.scope;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.watch<ScheduleProvider>().currentGroup.name),
      content: Row(
        children: [
          Expanded(
              child: RadioListTile(
            title: Text("Public"),
            onChanged: (value) {
              setState(() {
                _scope = (value as String?)!;
              });
            },
            groupValue: _scope,
            value: "PUBLIC",
          )),
          Expanded(
              child: RadioListTile(
            title: Text("Private"),
            onChanged: (value) {
              setState(() {
                _scope = (value as String?)!;
              });
            },
            groupValue: _scope,
            value: "PRIVATE",
          ))
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: Text("Cancel")),
        TextButton(
            onPressed: () =>
                context.read<ScheduleProvider>().updateScope(_scope, context),
            child: Text("OK"))
      ],
    );
  }
}
