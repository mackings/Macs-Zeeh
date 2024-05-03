import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:zeeh_mobile/core/api/api_endpoints.dart';
import 'package:zeeh_mobile/core/network_request/network_request.dart';
import 'package:zeeh_mobile/core/network_retry/network_retry.dart';
import 'package:zeeh_mobile/feature/auth/model/response_model.dart';
import 'package:zeeh_mobile/feature/linked_accounts/model/linked_account_model.dart';
import 'package:zeeh_mobile/services/auth_manager/authmanager.dart';

abstract class LinkedAccountRemoteDataSource {
  // Linked Account
  Future<ResponseModel> unlinkBank(String bankId);

  Future<ResponseModel> bankDetails(String bankId);

  Future<LinkedAccountModel> allBanks();
}

class LinkedAccountRemoteDataSourceImpl
    implements LinkedAccountRemoteDataSource {
  // call the two classes needed, the network request for post,get etc
  final NetworkRequest networkRequest;
  // call the two classes needed, the network retry for retrying failed API call
  final NetworkRetry networkRetry;

//  constructor to to add that the two is requried in the class
  LinkedAccountRemoteDataSourceImpl({
    required this.networkRequest,
    required this.networkRetry,
  });

  // Auth Remote Source called from the abstract class, first is to setup the abstract class

  // Unlink Bank, Bank Details and All Banka APIs

  //
  @override
  Future<ResponseModel> unlinkBank(String bankId) async {
    String url = "${Endpoint.unlinkBank}$bankId"; //The API URL CALL

    String accessToken = AuthManager.instance.user?.token ?? '';

    final response = await networkRetry.networkRetry(
      () => networkRequest.delete(
        url,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $accessToken",
        },
      ),
    );

    final data = await json.decode(response.body);

    if (response.statusCode == 200) {
      try {
        final ResponseModel responseModel = ResponseModel.fromJson(data);

        return responseModel;
      } on Exception catch (_) {
        rethrow;
      }
    } else {
      final ResponseModel responseModel = ResponseModel.fromJson(data);

      try {
        if (responseModel.status == false) {
          throw Exception(data['message']);
        } else {
          final errorMessage = data['message'];
          throw Exception(errorMessage);
        }
      } on Exception catch (_) {
        rethrow;
      }
    }
  }

  @override
  Future<ResponseModel> bankDetails(String bankId) async {
    String url = "${Endpoint.bankDetail}$bankId"; //The API URL CALL

    final response = await networkRetry.networkRetry(
      () => networkRequest.post(
        url,
      ),
    );

    final data = await json.decode(response.body);

    if (response.statusCode == 200) {
      try {
        final ResponseModel responseModel = ResponseModel.fromJson(data);

        return responseModel;
      } on Exception catch (_) {
        rethrow;
      }
    } else {
      final ResponseModel responseModel = ResponseModel.fromJson(data);

      try {
        if (responseModel.status == false) {
          throw Exception(data['message']);
        } else {
          final errorMessage = data['message'];
          throw Exception(errorMessage);
        }
      } on Exception catch (_) {
        rethrow;
      }
    }
  }

  @override
  Future<LinkedAccountModel> allBanks() async {
    String url = Endpoint.allbanks; //The API URL CALL

    String accessToken = AuthManager.instance.user?.accessToken ?? '';

    final response = await networkRetry.networkRetry(
      () => networkRequest.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $accessToken",
        },
      ),
    );

    debugPrint(response.body);

    final data = await json.decode(response.body);

    if (response.statusCode == 200) {
      try {
        final LinkedAccountModel linkedAccount =
            LinkedAccountModel.fromJson(data["data"]);

        return linkedAccount;
      } on Exception catch (_) {
        rethrow;
      }
    } else {
      final ResponseModel responseModel = ResponseModel.fromJson(data);

      try {
        if (responseModel.status == false) {
          throw Exception(data['message']);
        } else {
          final errorMessage = data['message'];
          throw Exception(errorMessage);
        }
      } on Exception catch (_) {
        rethrow;
      }
    }
  }
}
