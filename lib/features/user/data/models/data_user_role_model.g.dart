// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_user_role_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataUserRoleModel _$DataUserRoleModelFromJson(Map<String, dynamic> json) =>
    DataUserRoleModel(
      userRoleId_: json['role_id'] as String,
      userRoleName_: json['role_desc'] as String,
    );

Map<String, dynamic> _$DataUserRoleModelToJson(DataUserRoleModel instance) =>
    <String, dynamic>{
      'role_id': instance.userRoleId_,
      'role_desc': instance.userRoleName_,
    };
