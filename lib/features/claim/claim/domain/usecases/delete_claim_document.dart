import 'package:claim_online/core/success/success.dart';
import 'package:claim_online/features/claim/claim/domain/repositories/claim_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';

class DeleteClaimDocument {
  ClaimRepositories claimRepositories;

  DeleteClaimDocument({required this.claimRepositories});

  Future<Either<Failure, Success>> call(int fileId) async {
    return await claimRepositories.deleteClaimDocument(fileId);
  }
}
