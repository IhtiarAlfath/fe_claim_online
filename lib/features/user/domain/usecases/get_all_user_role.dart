import 'package:claim_online/features/user/domain/entities/data_user_role.dart';
import 'package:claim_online/features/user/domain/repositories/user_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class GetAllUserRole {
  UserRepositories userRepositories;

  GetAllUserRole({required this.userRepositories});

  Future<Either<Failure, List<DataUserRole>>> call() async {
    return await userRepositories.getAllUserRole();
  }
}
