class UniversityModel {
  int id;
  String name;
  String domain;

  UniversityModel(this.id, this.name, this.domain);

  UniversityModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        domain = json['domain'];

  Map<String, dynamic> toJson() => {"id": id, "name": name, "domain": domain};
}
