
class DdayModel {
  int id;
  String name;
  int dday;

  DdayModel(this.id, this.name, this.dday);

  DdayModel.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    name = json['name'],
    dday = json['dday'];

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "dday": dday
  };
}