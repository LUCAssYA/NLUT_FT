class SimpleModel {
  int id;
  String name;

  SimpleModel(this.id, this.name);

  SimpleModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
