// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_claim_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataClaimModel _$DataClaimModelFromJson(Map<String, dynamic> json) =>
    DataClaimModel(
      claimId_: (json['claim_id'] as num).toInt(),
      userId_: json['user_id'] as String,
      category_: json['category'] as String,
      status_: json['status'] as String,
      claimDesc_: json['claim_desc'] as String,
      files_: (json['files'] as List<dynamic>)
          .map((e) => DataClaimFilesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataClaimModelToJson(DataClaimModel instance) =>
    <String, dynamic>{
      'claim_id': instance.claimId_,
      'user_id': instance.userId_,
      'category': instance.category_,
      'status': instance.status_,
      'claim_desc': instance.claimDesc_,
      'files': instance.files_,
    };
