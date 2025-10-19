import 'package:equatable/equatable.dart';

class DataClaimStatus extends Equatable {
  final int claimStatusId;
  final String claimStatusName;

  const DataClaimStatus({
    required this.claimStatusId,
    required this.claimStatusName,
  });
  @override
  List<Object?> get props => [
        claimStatusId,
        claimStatusName,
      ];
}
