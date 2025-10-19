// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_claim_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataClaimCategoryModel _$DataClaimCategoryModelFromJson(
        Map<String, dynamic> json) =>
    DataClaimCategoryModel(
      claimCategoryId_: json['category_id'] as String,
      claimCategoryDesc_: json['category_desc'] as String,
    );

Map<String, dynamic> _$DataClaimCategoryModelToJson(
        DataClaimCategoryModel instance) =>
    <String, dynamic>{
      'category_id': instance.claimCategoryId_,
      'category_desc': instance.claimCategoryDesc_,
    };
