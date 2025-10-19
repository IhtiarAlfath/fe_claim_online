// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_claim_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataClaimStatusModel _$DataClaimStatusModelFromJson(
        Map<String, dynamic> json) =>
    DataClaimStatusModel(
      claimStatusId_: (json['status_id'] as num).toInt(),
      claimStatusDesc_: json['status_desc'] as String,
    );

Map<String, dynamic> _$DataClaimStatusModelToJson(
        DataClaimStatusModel instance) =>
    <String, dynamic>{
      'status_id': instance.claimStatusId_,
      'status_desc': instance.claimStatusDesc_,
    };
