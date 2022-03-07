// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterModel _$RegisterModelFromJson(Map<String, dynamic> json) {
  return RegisterModel(
    json['email'] as String,
    json['name'] as String,
    json['faculty'] as String,
    json['university'] as String,
    json['nickName'] as String,
    json['credential'] as String,
  );
}

Map<String, dynamic> _$RegisterModelToJson(RegisterModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'faculty': instance.faculty,
      'university': instance.university,
      'nickName': instance.nickName,
      'credential': instance.credential,
    };
