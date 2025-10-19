import 'package:claim_online/core/success/success.dart';
import 'package:claim_online/features/claim/claim/domain/entities/data_claim_file_request.dart';
import 'package:claim_online/features/claim/claim/domain/repositories/claim_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';

class AddClaimDocument {
  ClaimRepositories claimRepositories;

  AddClaimDocument({required this.claimRepositories});

  Future<Either<Failure, Success>> call(int claimId, List<DataClaimFileRequest> request) async {
    return await claimRepositories.addClaimDocument(claimId, request);
  }
}
