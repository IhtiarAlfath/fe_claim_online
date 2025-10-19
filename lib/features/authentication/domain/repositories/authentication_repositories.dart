import 'package:claim_online/features/authentication/domain/entities/data_register.dart';
import 'package:dartz/dartz.dart';
import 'package:claim_online/core/error/failure.dart';
import 'package:claim_online/core/success/success.dart';
import 'package:claim_online/features/authentication/domain/entities/data_login.dart';
import 'package:claim_online/features/authentication/domain/entities/data_user_token.dart';

abstract class AuthenticationRepositories {
  Future<Either<Failure, DataUserToken>> login(DataLogin dataLogin);
  Future<Either<Failure, Success>> register(DataRegister dataRegister);

}
