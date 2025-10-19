import 'package:claim_online/core/success/success.dart';
import 'package:claim_online/features/user/domain/entities/data_user.dart';
import 'package:claim_online/features/user/domain/entities/data_user_role.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class UserRepositories {
  Future<Either<Failure, List<DataUserRole>>> getAllUserRole();
  Future<Either<Failure, List<DataUser>>> getAllUser();
  Future<Either<Failure, Success>> updateUser(DataUser request);
}
