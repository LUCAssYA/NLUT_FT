class ScheduleModel {
  int id;
  String name;
  DateTime start;
  DateTime end;

  ScheduleModel(this.id, this.name, this.start, this.end);

  ScheduleModel.fromJson(Map<String, dynamic> json)
      :
        id = json['id'],
        name = json['name'],
        start = DateTime.parse(json['start'] as String),
        end = DateTime.parse(json['end'] as String);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "start": start, "end": end};

}