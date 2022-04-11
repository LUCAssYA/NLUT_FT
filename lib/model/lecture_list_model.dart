class LectureListModel {
  int id;
  String name;
  String staff;
  String detail;

  LectureListModel(this.id, this.name, this.staff, this.detail);

  LectureListModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        staff = json['staff'],
        detail = json['detail'];

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "staff": staff, "detail": detail};
}
