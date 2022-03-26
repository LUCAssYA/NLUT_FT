import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:urooster/model/schedule_model.dart';

class ScheduleDataSource extends CalendarDataSource {

  ScheduleDataSource(List<ScheduleModel> schedule) {
    appointments = schedule;
  }
  @override
  DateTime getStartTime(int index) {
    return _getScheduleData(index).start;
  }

  @override
  DateTime getEndTime(int index) {
    return _getScheduleData(index).end;
  }

  @override
  String getSubject(int index) {
    return _getScheduleData(index).name;
  }

  @override
  bool isAllday(int index) {
    return false;
  }


  ScheduleModel _getScheduleData(int index) {
    final dynamic schedule = appointments![index];
    late final ScheduleModel scheduleData;
    if(schedule is ScheduleModel) {
      scheduleData = schedule;
    }
    return scheduleData;
  }
}