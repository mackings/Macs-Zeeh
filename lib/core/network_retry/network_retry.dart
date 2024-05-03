import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retry/retry.dart';

// provider to create the instant and for dependency injection
final networkRetryProvider =
    Provider<NetworkRetry>((ref) => NetworkRetryImpl());

abstract class NetworkRetry {
  Future<T> networkRetry<T>(
    FutureOr<T> Function() function,
  );
}

class NetworkRetryImpl implements NetworkRetry {
  // The _instance variable holds the single instance of the NetworkRequestImpl class.
  static NetworkRetryImpl? _instance;

  // The factory constructor _instance ensures that only one instance is created and returned when the NetworkRequestImpl class is instantiated.
  // It allows the class to control the creation of its instances. In this case, the constructor returns a reference to the private _instance field.
  factory NetworkRetryImpl() {
    _instance ??= NetworkRetryImpl._(); // if null create instant
    return _instance!;
  }
  // This constructor is used to create an instance of the NetworkRequestImpl class without directly invoking its regular constructor
  // The private constructor NetworkRequestImpl._() prevents the creation of instances of the NetworkRequestImpl class from outside the class itself. This ensures that the only way to obtain an instance is through the factory constructor _instance.
  NetworkRetryImpl._();

  @override
  Future<T> networkRetry<T>(FutureOr<T> Function() function) {
    return retry(
      function,
      maxAttempts: 0,
      maxDelay: const Duration(seconds: 17),
    );
  }
}
