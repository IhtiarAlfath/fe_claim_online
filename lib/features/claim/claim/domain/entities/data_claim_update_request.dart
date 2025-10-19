import 'package:equatable/equatable.dart';

class DataClaimUpdateRequest extends Equatable {
  final String userId;
  final String categoryId;
  final String claimDesc;
  final int claimId;

  const DataClaimUpdateRequest({
    required this.userId,
    required this.categoryId,
    required this.claimDesc,
    required this.claimId,
  });
  @override
  List<Object?> get props => [

        userId,
        categoryId,
        claimDesc,
        claimId,
      ];
}
