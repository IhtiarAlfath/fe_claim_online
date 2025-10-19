import 'package:claim_online/core/success/success.dart';
import 'package:claim_online/features/authentication/domain/entities/data_register.dart';
import 'package:dartz/dartz.dart';
import 'package:claim_online/core/error/failure.dart';
import 'package:claim_online/features/authentication/domain/repositories/authentication_repositories.dart';

class Register {
  AuthenticationRepositories authenticationRepositories;

  Register({required this.authenticationRepositories});

  Future<Either<Failure, Success>> call(DataRegister dataRegister) async {
    return authenticationRepositories.register(dataRegister);
  }
}
