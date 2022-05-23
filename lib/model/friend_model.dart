class FriendModel {
  int id;
  String name;
  String status;

  FriendModel(this.id, this.name, this.status);

  FriendModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        status = json['status'];

  Map<String, dynamic> toJson() => {"id": id, "name": name, "status": status};
}
