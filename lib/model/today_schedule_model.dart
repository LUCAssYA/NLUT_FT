class TodayScheduleModel {
  int id;
  String name;
  String location;
  String startTime;
  String endTime;

  TodayScheduleModel(
      this.id, this.name, this.location, this.startTime, this.endTime);

  TodayScheduleModel.fromJson(Map<String, dynamic> json):
      id = json['id'],
  name = json['name'],
  location = json['location'],
  startTime = json['startTime'],
  endTime = json['endTime'];

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "location": location,
    "startTime": startTime,
    "endTime": endTime
  };

}