import 'package:claim_online/features/claim/claim/domain/entities/data_claim_file.dart';
import 'package:equatable/equatable.dart';

class DataClaim extends Equatable {
  final int claimId;
  final String userId;
  final String category;
  final String status;
  final String claimDesc;
  final List<DataClaimFile> files;

  const DataClaim({
    required this.claimId,
    required this.userId,
    required this.category,
    required this.status,
    required this.claimDesc,
    required this.files,
  });
  @override
  List<Object?> get props => [
        claimId,
        userId,
        category,
        status,
        claimDesc,
        files,
      ];
}
