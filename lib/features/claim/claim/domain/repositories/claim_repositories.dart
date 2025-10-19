import 'package:claim_online/core/success/success.dart';
import 'package:claim_online/features/claim/claim/domain/entities/data_claim.dart';
import 'package:claim_online/features/claim/claim/domain/entities/data_claim_file_request.dart';
import 'package:claim_online/features/claim/claim/domain/entities/data_claim_request.dart';
import 'package:claim_online/features/claim/claim/domain/entities/data_claim_update_request.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';

abstract class ClaimRepositories {
  Future<Either<Failure, List<DataClaim>>> getAllClaim();
  Future<Either<Failure, List<DataClaim>>> getClaimByUserId();
  Future<Either<Failure, DataClaim>> getClaimByClaimId(int claimId);
  Future<Either<Failure, Success>> addClaimDocument(int claimId, List<DataClaimFileRequest> request);
  Future<Either<Failure, Success>> addClaim(DataClaimRequest request);
  Future<Either<Failure, Success>> updateClaim(DataClaimUpdateRequest request);
  Future<Either<Failure, Success>> updateClaimStatus(int claimId, int statusId);
    Future<Either<Failure, Success>> deleteClaimDocument(int fileId);
}
