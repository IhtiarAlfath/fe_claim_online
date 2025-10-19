import 'package:claim_online/features/claim/claim_category/domain/entities/data_claim_category.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/services/network_services.dart';
import '../../domain/repositories/claim_category_repositories.dart';
import '../datasources/claim_category_datasource_remote.dart';

class ClaimCategoryRepositoriesImpl extends ClaimCategoryRepositories {
  final NetworkServices networkServices;
  final ClaimCategoryDatasourceRemote claimCategoryDatasourceRemote;

  ClaimCategoryRepositoriesImpl({
    required this.networkServices,
    required this.claimCategoryDatasourceRemote,
  });

  @override
  Future<Either<Failure, List<DataClaimCategory>>> getAllClaimCategory() async {
    try {
      bool isConnected = true;
      isConnected = await networkServices.isConnected();
      if (isConnected == false) {
        return const Left(ConnectionFailure(message: 'no internet connection'));
      }
      return right(await claimCategoryDatasourceRemote.getAllClaimCategory());
    } catch (e) {
      return const Left(
          GeneralFailure(message: "Failed Get all claim Category Data"));
    }
  }
}
