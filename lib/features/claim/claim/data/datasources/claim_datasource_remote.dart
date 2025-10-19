import 'dart:convert';

import 'package:claim_online/core/success/success.dart';
import 'package:claim_online/core/utils/function.dart';
import 'package:claim_online/features/authentication/domain/entities/data_user_token.dart';
import 'package:claim_online/features/claim/claim/data/models/data_claim_model.dart';
import 'package:claim_online/features/claim/claim/domain/entities/data_claim.dart';
import 'package:claim_online/features/claim/claim/domain/entities/data_claim_file_request.dart';
import 'package:claim_online/features/claim/claim/domain/entities/data_claim_request.dart';
import 'package:claim_online/features/claim/claim/domain/entities/data_claim_update_request.dart';
import 'package:http/http.dart' as http;
import 'package:claim_online/core/utils/auth_service.dart';

import '../../../../../core/error/exception.dart';
import '../../../../../core/utils/constant.dart';

abstract class ClaimDatasourceRemote {
  Future<List<DataClaim>> getAllClaim();
  Future<List<DataClaim>> getClaimByUserId();
  Future<DataClaim> getClaimByClaimId(int claimId);
  Future<Success> addClaim(DataClaimRequest request);
  Future<Success> updateClaim(DataClaimUpdateRequest request);
  Future<Success> updateClaimStatus(int claimId, int statusId);
  Future<Success> addClaimDocument(
      int claimId, List<DataClaimFileRequest> request);
  Future<Success> deleteClaimDocument(int claimId);
}

class ClaimDatasourceRemoteImpl extends ClaimDatasourceRemote {
  final http.Client client;

  ClaimDatasourceRemoteImpl({required this.client});

