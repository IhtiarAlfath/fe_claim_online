import 'package:claim_online/features/authentication/domain/entities/data_user_token.dart';
import 'package:dartz/dartz.dart';
import 'package:claim_online/core/error/failure.dart';
import 'package:claim_online/features/authentication/domain/entities/data_login.dart';
import 'package:claim_online/features/authentication/domain/repositories/authentication_repositories.dart';

class Login {
  AuthenticationRepositories authenticationRepositories;

  Login({required this.authenticationRepositories});

  Future<Either<Failure, DataUserToken>> call(DataLogin dataLogin) async {
    return authenticationRepositories.login(dataLogin);
  }
}
