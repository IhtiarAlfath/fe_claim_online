import 'dart:convert';

import 'package:claim_online/core/error/exception.dart';
import 'package:claim_online/core/success/success.dart';
import 'package:claim_online/core/utils/constant.dart';
import 'package:claim_online/core/utils/function.dart';
import 'package:claim_online/features/authentication/data/models/data_user_token_model.dart';
import 'package:claim_online/features/authentication/domain/entities/data_login.dart';
import 'package:claim_online/features/authentication/domain/entities/data_register.dart';
import 'package:http/http.dart' as http;
import 'package:claim_online/features/authentication/domain/entities/data_user_token.dart';

abstract class AuthenticationDatasourceRemote {
  Future<DataUserToken> login(DataLogin dataLogin);
  Future<Success> register(DataRegister dataRegister);
}

class AuthenticationDatasourceRemoteImpl
    extends AuthenticationDatasourceRemote {
  final http.Client client;

  AuthenticationDatasourceRemoteImpl({required this.client});

  @override
  Future<DataUserToken> login(DataLogin dataLogin) async {
    try {
      var response = await client.post(Uri.parse('$url$loginPath'),
          headers: {
            "Content-Type": "application/json",
            "accept": "*/*",
          },
          body: jsonEncode({
            "email": dataLogin.email,
            "password": dataLogin.password,
          }));

      if (response.statusCode != 200) {
        if (response.statusCode == 401) {
          return Future.error(
              const ServerException(message: 'Invalid Email or Password'));
        }
        return Future.error(
            ServerException(message: jsonDecode(response.body)['message']));
      }

      return DataUserTokenModel.fromJson(jsonDecode(response.body)['data']);
    } catch (e) {
      logInfo('========== $e');
      return Future.error(
          const ServerException(message: 'Something went wrong'));
    }
  }

  @override
  Future<Success> register(DataRegister dataRegister) async {
    try {
      var response = await client.post(Uri.parse('$url$registerpath'),
          headers: {
            "Content-Type": "application/json",
            "accept": "*/*",
          },
          body: jsonEncode({
            "username": dataRegister.email,
            "email": dataRegister.email,
            "password": dataRegister.password,
            "role_id": dataRegister.roleId,
          }));

      if (response.statusCode != 200) {
        return Future.error(
            ServerException(message: 'Error: ${jsonDecode(response.body)['message']}'));
      }

      return GeneralSuccess(message: jsonDecode(response.body)['message']);
    } catch (e) {
      logInfo('========== $e');
      return Future.error(
          const ServerException(message: 'Something went wrong'));
    }
  }
}
