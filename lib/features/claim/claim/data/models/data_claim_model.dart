import 'package:claim_online/features/claim/claim/data/models/data_claim_files_model.dart';
import 'package:claim_online/features/claim/claim/domain/entities/data_claim.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_claim_model.g.dart';

@JsonSerializable()
class DataClaimModel extends DataClaim {
  @JsonKey(name: 'claim_id')
  final int claimId_;
  @JsonKey(name: 'user_id')
  final String userId_;
  @JsonKey(name: 'category')
  final String category_;
  @JsonKey(name: 'status')
  final String status_;
  @JsonKey(name: 'claim_desc')
  final String claimDesc_;
  @JsonKey(name: 'files')
  final List<DataClaimFilesModel> files_;

  const DataClaimModel({
    required this.claimId_,
    required this.userId_,
    required this.category_,
    required this.status_,
    required this.claimDesc_,
    required this.files_,
  }) : super(
          claimId: claimId_,
          userId: userId_,
          category: category_,
          status: status_,
          claimDesc: claimDesc_,
          files: files_,
        );

  factory DataClaimModel.fromJson(Map<String, dynamic> json) =>
      _$DataClaimModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataClaimModelToJson(this);
}
