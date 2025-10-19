import 'package:claim_online/features/user/domain/entities/data_user.dart';
import 'package:claim_online/features/user/domain/repositories/user_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class GetAllUser {
  UserRepositories userRepositories;

  GetAllUser({required this.userRepositories});

  Future<Either<Failure, List<DataUser>>> call() async {
    return await userRepositories.getAllUser();
  }
}
