import 'package:claim_online/core/success/success.dart';
import 'package:claim_online/features/user/domain/entities/data_user.dart';
import 'package:claim_online/features/user/domain/repositories/user_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class UpdateUser {
  UserRepositories userRepositories;

  UpdateUser({required this.userRepositories});

  Future<Either<Failure, Success>> call(DataUser request) async {
    return await userRepositories.updateUser(request);
  }
}
