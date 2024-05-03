import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zeeh_mobile/core/api/api_endpoints.dart';
import 'package:zeeh_mobile/core/network_request/network_request.dart';
import 'package:zeeh_mobile/core/network_retry/network_retry.dart';
import 'package:zeeh_mobile/feature/auth/model/response_model.dart';
import 'package:zeeh_mobile/feature/profile/model/user_details.dart';
import 'package:zeeh_mobile/services/auth_manager/authmanager.dart';

abstract class ProfileRemoteDataSource {
  // Auth
  Future<UserDetails> userDetails();
  Future<ResponseModel> deleteAccount();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  // call the two classes needed, the network request for post,get etc
  final NetworkRequest networkRequest;
  // call the two classes needed, the network retry for retrying failed API call
  final NetworkRetry networkRetry;

//  constructor to to add that the two is requried in the class
  ProfileRemoteDataSourceImpl({
    required this.networkRequest,
    required this.networkRetry,
  });

  // Auth Remote Source called from the abstract class, first is to setup the abstract class

  // Auth, Pin and Code APIs

  //
  @override
  Future<UserDetails> userDetails() async {
    String url = Endpoint.userDetails; //The API URL CALL

    final String accessToken = AuthManager.instance.user?.accessToken ?? '';

    debugPrint(accessToken);

    final response = await networkRetry.networkRetry(
      () => networkRequest.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $accessToken",
        },
      ),
    );

    debugPrint(response.body.toString());

    final data = await json.decode(response.body);

    if (response.statusCode == 200) {
      try {
        final UserDetails user = UserDetails.fromJson(data["data"]);

        return user;
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

  // Delete API
  @override
  Future<ResponseModel> deleteAccount() async {
    String url = Endpoint.deleteAccount;

    final String accessToken = AuthManager.instance.user?.accessToken ?? '';

    final response = await networkRetry.networkRetry(
      () => networkRequest.delete(
        url,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $accessToken",
        },
      ),
    );

    debugPrint(response.body.toString());

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
}
