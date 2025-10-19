import 'package:claim_online/features/claim/claim_category/domain/entities/data_claim_category.dart';
import 'package:claim_online/features/claim/claim_category/domain/repositories/claim_category_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';

class GetAllClaimCategory {
  ClaimCategoryRepositories claimCategoryRepositories;

  GetAllClaimCategory({required this.claimCategoryRepositories});

  Future<Either<Failure, List<DataClaimCategory>>> call() async {
    return await claimCategoryRepositories.getAllClaimCategory();
  }
}
