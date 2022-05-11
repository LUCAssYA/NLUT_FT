class LectureListModel {
  int id;
  String name;
  String? staff;
  double score;

  LectureListModel(this.id, this.name, this.staff, this.score);

  LectureListModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        staff = json['staff'],
        score = json['score'];

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "staff": staff, "score": score};
}
