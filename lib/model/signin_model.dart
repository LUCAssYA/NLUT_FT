class SignInModel {
  String email;
  String password;

  SignInModel(this.email, this.password);

  SignInModel.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        password = json['password'];

  Map<String, dynamic> toJson() => {"email": email, "password": password};
}
