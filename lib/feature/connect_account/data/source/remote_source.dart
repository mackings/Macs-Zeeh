// implement the AUTh abstarct class, so all future in it is added
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:zeeh_mobile/core/api/api_endpoints.dart';
import 'package:zeeh_mobile/core/network_request/network_request.dart';
import 'package:zeeh_mobile/core/network_retry/network_retry.dart';
import 'package:zeeh_mobile/feature/auth/model/auth/facial_verify_model.dart';
import 'package:zeeh_mobile/feature/auth/model/response_model.dart';
import 'package:zeeh_mobile/services/auth_manager/authmanager.dart';

abstract class ConnectRemoteDataSource {
  // Auth
  Future<ResponseModel> bvnLookup(String bvn, bool isSignUp);
  Future<ResponseModel> facialVerify(String bvn, String image);
  Future<FacialVerify> uploadImage(String bvn, File file, bool isSignUp);

  // Banks
  Future<ResponseModel> unlinkBank(String bankId);
  Future<ResponseModel> bankDetails(String bankId);
  Future<ResponseModel> allbanks();
}

class ConnectRemoteDataSourceImpl implements ConnectRemoteDataSource {
  // call the two classes needed, the network request for post,get etc
  final NetworkRequest networkRequest;
  // call the two classes needed, the network retry for retrying failed API call
  final NetworkRetry networkRetry;

//  constructor to to add that the two is requried in the class
  ConnectRemoteDataSourceImpl({
    required this.networkRequest,
    required this.networkRetry,
  });

  // Auth Remote Source called from the abstract class, first is to setup the abstract class

  // Auth, Pin and Code APIs

  //
  @override
  Future<ResponseModel> bvnLookup(String bvn, bool isSignUp) async {
    String url = Endpoint.bvnLookup; //The API URL CALL

    final body = {
      "bvn": bvn,
    };

    final String accessToken = isSignUp == true
        ? AuthManager.instance.user?.token ?? ''
        : AuthManager.instance.user?.accessToken ?? '';

    debugPrint(accessToken);

    final response = await networkRetry.networkRetry(
      () => networkRequest.post(
        url,
        body: body,
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
  Future<ResponseModel> facialVerify(String bvn, String image) async {
    String url = Endpoint.register; //The API URL CALL

    final body = {
      "bvn": bvn,
      "image": image,
    };

    final String accessToken = AuthManager.instance.user?.token ?? '';

    final response = await networkRetry.networkRetry(
      () => networkRequest.post(url, body: body, headers: {
        HttpHeaders.authorizationHeader: "Bearer $accessToken",
      }),
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
  Future<FacialVerify> uploadImage(String bvn, File file, bool isSignUp) async {
    String url = Endpoint.facialVerify2;

    final String accessToken = isSignUp == true
        ? AuthManager.instance.user?.token ?? ''
        :
    
     AuthManager.instance.user?.accessToken ?? '';

    final request = http.MultipartRequest("POST", Uri.parse(url))
      ..headers.addAll({HttpHeaders.authorizationHeader: 'Bearer $accessToken'})
      ..fields["bvn"] = bvn
      ..files.add(
        await http.MultipartFile.fromPath(
          'image',
          file.path,
        ),
      );

    final streamedResponse = await request.send();

    final response = await http.Response.fromStream(streamedResponse);

    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      try {
        final FacialVerify facialVerify =
            FacialVerify.fromJson(data["data"]["bvn"]);

        return facialVerify;
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

  // Banks

  // Unlink Bank
  @override
  Future<ResponseModel> unlinkBank(String bankId) async {
    String url = '${Endpoint.unlinkBank}bankId'; //The API URL CALL

    final String accessToken = AuthManager.instance.user?.accessToken ?? '';

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

  // Bank Details
  @override
  Future<ResponseModel> bankDetails(String bankId) async {
    String url = '${Endpoint.bankDetail}bankId'; //The API URL CALL

    final String accessToken = AuthManager.instance.user?.accessToken ?? '';

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

  // Get All Banks
  @override
  Future<ResponseModel> allbanks() async {
    String url = Endpoint.allbanks; //The API URL CALL

    final String accessToken = AuthManager.instance.user?.accessToken ?? '';

    final response = await networkRetry.networkRetry(
      () => networkRequest.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $accessToken",
        },
      ),
    );

    print(response.body);

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
