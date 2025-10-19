import 'dart:convert';

import 'package:claim_online/features/authentication/domain/entities/data_user_token.dart';
import 'package:claim_online/features/claim/claim_status/domain/entities/data_claim_status.dart';
import 'package:http/http.dart' as http;
import 'package:claim_online/core/utils/auth_service.dart';

import '../../../../../core/error/exception.dart';
import '../../../../../core/utils/constant.dart';
import '../models/data_claim_status_model.dart';

abstract class ClaimStatusDatasourceRemote {
  Future<List<DataClaimStatus>> getAllClaimStatus();
}

class ClaimStatusDatasourceRemoteImpl extends ClaimStatusDatasourceRemote {
  final http.Client client;

  ClaimStatusDatasourceRemoteImpl({required this.client});

  @override
  Future<List<DataClaimStatus>> getAllClaimStatus() async {
    try {
      DataUserToken? userToken = await AuthService.getUser();
      if (userToken != null) {
        var response = await client.get(
          Uri.parse('$url$getAllClaimStatusPath'),
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
        return data.map((e) => DataClaimStatusModel.fromJson(e)).toList();
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
}
