import 'dart:convert';

import 'package:claim_online/core/success/success.dart';
import 'package:claim_online/core/utils/function.dart';
import 'package:claim_online/features/authentication/domain/entities/data_user_token.dart';
import 'package:claim_online/features/user/data/models/data_user_model.dart';
import 'package:claim_online/features/user/domain/entities/data_user.dart';
import 'package:claim_online/features/user/domain/entities/data_user_role.dart';
import 'package:http/http.dart' as http;
import 'package:claim_online/core/utils/auth_service.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/utils/constant.dart';
import '../models/data_user_role_model.dart';

abstract class UserDatasourceRemote {
  Future<List<DataUserRole>> getAllUserRole();
  Future<List<DataUser>> getAllUser();
  Future<Success> updateUser(DataUser request);
}

class UserDatasourceRemoteImpl extends UserDatasourceRemote {
  final http.Client client;

  UserDatasourceRemoteImpl({required this.client});

  @override
  Future<List<DataUser>> getAllUser() async {
    try {
      DataUserToken? userToken = await AuthService.getUser();
      if (userToken != null) {
        var response = await client.get(
          Uri.parse('$url$getAllUserPath'),
          headers: {
            "Content-Type": "application/json",
            "accept": "*/*",
            "Authorization": "Bearer ${userToken.token}",
          },
        );

        if (response.statusCode != 200) {
          return Future.error(
              ServerException(message: jsonDecode(response.body)['message']));
        }

        List data = jsonDecode(response.body)['data'];
        return data.map((e) => DataUserModel.fromJson(e)).toList();
      } else {
        return Future.error(
            const ServerException(message: 'Empty token please re-login'));
      }
    } catch (e) {
      ('========== $e');
      return Future.error(
          const ServerException(message: 'Something went wrong'));
    }
  }

  @override
  Future<List<DataUserRole>> getAllUserRole() async {
    try {
      DataUserToken? userToken = await AuthService.getUser();
      if (userToken != null) {
        var response = await client.get(
          Uri.parse('$url$getAllUserRolePath'),
          headers: {
            "Content-Type": "application/json",
            "accept": "*/*",
            "Authorization": "Bearer ${userToken.token}",
          },
        );

        if (response.statusCode != 200) {
          return Future.error(
              ServerException(message: jsonDecode(response.body)['message']));
        }

        List data = jsonDecode(response.body)['data'];
        return data.map((e) => DataUserRoleModel.fromJson(e)).toList();
      } else {
        return Future.error(
            const ServerException(message: 'Empty token please re-login'));
      }
    } catch (e) {
      ('========== $e');
      return Future.error(
          const ServerException(message: 'Something went wrong'));
    }
  }

  @override
  Future<Success> updateUser(DataUser request) async {
    try {
      DataUserToken? userToken = await AuthService.getUser();
      if (userToken != null) {
        var response = await client.put(Uri.parse('$url$updateUserPath'),
            headers: {
              "Content-Type": "application/json",
              "accept": "*/*",
              "Authorization": "Bearer ${userToken.token}",
            },
            body: jsonEncode(
              {
                "username": request.username,
                "email": request.email,
                "role_id": request.roleId,
                "user_id": request.userId,
              },
            ));
        print(jsonEncode(
          {
            "username": request.username,
            "email": request.email,
            "role_id": request.roleId,
            "user_id": request.userId,
          },
        ));
        print(response.body);

        if (response.statusCode != 200) {
          return Future.error(
              ServerException(message: jsonDecode(response.body)['message']));
        }

        return const GeneralSuccess(message: 'Success update claim status');
      } else {
        return Future.error(
            const ServerException(message: 'Empty key please re-login'));
      }
    } catch (e) {
      logInfo('========== update user$e');
      return Future.error(
          const ServerException(message: 'Something went wrong'));
    }
  }
}
