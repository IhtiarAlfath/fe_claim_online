import 'package:claim_online/features/claim/claim_status/domain/entities/data_claim_status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_claim_status_model.g.dart';

@JsonSerializable()
class DataClaimStatusModel extends DataClaimStatus {
  @JsonKey(name: 'status_id')
  final int claimStatusId_;
  @JsonKey(name: 'status_desc')
  final String claimStatusDesc_;

  const DataClaimStatusModel({
    required this.claimStatusId_,
    required this.claimStatusDesc_,
  }) : super(
          claimStatusId: claimStatusId_,
          claimStatusName: claimStatusDesc_,
        );

  factory DataClaimStatusModel.fromJson(Map<String, dynamic> json) =>
      _$DataClaimStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataClaimStatusModelToJson(this);
}
