class GroupList {
  int id;
  String name;

  GroupList(this.id, this.name);

  GroupList.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name};
}
