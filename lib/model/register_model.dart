import 'package:json_annotation/json_annotation.dart';

part 'register_model.g.dart';

@JsonSerializable()
class RegisterModel {
  String email;
  String name;
  String faculty;
  String university;
  String nickName;
  String credential;

  RegisterModel(this.email, this.name, this.faculty, this.university,
      this.nickName, this.credential);

  factory RegisterModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterModelToJson(this);
}