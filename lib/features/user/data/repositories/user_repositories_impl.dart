import 'package:claim_online/core/success/success.dart';
import 'package:claim_online/features/user/domain/entities/data_user.dart';
import 'package:claim_online/features/user/domain/entities/data_user_role.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/network_services.dart';
import '../../domain/repositories/user_repositories.dart';
import '../datasources/user_datasource_remote.dart';

class UserRepositoriesImpl extends UserRepositories {
  final NetworkServices networkServices;
  final UserDatasourceRemote userDatasourceRemote;

  UserRepositoriesImpl({
    required this.networkServices,
    required this.userDatasourceRemote,
  });

  @override
  Future<Either<Failure, List<DataUserRole>>> getAllUserRole() async {
    try {
      bool isConnected = true;
      isConnected = await networkServices.isConnected();
      if (isConnected == false) {
        return const Left(ConnectionFailure(message: 'no internet connection'));
      }
      return right(await userDatasourceRemote.getAllUserRole());
    } catch (e) {
      return const Left(
          GeneralFailure(message: "Failed Get all User Role Data"));
    }
  }
  @override
  Future<Either<Failure, List<DataUser>>> getAllUser() async {
    try {
      bool isConnected = true;
      isConnected = await networkServices.isConnected();
      if (isConnected == false) {
        return const Left(ConnectionFailure(message: 'no internet connection'));
      }
      return right(await userDatasourceRemote.getAllUser());
    } catch (e) {
      return const Left(
          GeneralFailure(message: "Failed Get all User  Data"));
    }
  }
  @override
  Future<Either<Failure, Success>> updateUser(DataUser request) async {
    try {
      bool isConnected = true;
      isConnected = await networkServices.isConnected();
      if (isConnected == false) {
        return const Left(ConnectionFailure(message: 'no internet connection'));
      }
      return right(await userDatasourceRemote.updateUser(request));
    } catch (e) {
      return const Left(
          GeneralFailure(message: "Failed Get all User  Data"));
    }
  }
}
