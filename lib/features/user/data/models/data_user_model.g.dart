// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataUserModel _$DataUserModelFromJson(Map<String, dynamic> json) =>
    DataUserModel(
      userId_: json['user_id'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      roleId_: json['role_id'] as String,
    );

Map<String, dynamic> _$DataUserModelToJson(DataUserModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'user_id': instance.userId_,
      'role_id': instance.roleId_,
    };
