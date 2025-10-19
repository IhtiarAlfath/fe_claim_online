import 'package:claim_online/features/claim/claim/domain/entities/data_claim.dart';
import 'package:claim_online/features/claim/claim/domain/repositories/claim_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';

class GetClaimByClaimId {
  ClaimRepositories claimRepositories;

  GetClaimByClaimId({required this.claimRepositories});

  Future<Either<Failure, DataClaim>> call(int claimId) async {
    return await claimRepositories.getClaimByClaimId(claimId);
  }
}
