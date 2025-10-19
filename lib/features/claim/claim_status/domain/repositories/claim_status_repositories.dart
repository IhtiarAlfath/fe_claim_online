import 'package:claim_online/features/claim/claim_status/domain/entities/data_claim_status.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';

abstract class ClaimStatusRepositories {
  Future<Either<Failure, List<DataClaimStatus>>> getAllClaimStatus();
}
