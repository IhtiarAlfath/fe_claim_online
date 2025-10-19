import 'package:claim_online/features/claim/claim_status/domain/entities/data_claim_status.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/services/network_services.dart';
import '../../domain/repositories/claim_status_repositories.dart';
import '../datasources/claim_status_datasource_remote.dart';

class ClaimStatusRepositoriesImpl extends ClaimStatusRepositories {
  final NetworkServices networkServices;
  final ClaimStatusDatasourceRemote claimStatusDatasourceRemote;

  ClaimStatusRepositoriesImpl({
    required this.networkServices,
    required this.claimStatusDatasourceRemote,
  });

  @override
  Future<Either<Failure, List<DataClaimStatus>>> getAllClaimStatus() async {
    try {
      bool isConnected = true;
      isConnected = await networkServices.isConnected();
      if (isConnected == false) {
        return const Left(ConnectionFailure(message: 'no internet connection'));
      }
      return right(await claimStatusDatasourceRemote.getAllClaimStatus());
    } catch (e) {
      return const Left(
          GeneralFailure(message: "Failed Get all claim status Data"));
    }
  }
}
