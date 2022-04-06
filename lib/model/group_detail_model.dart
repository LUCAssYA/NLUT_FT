class GroupDetail {
  int id;
  String name;
  String year;
  String semester;
  String scope;
  DateTime startDate;
  DateTime endDate;

  GroupDetail(this.id, this.name, this.year, this.semester, this.scope,
      this.startDate, this.endDate);

  GroupDetail.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        year = json['year'],
        semester = json['semester'],
        scope = json['scope'],
        startDate = DateTime.parse(json['startDate']),
        endDate = DateTime.parse(json['endDate']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "year": year,
        "semester": semester,
        "scope": scope,
        "startDate": startDate,
        "endDate": endDate
      };
}
