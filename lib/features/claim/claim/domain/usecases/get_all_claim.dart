import 'package:claim_online/features/claim/claim/domain/entities/data_claim.dart';
import 'package:claim_online/features/claim/claim/domain/repositories/claim_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';

class GetAllClaim {
  ClaimRepositories claimRepositories;

  GetAllClaim({required this.claimRepositories});

  Future<Either<Failure, List<DataClaim>>> call() async {
    return await claimRepositories.getAllClaim();
  }
}
