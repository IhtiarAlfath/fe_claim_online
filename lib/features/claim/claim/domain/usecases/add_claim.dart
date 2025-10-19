import 'package:claim_online/core/success/success.dart';
import 'package:claim_online/features/claim/claim/domain/entities/data_claim_request.dart';
import 'package:claim_online/features/claim/claim/domain/repositories/claim_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';

class AddClaim {
  ClaimRepositories claimRepositories;

  AddClaim({required this.claimRepositories});

  Future<Either<Failure, Success>> call(DataClaimRequest request) async {
    return await claimRepositories.addClaim(request);
  }
}
