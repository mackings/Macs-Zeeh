import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zeeh_mobile/feature/auth/data/source/local_source.dart';
import 'package:zeeh_mobile/feature/auth/model/auth/authenticated_user.dart';
import 'package:zeeh_mobile/feature/auth/model/auth/token.dart';
import 'package:zeeh_mobile/feature/auth/model/auth/user.dart';

final authProvider =
    Provider.autoDispose<AuthManager?>((ref) => AuthManager.instance);

final streamUserProvider = StreamProvider.autoDispose<User?>((ref) async* {
  yield* AuthManager.instance.streamActiveUser();
});

class AuthManager {
  final AuthLocalDataSourceImpl _authlocalDataSource =
      AuthLocalDataSourceImpl();

  static final AuthManager instance = AuthManager._();
  final AuthLocalDataSourceImpl _localSource = AuthLocalDataSourceImpl();

  User? user;

  Token? token;

  AuthenticatedUser? authUser;

  AuthManager._() {
    init();
  }

  Future<User> saveAuthenticatedUser(User user) async {
    return user = await _authlocalDataSource.saveAuthenticatedUser(user);
  }

  Future<Token> saveBiometricToken(Token token) async {
    return token = await _authlocalDataSource.saveBioToken(token);
  }

  Future<void> init() async {
    user = await _localSource.getAuthenticatedUser();
  }

  Future<void> initBiometricToken() async {
    token = await _localSource.getBioToken();
  }

  Future<User?> getAuthenticatedUser() async {
    return user = await _localSource.getAuthenticatedUser();
  }

  Future<Token?> getBiometricToken() async {
    return token = await _localSource.getBioToken();
  }

  Future<void> clearAuthenticatedUser() async {
    await _localSource.clearAuthenticatedUser();
  }

  Future<void> clearBiometricToken() async {
    await _localSource.clearBioToken();
  }

  Stream<User?> streamActiveUser() async* {
    yield* _localSource
        .streamUserStatus()
        .map((event) => user = event)
        .asBroadcastStream();
  }

  Stream<Token?> streamBiometricToken() async* {
    yield* _localSource
        .streamTokentatus()
        .map((event) => token = event)
        .asBroadcastStream();
  }
}
