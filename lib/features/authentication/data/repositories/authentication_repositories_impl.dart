import 'package:claim_online/features/authentication/domain/entities/data_register.dart';
import 'package:dartz/dartz.dart';
import 'package:claim_online/core/error/exception.dart';
import 'package:claim_online/core/error/failure.dart';
import 'package:claim_online/core/services/network_services.dart';
import 'package:claim_online/core/success/success.dart';
import 'package:claim_online/features/authentication/data/datasources/authentication_datasource_remote.dart';
import 'package:claim_online/features/authentication/domain/entities/data_login.dart';
import 'package:claim_online/features/authentication/domain/entities/data_user_token.dart';
import 'package:claim_online/features/authentication/domain/repositories/authentication_repositories.dart';

class AuthenticationRepositoriesImpl extends AuthenticationRepositories {
  final AuthenticationDatasourceRemote authenticationDatasourceRemote;
  final NetworkServices networkServices;

  AuthenticationRepositoriesImpl({
    required this.authenticationDatasourceRemote,
    required this.networkServices,
  });

  @override
  Future<Either<Failure, DataUserToken>> login(DataLogin dataLogin) async {
    try {
      bool isConnected = true;
      isConnected = await networkServices.isConnected();
      if (isConnected == false) {
        return const Left(ConnectionFailure(message: 'no internet connection'));
      }
      return right(await authenticationDatasourceRemote.login(dataLogin));
    } on ServerException catch (e) {
      return Left(GeneralFailure(message: e.message));
    } catch (e) {
      return const Left(GeneralFailure(message: "Failed Login"));
    }
  }

  @override
  Future<Either<Failure, Success>> register(DataRegister dataRegister) async {
    try {
      bool isConnected = true;
      isConnected = await networkServices.isConnected();
      if (isConnected == false) {
        return const Left(ConnectionFailure(message: 'no internet connection'));
      }
      return right(await authenticationDatasourceRemote.register(dataRegister));
    } on ServerException catch (e) {
      return Left(
          GeneralFailure(message: 'Something went wrong: ${e.message}'));
    } catch (e) {
      return const Left(GeneralFailure(message: "Failed Register"));
    }
  }
}
