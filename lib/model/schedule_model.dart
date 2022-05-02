import 'dart:ui';

class ScheduleModel {
  int id;
  String name;
  DateTime start;
  DateTime end;
  Color color;
  String? staff;
  String? location;
  String? note;
  bool dday;

  ScheduleModel(this.id, this.name, this.start, this.end, this.color,
      this.staff, this.location, this.note, this.dday);

  ScheduleModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        start = DateTime.parse(json['start'] as String),
        end = DateTime.parse(json['end'] as String),
        color = Color(json['color']),
        staff = json['staff'],
        location = json['location'],
        note = json['note'],
        dday = json['dday'];

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "start": start,
        "end": end,
        "color": color,
        "staff": staff,
        "location": location,
        "note": note,
        "dday": dday
      };
}
