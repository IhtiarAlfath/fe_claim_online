import 'package:claim_online/features/claim/claim_status/domain/entities/data_claim_status.dart';
import 'package:claim_online/features/claim/claim_status/domain/repositories/claim_status_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';

class GetAllClaimStatus {
  ClaimStatusRepositories claimStatusRepositories;

  GetAllClaimStatus({required this.claimStatusRepositories});

  Future<Either<Failure, List<DataClaimStatus>>> call() async {
    return await claimStatusRepositories.getAllClaimStatus();
  }
}
