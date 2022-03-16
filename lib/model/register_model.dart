class RegisterModel {
  String email;
  String name;
  String faculty;
  String university;
  String nickName;
  String credential;

  RegisterModel(this.email, this.name, this.faculty, this.university,
      this.nickName, this.credential);

  RegisterModel.fromJson(Map<String, dynamic> json)
      : email = json["email"],
        name = json['name'],
        faculty = json['faculty'],
        university = json['university'],
        nickName = json['nickName'],
        credential = json['credential'];

  Map<String, dynamic> toJson() => {
    "email": email,
    "name": name,
    "faculty": faculty,
    "university": university,
    "nickName": nickName,
    "credential":credential
  };
}
