import 'package:urooster/provider/schedule_provider.dart';

class CustomLecture {
  String name;
  String staff;
  List<Map<String, dynamic>> details;

  CustomLecture(this.name, this.staff, this.details);

  CustomLecture.fromJson(Map<String, dynamic> json)
      : name = json['date'],
        staff = json['staff'],
        details = json['details']
            .forEach((element) => CustomLectureDetail.fromJson(element));

  Map<String, dynamic> toJson() =>
      {"name": name, "staff": staff, "details": details};
}

class CustomLectureDetail {
  DateTime date;
  String start;
  String end;
  String location;

  CustomLectureDetail(this.date, this.start, this.end, this.location);

  CustomLectureDetail.fromJson(Map<String, dynamic> json)
      : date = json['date'],
        start = json['start'],
        end = json['end'],
        location = json['location'];

  Map<String, dynamic> toJson() =>
      {"date": date, "start": start, "end": end, "location": location};
}
