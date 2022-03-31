import 'dart:ui';

class ScheduleModel {
  int id;
  String name;
  DateTime start;
  DateTime end;
  Color color;

  ScheduleModel(this.id, this.name, this.start, this.end, this.color);

  ScheduleModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        start = DateTime.parse(json['start'] as String),
        end = DateTime.parse(json['end'] as String),
        color = Color(json['color']);

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "start": start, "end": end, "color": color};
}
