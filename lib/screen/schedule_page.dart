import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:urooster/widget/custom_app_bar.dart';
import 'package:urooster/style/schedule_style.dart' as style;

class SchedulePage extends StatelessWidget {
  SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: scheduleAppBar("2021/2022 Semester 1"),
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
          minDate: DateTime(2022, 3, 14),
          maxDate: DateTime(2022, 3, 30),
          onViewChanged: (ViewChangedDetails details){
            print(details.visibleDates);
          },
        ),
      ),
    );
  }
}
