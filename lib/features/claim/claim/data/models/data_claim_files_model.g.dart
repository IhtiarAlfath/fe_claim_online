// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_claim_files_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataClaimFilesModel _$DataClaimFilesModelFromJson(Map<String, dynamic> json) =>
    DataClaimFilesModel(
      fileId_: (json['file_id'] as num).toInt(),
      claimId_: (json['claim_id'] as num).toInt(),
      fileName_: json['file_name'] as String,
      fileType_: json['file_type'] as String,
      fileData_: json['file_data'] as String,
    );

Map<String, dynamic> _$DataClaimFilesModelToJson(
        DataClaimFilesModel instance) =>
    <String, dynamic>{
      'file_id': instance.fileId_,
      'claim_id': instance.claimId_,
      'file_name': instance.fileName_,
      'file_type': instance.fileType_,
      'file_data': instance.fileData_,
    };
