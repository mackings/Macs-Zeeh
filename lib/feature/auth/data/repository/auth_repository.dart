import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zeeh_mobile/constants/error_strings.dart';
import 'package:zeeh_mobile/core/failures/failures.dart';
import 'package:zeeh_mobile/core/network_info/network_info.dart';
import 'package:zeeh_mobile/core/runner/service.dart';
import 'package:zeeh_mobile/feature/auth/data/source/remote_source.dart';
import 'package:zeeh_mobile/feature/auth/model/auth/authenticated_user.dart';
import 'package:zeeh_mobile/feature/auth/model/auth/log_in_item.dart';
import 'package:zeeh_mobile/feature/auth/model/auth/user.dart';
import 'package:zeeh_mobile/feature/auth/model/response_model.dart';
import 'package:zeeh_mobile/feature/provider.dart';
import 'package:zeeh_mobile/services/auth_manager/authmanager.dart';
import 'package:shared_preferences/shared_preferences.dart';


abstract class AuthRepository {
  // Auth
  Future<Either<Failure, User>> register({required RegisterItem registerItem});
  Future<Either<Failure, User>> login(String email, String pin);
  Future<Either<Failure, AuthenticatedUser>> accountVerification(String code);
  Future<Either<Failure, ResponseModel>> resendVerificationCode(String email);
  Future<Either<Failure, ResponseModel>> checkAccount(String email);

  // Pin
  Future<Either<Failure, AuthenticatedUser>> createPin(String pin, {String ? token});
  Future<Either<Failure, ResponseModel>> resetPin(String pin, String accessToken);
  Future<Either<Failure, ResponseModel>> forgotPin(String email);
  Future<Either<Failure, ResponseModel>> resendForgotPin(String email);

  Future<Either<Failure, ResponseModel>> verifyCode(String code);

  // Biometric
  Future<Either<Failure, ResponseModel>> enableBiometric(bool status);

  Future<Either<Failure, ResponseModel>> bioLogin(String token);
}

class AuthRepositoryImpl implements AuthRepository {
  final NetworkInfo _networkInfo;
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl({required Ref ref})
      : _authRemoteDataSource = ref.read(authRemoteSourceProvider),
        _networkInfo = ref.read(networkInfoProvider);

  // Auth
  @override
  Future<Either<Failure, User>> register({
    required RegisterItem registerItem,
  }) async {
    ServiceRunner<Failure, User> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
      call: _authRemoteDataSource.register(registerItem: registerItem).then(
            (value) => AuthManager.instance.saveAuthenticatedUser(value),
          ),
      errorTitle: ErrorStrings.LOG_IN_ERROR,
    );
  }


  @override
  Future<Either<Failure, User>> login(String email, String pin) async {
    ServiceRunner<Failure, User> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
      call: _authRemoteDataSource.login(email, pin).then(
            (value) => AuthManager.instance.saveAuthenticatedUser(value),
          ),
      errorTitle: ErrorStrings.LOG_IN_ERROR,
    );
  }

  @override
  Future<Either<Failure, AuthenticatedUser>> accountVerification(
      String code) async {
    ServiceRunner<Failure, AuthenticatedUser> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
      call: _authRemoteDataSource.accountVerification(code),
      errorTitle: ErrorStrings.LOG_IN_ERROR,
    );
  }

  @override
  Future<Either<Failure, ResponseModel>> resendVerificationCode(
      String email) async {
    ServiceRunner<Failure, ResponseModel> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
      call: _authRemoteDataSource.resendVerificationCode(email),
      errorTitle: ErrorStrings.LOG_IN_ERROR,
    );
  }

  @override
  Future<Either<Failure, ResponseModel>> checkAccount(String email) async {
    ServiceRunner<Failure, ResponseModel> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
      call: _authRemoteDataSource.checkAccount(email),
      errorTitle: ErrorStrings.LOG_IN_ERROR,
    );
  }

  // Pin
  @override
  Future<Either<Failure, AuthenticatedUser>> createPin(String pin, {String? token}) async {
    ServiceRunner<Failure, AuthenticatedUser> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
      call: _authRemoteDataSource.createPin(pin, token: token),
      errorTitle: ErrorStrings.LOG_IN_ERROR,
    );
  }

  @override
  Future<Either<Failure, ResponseModel>> resetPin(String pin, String acceessToken) async {
    ServiceRunner<Failure, ResponseModel> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
      call: _authRemoteDataSource.resetPin(pin, acceessToken),
      errorTitle: ErrorStrings.LOG_IN_ERROR,
    );
  }

  @override
  Future<Either<Failure, ResponseModel>> forgotPin(String email) async {
    ServiceRunner<Failure, ResponseModel> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
      call: _authRemoteDataSource.forgotPin(email),
      errorTitle: ErrorStrings.LOG_IN_ERROR,
    );
  }

  @override
  Future<Either<Failure, ResponseModel>> resendForgotPin(String email) async {
    ServiceRunner<Failure, ResponseModel> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
      call: _authRemoteDataSource.resendForgotPin(email),
      errorTitle: ErrorStrings.LOG_IN_ERROR,
    );
  }

  @override
  Future<Either<Failure, ResponseModel>> verifyCode(String code) async {
    ServiceRunner<Failure, ResponseModel> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
      call: _authRemoteDataSource.verifyCode(code),
      errorTitle: ErrorStrings.LOG_IN_ERROR,
    );
  }

  // Enable Biometric
  @override
  Future<Either<Failure, ResponseModel>> enableBiometric(bool status) async {
    ServiceRunner<Failure, ResponseModel> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
      call: _authRemoteDataSource.enableBiometric(status),
      errorTitle: ErrorStrings.LOG_IN_ERROR,
    );
  }

  // Bio Login
  @override
  Future<Either<Failure, ResponseModel>> bioLogin(String token) async {
    ServiceRunner<Failure, ResponseModel> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
      call: _authRemoteDataSource.biometricLogin(token),
      errorTitle: ErrorStrings.LOG_IN_ERROR,
    );
  }
}
