import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

// provider to create the instant and for dependency injection

final networkRequestProvider =
    Provider<NetworkRequest>((ref) => NetworkRequestImpl());

abstract class NetworkRequest {
  Future<Response> get(
    String url, {
    Object? body,
    Map<String, String>? headers,
  });

  Future<Response> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  });

  Future<Response> patch(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  });

  Future<Response> put(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  });

  Future<Response> delete(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  });
}

class NetworkRequestImpl implements NetworkRequest {
  // The _instance variable holds the single instance of the NetworkRequestImpl class.
  static NetworkRequestImpl? _instance;

  // The factory constructor _instance ensures that only one instance is created and returned when the NetworkRequestImpl class is instantiated.
  // It allows the class to control the creation of its instances. In this case, the constructor returns a reference to the private _instance field.
  factory NetworkRequestImpl() {
    _instance ??= NetworkRequestImpl._(); // if null create instant
    return _instance!;
  }
  // This constructor is used to create an instance of the NetworkRequestImpl class without directly invoking its regular constructor
  // The private constructor NetworkRequestImpl._() prevents the creation of instances of the NetworkRequestImpl class from outside the class itself. This ensures that the only way to obtain an instance is through the factory constructor _instance.
  NetworkRequestImpl._();

  @override
  Future<Response> get(
    String url, {
    Object? body,
    Map<String, String>? headers,
  }) {
    return Client()
        .get(Uri.parse(url), headers: headers)
        .timeout(const Duration(seconds: 60), onTimeout: () {
      throw TimeoutException('Time Out Error');
    });
  }

  @override
  Future<Response> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    return Client()
        .post(
      Uri.parse(url),
      headers: headers,
      body: body,
      encoding: encoding,
    )
        .timeout(const Duration(seconds: 60), onTimeout: () {
      throw TimeoutException('Time Out Error');
    });
  }

  @override
  Future<Response> patch(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    return Client().patch(Uri.parse(url),
        headers: headers, body: body, encoding: encoding);
  }

  @override
  Future<Response> put(String url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    return Client()
        .put(Uri.parse(url), headers: headers, body: body, encoding: encoding);
  }

  @override
  Future<Response> delete(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    return Client().delete(Uri.parse(url),
        headers: headers, body: body, encoding: encoding);
  }
}
