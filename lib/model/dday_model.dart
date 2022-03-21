class DdayModel {
  int groupId;
  int lectureId;
  String name;
  String dday;

  DdayModel(this.groupId, this.lectureId, this.name, this.dday);

  DdayModel.fromJson(Map<String, dynamic> json)
      : groupId = json['groupId'],
        lectureId = json['lectureId'],
        name = json['name'],
        dday = json['dday'];

  Map<String, dynamic> toJson() => {"groupId": groupId, "lectureId": lectureId, "name": name, "dday": dday};
}
