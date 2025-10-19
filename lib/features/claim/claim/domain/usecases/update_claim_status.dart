import 'package:claim_online/core/success/success.dart';
import 'package:claim_online/features/claim/claim/domain/repositories/claim_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';

class UpdateClaimStatus {
  ClaimRepositories claimRepositories;

  UpdateClaimStatus({required this.claimRepositories});

  Future<Either<Failure, Success>> call(int claimId, int statusId) async {
    return await claimRepositories.updateClaimStatus(claimId, statusId);
  }
}
