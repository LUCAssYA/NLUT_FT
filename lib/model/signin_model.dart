class SignInModel {
  String email;
  String password;
  String? fcmToken;

  SignInModel(this.email, this.password, this.fcmToken);

  SignInModel.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        password = json['password'],
        fcmToken = json['token'];

  Map<String, dynamic> toJson() => {"email": email, "password": password, "token": fcmToken};
}
