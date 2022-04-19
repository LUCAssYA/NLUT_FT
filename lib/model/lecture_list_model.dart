class LectureListModel {
  int id;
  String name;
  String staff;

  LectureListModel(this.id, this.name, this.staff);

  LectureListModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        staff = json['staff'];

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "staff": staff};
}