  @override
  Future<List<DataClaim>> getAllClaim() async {
    try {
      DataUserToken? userToken = await AuthService.getUser();
      if (userToken != null) {
        var response = await client.get(
          Uri.parse('$url$getAllClaimPath'),
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
        return data.map((e) => DataClaimModel.fromJson(e)).toList();
      } else {
        return Future.error(
            const ServerException(message: 'Empty token please re-login'));
      }
    } catch (e) {
      return Future.error(
          const ServerException(message: 'Something went wrong'));
    }
  }

  @override
  Future<List<DataClaim>> getClaimByUserId() async {
    try {
      DataUserToken? userToken = await AuthService.getUser();
      if (userToken != null) {
        var response = await client.get(
          Uri.parse('$url$getClaimByUserIDPath/${userToken.userId}'),
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
        return data.map((e) => DataClaimModel.fromJson(e)).toList();
      } else {
        return Future.error(
            const ServerException(message: 'Empty token please re-login'));
      }
    } catch (e) {
      return Future.error(
          const ServerException(message: 'Something went wrong'));
    }
  }

  @override
  Future<DataClaim> getClaimByClaimId(int claimId) async {
    try {
      DataUserToken? userToken = await AuthService.getUser();
      if (userToken != null) {
        var response = await client.get(
          Uri.parse('$url$getClaimByClaimIDPath/$claimId'),
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

        return DataClaimModel.fromJson(jsonDecode(response.body)['data']);
      } else {
        return Future.error(
            const ServerException(message: 'Empty token please re-login'));
      }
    } catch (e) {
      logInfo('========================= $e');
      return Future.error(
          const ServerException(message: 'Something went wrong'));
    }
  }

  @override
  Future<Success> addClaim(DataClaimRequest request) async {
    try {
      DataUserToken? userToken = await AuthService.getUser();
      if (userToken != null) {
        List<Object> listFile = [];
        for (int i = 0; i < request.files.length; i++) {
          listFile.add({
            "file_name": request.files[i].fileName,
            "file_type": request.files[i].fileType,
            "file_data": request.files[i].fileData,
          });
        }

        var response = await client.post(Uri.parse('$url$addClaimPath'),
            headers: {
              "Content-Type": "application/json",
              "accept": "*/*",
              "Authorization": "Bearer ${userToken.token}",
            },
            body: jsonEncode(
              {
                "user_id": request.userId,
                "claim_desc": request.claimDesc,
                "category_id": request.categoryId,
                "files": listFile,
              },
            ));

        if (response.statusCode != 200) {
          return Future.error(
              ServerException(message: jsonDecode(response.body)['message']));
        } 
        

        return GeneralSuccess(message: jsonDecode(response.body)['message']);
      } else {
        return Future.error(
            const ServerException(message: 'Empty key please re-login'));
      }
    } catch (e) {
      logInfo('========== $e');
      return Future.error(
          const ServerException(message: 'Something went wrong'));
    }
  }

  @override
  Future<Success> updateClaim(DataClaimUpdateRequest request) async {
    try {
      DataUserToken? userToken = await AuthService.getUser();
      if (userToken != null) {
        var response = await client.put(Uri.parse('$url$updateClaimPath'),
            headers: {
              "Content-Type": "application/json",
              "accept": "*/*",
              "Authorization": "Bearer ${userToken.token}",
            },
            body: jsonEncode(
              {
                "user_id": request.userId,
                "claim_desc": request.claimDesc,
                "category_id": int.parse(request.categoryId),
                "claim_id": request.claimId,
              },
            ));

        if (response.statusCode != 200) {
          return Future.error(
              ServerException(message: jsonDecode(response.body)['message']));
        }

        return const GeneralSuccess(message: 'Success update claim');
      } else {
        return Future.error(
            const ServerException(message: 'Empty key please re-login'));
      }
    } catch (e) {
      logInfo('========== $e');
      return Future.error(
          const ServerException(message: 'Something went wrong'));
    }
  }

  @override
  Future<Success> updateClaimStatus(int claimId, int statusId) async {
    try {
      DataUserToken? userToken = await AuthService.getUser();
      if (userToken != null) {
        var response = await client.put(Uri.parse('$url$updateClaimStatusPath'),
            headers: {
              "Content-Type": "application/json",
              "accept": "*/*",
              "Authorization": "Bearer ${userToken.token}",
            },
            body: jsonEncode(
              {
                "claim_id": claimId,
                "status_id": statusId,
              },
            ));

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
      logInfo('========== claim status datas$e');
      return Future.error(
          const ServerException(message: 'Something went wrong'));
    }
  }

  @override
  Future<Success> addClaimDocument(
      int claimId, List<DataClaimFileRequest> request) async {
    try {
      DataUserToken? userToken = await AuthService.getUser();
      if (userToken != null) {
        var listFile = [];
        for (int i = 0; i < request.length; i++) {
          listFile.add({
            "file_name": request[i].fileName,
            "file_type": request[i].fileType,
            "file_data": request[i].fileData,
          });
        }
        logInfo(jsonEncode(listFile));
        var response =
            await client.post(Uri.parse('$url$addClaimDocumentPath/$claimId'),
                headers: {
                  "Content-Type": "application/json",
                  "accept": "*/*",
                  "Authorization": "Bearer ${userToken.token}",
                },
                body: jsonEncode(listFile));

        if (response.statusCode != 200) {
          return Future.error(
              ServerException(message: jsonDecode(response.body)['message']));
        }

        return const GeneralSuccess(message: "Success add document");
      } else {
        return Future.error(
            const ServerException(message: 'Empty key please re-login'));
      }
    } catch (e) {
      logInfo('========== $e');
      return Future.error(
          const ServerException(message: 'Something went wrong'));
    }
  }

  @override
  Future<Success> deleteClaimDocument(int fileId) async {
    try {
      DataUserToken? userToken = await AuthService.getUser();
      if (userToken != null) {
        var response = await client.post(
          Uri.parse('$url$deleteClaimDocumentPath/$fileId'),
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

        return const GeneralSuccess(message: "Success delete document");
      } else {
        return Future.error(
            const ServerException(message: 'Empty key please re-login'));
      }
    } catch (e) {
      logInfo('========== $e');
      return Future.error(
          const ServerException(message: 'Something went wrong'));
    }
  }
}
