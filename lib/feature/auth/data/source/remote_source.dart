// implement the AUTh abstarct class, so all future in it is added
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zeeh_mobile/core/api/api_endpoints.dart';
import 'package:zeeh_mobile/core/network_request/network_request.dart';
import 'package:zeeh_mobile/core/network_retry/network_retry.dart';
import 'package:zeeh_mobile/feature/auth/model/auth/authenticated_user.dart';
import 'package:zeeh_mobile/feature/auth/model/auth/log_in_item.dart';
import 'package:zeeh_mobile/feature/auth/model/auth/user.dart';
import 'package:zeeh_mobile/feature/auth/model/response_model.dart';
import 'package:zeeh_mobile/services/auth_manager/authmanager.dart';

abstract class AuthRemoteDataSource {
  // Auth
  Future<User> register({required RegisterItem registerItem});
  Future<User> login(String email, String pin);
  Future<AuthenticatedUser> accountVerification(String code);
  Future<ResponseModel> resendVerificationCode(String email);
  Future<ResponseModel> checkAccount(String email);

  // Pin
  Future<AuthenticatedUser> createPin(String pin, {String? token});
  Future<ResponseModel> resetPin(String pin, String accessToken);
  Future<ResponseModel> forgotPin(String email);
  Future<ResponseModel> resendForgotPin(String email);

  Future<ResponseModel> enableBiometric(bool status);

  Future<ResponseModel> biometricLogin(String token);

  // Code
  Future<ResponseModel> verifyCode(String code);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // call the two classes needed, the network request for post,get etc
  final NetworkRequest networkRequest;
  // call the two classes needed, the network retry for retrying failed API call
  final NetworkRetry networkRetry;

//  constructor to to add that the two is requried in the class
  AuthRemoteDataSourceImpl({
    required this.networkRequest,
    required this.networkRetry,
  });

  // Auth Remote Source called from the abstract class, first is to setup the abstract class

  // Auth, Pin and Code APIs

  //
  @override
  Future<User> register({required RegisterItem registerItem}) async {
    String url = Endpoint.register; //The API URL CALL

    final body = {
      "first_name": registerItem.firstName,
      "last_name": registerItem.lastName,
      "email": registerItem.email,
      "phone_num": registerItem.phoneNumber,
      "fcm": registerItem.fcm,
    };

    final response = await networkRetry.networkRetry(
      () => networkRequest.post(
        url,
        body: body,
      ),
    );

    debugPrint(response.body);

    final data = await json.decode(response.body);

    if (response.statusCode == 200) {
      try {
        final User user = User.fromJson(data["data"]);

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

  @override
  Future<User> login(String email, String pin) async {
    String url = Endpoint.login; //The API URL CALL

    final body = {
      "email": email,
      "pin": pin,
    };

    final response = await networkRetry.networkRetry(
      () => networkRequest.post(
        url,
        body: body,
      ),
    );

    debugPrint(response.body);

    final data = await json.decode(response.body);

    if (response.statusCode == 200) {
      try {
        final User user = User.fromJson(data["data"]);

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

  @override
  Future<AuthenticatedUser> accountVerification(String code) async {
    String url = Endpoint.accountVerification; //The API URL CALL

    final String accessToken = AuthManager.instance.user?.token ?? '';

    final body = {
      "code": code,
    };

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
        final AuthenticatedUser authUser =
            AuthenticatedUser.fromJson(data['data']);

        return authUser;
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
  Future<ResponseModel> resendVerificationCode(String email) async {
    String url = Endpoint.resendVerificationCode; //The API URL CALL

    final body = {
      "email": email,
    };

    final String accessToken = AuthManager.instance.user?.token ?? '';

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
  Future<ResponseModel> checkAccount(String email) async {
    String url = Endpoint.checkAccount; //The API URL CALL

    final body = {
      "email": email,
    };

    final response = await networkRetry.networkRetry(
      () => networkRequest.post(
        url,
        body: body,
      ),
    );

    debugPrint(response.body);

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

  ////////////////////////////////////////////////

  // Pin

  @override
  Future<AuthenticatedUser> createPin(String pin, {String? token}) async {
    String url = Endpoint.pinCreate; //The API URL CALL

    String accessToken = token != "" || token != "1"
        ? token.toString()
        : AuthManager.instance.user?.token ?? "";

    debugPrint("token: $token");
    debugPrint("accessToken: ${AuthManager.instance.user?.token}");

    debugPrint(accessToken);

    final body = {
      "pin": pin,
    };

    final response = await networkRetry.networkRetry(
      () => networkRequest.post(
        url,
        body: body,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $accessToken",
        },
      ),
    );

    debugPrint(response.body);

    final data = await json.decode(response.body);

    if (response.statusCode == 200) {
      try {
        final AuthenticatedUser authenticatedUser =
            AuthenticatedUser.fromJson(data['data']["user"]);

        return authenticatedUser;
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
  Future<ResponseModel> resetPin(String pin, String accessToken) async {
    String url = Endpoint.pinReset; //The API URL CALL

    final body = {
      "pin": pin,
    };

    final response = await networkRetry.networkRetry(
      () => networkRequest.patch(
        url,
        body: body,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $accessToken",
        },
      ),
    );

    debugPrint(response.body);

    final data = await json.decode(response.body);

    if (response.statusCode == 200) {
      try {
        final ResponseModel responseModel =
            ResponseModel.fromJson(data['data']);

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
  Future<ResponseModel> forgotPin(String email) async {
    String url = Endpoint.forgotPin; //The API URL CALL

    final body = {
      "email": email,
    };

    final response = await networkRetry.networkRetry(
      () => networkRequest.post(
        url,
        body: body,
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
  Future<ResponseModel> resendForgotPin(String email) async {
    String url = Endpoint.resendForgotPin; //The API URL CALL

    final String accessToken = AuthManager.instance.user?.token ?? '';

    final body = {
      "email": email,
    };

    final response = await networkRetry.networkRetry(
      () => networkRequest.post(
        url,
        body: body,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $accessToken",
        },
      ),
    );

    debugPrint(response.body);

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
  Future<ResponseModel> verifyCode(String code) async {
    String url = Endpoint.verifyCode; //The API URL CALL

    final body = {
      "code": code,
    };

    final response = await networkRetry.networkRetry(
      () => networkRequest.post(
        url,
        body: body,
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
  Future<ResponseModel> enableBiometric(bool status) async {
    String url = Endpoint.enableBiometrics; //The API URL CALL

    final String accessToken = AuthManager.instance.user?.accessToken ?? '';

    final body = {
      "biometrics": "$status",
    };

    debugPrint(body.toString());

    final response = await networkRetry.networkRetry(
      () => networkRequest.post(url, body: body, headers: {
        HttpHeaders.authorizationHeader: "Bearer $accessToken",
      }),
    );

    debugPrint(response.body);

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
  Future<ResponseModel> biometricLogin(String token) async {
    String url = Endpoint.bioLogin; //The API URL CALL

    final body = {
      "biometrics": token,
    };

    debugPrint(body.toString());

    final response = await networkRetry.networkRetry(
      () => networkRequest.post(
        url,
        body: body,
      ),
    );

    debugPrint(response.body);

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
