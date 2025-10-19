import 'package:claim_online/features/claim/claim/domain/entities/data_claim_file.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_claim_files_model.g.dart';

@JsonSerializable()
class DataClaimFilesModel extends DataClaimFile {
  @JsonKey(name: 'file_id')
  final int fileId_;
  @JsonKey(name: 'claim_id')
  final int claimId_;
  @JsonKey(name: 'file_name')
  final String fileName_;
  @JsonKey(name: 'file_type')
  final String fileType_;
  @JsonKey(name: 'file_data')
  final String fileData_;

  const DataClaimFilesModel({
    required this.fileId_,
    required this.claimId_,
    required this.fileName_,
    required this.fileType_,
    required this.fileData_,
  }) : super(
          fileId: fileId_,
          claimId: claimId_,
          fileName: fileName_,
          fileType: fileType_,
          fileData: fileData_,
        );

  factory DataClaimFilesModel.fromJson(Map<String, dynamic> json) =>
      _$DataClaimFilesModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataClaimFilesModelToJson(this);
}
