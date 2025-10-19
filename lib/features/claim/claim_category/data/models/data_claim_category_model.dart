import 'package:claim_online/features/claim/claim_category/domain/entities/data_claim_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_claim_category_model.g.dart';

@JsonSerializable()
class DataClaimCategoryModel extends DataClaimCategory {
  @JsonKey(name: 'category_id')
  final String claimCategoryId_;
  @JsonKey(name: 'category_desc')
  final String claimCategoryDesc_;

  const DataClaimCategoryModel({
    required this.claimCategoryId_,
    required this.claimCategoryDesc_,
  }) : super(
          claimCategoryId: claimCategoryId_,
          claimCategoryName: claimCategoryDesc_,
        );

  factory DataClaimCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$DataClaimCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataClaimCategoryModelToJson(this);
}
