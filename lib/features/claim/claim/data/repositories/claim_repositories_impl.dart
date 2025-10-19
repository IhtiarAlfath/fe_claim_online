import 'package:claim_online/core/success/success.dart';
import 'package:claim_online/features/claim/claim/domain/entities/data_claim.dart';
import 'package:claim_online/features/claim/claim/domain/entities/data_claim_file_request.dart';
import 'package:claim_online/features/claim/claim/domain/entities/data_claim_request.dart';
import 'package:claim_online/features/claim/claim/domain/entities/data_claim_update_request.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/services/network_services.dart';
import '../../domain/repositories/claim_repositories.dart';
import '../datasources/claim_datasource_remote.dart';

class ClaimRepositoriesImpl extends ClaimRepositories {
  final NetworkServices networkServices;
  final ClaimDatasourceRemote claimDatasourceRemote;

  ClaimRepositoriesImpl({
    required this.networkServices,
    required this.claimDatasourceRemote,
  });

  @override
  Future<Either<Failure, List<DataClaim>>> getAllClaim() async {
    try {
      bool isConnected = true;
      isConnected = await networkServices.isConnected();
      if (isConnected == false) {
        return const Left(ConnectionFailure(message: 'no internet connection'));
      }
      return right(await claimDatasourceRemote.getAllClaim());
    } catch (e) {
      return const Left(
          GeneralFailure(message: "Failed Get claim by user id"));
    }
  }
  Future<Either<Failure, List<DataClaim>>> getClaimByUserId() async {
    try {
      bool isConnected = true;
      isConnected = await networkServices.isConnected();
      if (isConnected == false) {
        return const Left(ConnectionFailure(message: 'no internet connection'));
      }
      return right(await claimDatasourceRemote.getClaimByUserId());
    } catch (e) {
      return const Left(
          GeneralFailure(message: "Failed Get claim by user id"));
    }
  }

  @override
  Future<Either<Failure, DataClaim>> getClaimByClaimId(int claimId) async {
    try {
      bool isConnected = true;
      isConnected = await networkServices.isConnected();
      if (isConnected == false) {
        return const Left(ConnectionFailure(message: 'no internet connection'));
      }
      return right(await claimDatasourceRemote.getClaimByClaimId(claimId));
    } catch (e) {
      return const Left(
          GeneralFailure(message: "Failed Get claim by id"));
    }
  }

  @override
  Future<Either<Failure, Success>> addClaim(DataClaimRequest request) async {
    try {
      bool isConnected = true;
      isConnected = await networkServices.isConnected();
      if (isConnected == false) {
        return const Left(ConnectionFailure(message: 'no internet connection'));
      }
      return right(await claimDatasourceRemote.addClaim(request));
    } catch (e) {
      return const Left(
          GeneralFailure(message: "Failed add claim"));
    }
  }

  @override
  Future<Either<Failure, Success>> updateClaim(DataClaimUpdateRequest request) async {
    try {
      bool isConnected = true;
      isConnected = await networkServices.isConnected();
      if (isConnected == false) {
        return const Left(ConnectionFailure(message: 'no internet connection'));
      }
      return right(await claimDatasourceRemote.updateClaim(request));
    } catch (e) {
      return const Left(
          GeneralFailure(message: "Failed update claim"));
    }
  }

  @override
  Future<Either<Failure, Success>> updateClaimStatus(int claimId, int statusId) async {
    try {
      bool isConnected = true;
      isConnected = await networkServices.isConnected();
      if (isConnected == false) {
        return const Left(ConnectionFailure(message: 'no internet connection'));
      }
      return right(await claimDatasourceRemote.updateClaimStatus(claimId, statusId));
    } catch (e) {
      return const Left(
          GeneralFailure(message: "Failed update status"));
    }
  }

  @override
  Future<Either<Failure, Success>> addClaimDocument(int claimId, List<DataClaimFileRequest> request) async {
    try {
      bool isConnected = true;
      isConnected = await networkServices.isConnected();
      if (isConnected == false) {
        return const Left(ConnectionFailure(message: 'no internet connection'));
      }
      return right(await claimDatasourceRemote.addClaimDocument(claimId, request));
    } catch (e) {
      return const Left(
          GeneralFailure(message: "Failed add claim document"));
    }
  }

  
  @override
  Future<Either<Failure, Success>> deleteClaimDocument(int fileId) async {
    try {
      bool isConnected = true;
      isConnected = await networkServices.isConnected();
      if (isConnected == false) {
        return const Left(ConnectionFailure(message: 'no internet connection'));
      }
      return right(await claimDatasourceRemote.deleteClaimDocument(fileId));
    } catch (e) {
      return const Left(
          GeneralFailure(message: "Failed Get claim by id"));
    }
  }
}
