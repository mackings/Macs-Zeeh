import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:zeeh_mobile/feature/auth/model/auth/token.dart';
import 'package:zeeh_mobile/feature/auth/model/auth/user.dart';

final authLocalSourceProvider =
    Provider<AuthLocalDataSource>((ref) => AuthLocalDataSourceImpl());

abstract class AuthLocalDataSource {
  Future<User> saveAuthenticatedUser(User user);
  Future<bool> clearAuthenticatedUser();
  Future<User?> getAuthenticatedUser();
  Stream<User?> streamUserStatus();
  // Token
  Future<Token> saveBioToken(Token token);
  Future<bool> clearBioToken();
  Future<Token?> getBioToken();
  Stream<Token?> streamTokentatus();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const String _userKey = 'auth_user';
  static const String _tokenKey = 'bio_token';

  @override
  Future<bool> clearAuthenticatedUser() async {
    final box = await Hive.openBox<User>(_userKey);

    try {
      box.clear();
      return true;
    } on Exception catch (e) {
      throw Exception(e);
    } finally {}
  }

  // Clear Biometric token
  @override
  Future<bool> clearBioToken() async {
    final box = await Hive.openBox<Token>(_tokenKey);

    try {
      box.clear();
      return true;
    } on Exception catch (e) {
      throw Exception(e);
    } finally {}
  }

  @override
  Future<User> saveAuthenticatedUser(User user) async {
    final box = await Hive.openBox<User>(_userKey);

    try {
      await box.put(_userKey, user);
      return user;
    } on Exception catch (e) {
      throw Exception(e);
    } finally {}
  }

  // Save Biometric token
  @override
  Future<Token> saveBioToken(Token token) async {
    final box = await Hive.openBox<Token>(_tokenKey);

    try {
      await box.put(_tokenKey, token);
      return token;
    } on Exception catch (e) {
      throw Exception(e);
    } finally {}
  }

  @override
  Future<User?> getAuthenticatedUser() async {
    final box = await Hive.openBox<User>(_userKey);

    try {
      final authCred = box.get(_userKey);

      return authCred;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  // Get Biometric token
  @override
  Future<Token?> getBioToken() async {
    final box = await Hive.openBox<Token>(_tokenKey);

    try {
      final tokenString = box.get(_tokenKey);

      return tokenString;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Stream<User?> streamUserStatus() async* {
    final box = await Hive.openBox<User>(_userKey);

    yield* box.watch(key: _userKey).map((event) {
      return event.value as User;
    }).asBroadcastStream();
  }

  @override
  Stream<Token?> streamTokentatus() async* {
    final box = await Hive.openBox<Token>(_tokenKey);

    yield* box.watch(key: _tokenKey).map((event) {
      return event.value as Token;
    }).asBroadcastStream();
  }
}
