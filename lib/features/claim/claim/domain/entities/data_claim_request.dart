import 'package:claim_online/features/claim/claim/domain/entities/data_claim_file_request.dart';
import 'package:equatable/equatable.dart';

class DataClaimRequest extends Equatable {
  final String userId;
  final String categoryId;
  final String claimDesc;
  final List<DataClaimFileRequest> files;

  const DataClaimRequest({
    required this.userId,
    required this.categoryId,
    required this.claimDesc,
    required this.files,
  });
  @override
  List<Object?> get props => [

        userId,
        categoryId,
        claimDesc,
        files,
      ];
}
