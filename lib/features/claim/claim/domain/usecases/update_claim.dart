import 'package:claim_online/core/success/success.dart';
import 'package:claim_online/features/claim/claim/domain/entities/data_claim_update_request.dart';
import 'package:claim_online/features/claim/claim/domain/repositories/claim_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';

class UpdateClaim {
  ClaimRepositories claimRepositories;

  UpdateClaim({required this.claimRepositories});

  Future<Either<Failure, Success>> call(DataClaimUpdateRequest request) async {
    return await claimRepositories.updateClaim(request);
  }
}
