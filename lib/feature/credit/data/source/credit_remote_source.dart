import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zeeh_mobile/core/api/api_endpoints.dart';
import 'package:zeeh_mobile/core/network_request/network_request.dart';
import 'package:zeeh_mobile/core/network_retry/network_retry.dart';
import 'package:zeeh_mobile/feature/auth/model/response_model.dart';
import 'package:zeeh_mobile/feature/credit/model/credit_report_model.dart';
import 'package:zeeh_mobile/services/auth_manager/authmanager.dart';

abstract class CreditRemoteSource {
  Future<ResponseModel> getCreditScore();
  Future<CreditReportModel> getCreditReport();
}

class CreditRemoteSourceImpl implements CreditRemoteSource {
  final NetworkRequest networkRequest;
  final NetworkRetry networkRetry;

  CreditRemoteSourceImpl({
    required this.networkRequest,
    required this.networkRetry,
  });

  @override
  Future<ResponseModel> getCreditScore() async {
    String url = Endpoint.creditScore;

    final String accessToken = AuthManager.instance.user?.accessToken ?? '';

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
  Future<CreditReportModel> getCreditReport() async {
    String url = Endpoint.creditReport;

    final String accessToken = AuthManager.instance.user?.token ?? '';

    final response = await networkRetry.networkRetry(
      () => networkRequest.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $accessToken",
        },
      ),
    );

    final data = await json.decode(response.body);

    if (response.statusCode == 200) {
      try {
        final CreditReportModel creditReportModel =
            CreditReportModel.fromJson(data['data']['report']);

        return creditReportModel;
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
