class UserModel {
  String email;
  String name;
  String faculty;
  String university;
  String nickName;

  UserModel(
      this.email, this.name, this.faculty, this.university, this.nickName);

  UserModel.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        name = json['name'],
        faculty = json['faculty'],
        university = json['university'],
        nickName = json['nickName'];

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "faculty": faculty,
        "university": university,
        "nickName": nickName
      };
}
