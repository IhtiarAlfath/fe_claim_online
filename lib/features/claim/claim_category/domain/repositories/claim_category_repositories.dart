import 'package:claim_online/features/claim/claim_category/domain/entities/data_claim_category.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';

abstract class ClaimCategoryRepositories {
  Future<Either<Failure, List<DataClaimCategory>>> getAllClaimCategory();
}
