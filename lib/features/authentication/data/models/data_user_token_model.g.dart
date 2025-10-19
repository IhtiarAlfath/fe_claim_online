// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_user_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataUserTokenModel _$DataUserTokenModelFromJson(Map<String, dynamic> json) =>
    DataUserTokenModel(
      email: json['email'] as String,
      token: json['token'] as String,
      username: json['username'] as String,
      roleId_: json['role_id'] as String,
      userId_: json['user_id'] as String,
    );

Map<String, dynamic> _$DataUserTokenModelToJson(DataUserTokenModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'token': instance.token,
      'role_id': instance.roleId_,
      'user_id': instance.userId_,
    };
