import 'dart:convert';

import 'package:http/http.dart';

Future<T> processResponse<T>({
  required Response response,

  // this is the function used to do the setrialization
  required T Function(dynamic) serializer,

  // This is the code to check for in the response
  int successCode = 200,
  // This is the code to check for in the response
  int authCode = 401,

  // The map is the error serialized
  Exception Function(dynamic)? serializeError,
}) async {
  final data = await json.decode(response.body);

  if (response.statusCode == successCode) {
    try {
      return serializer(data);
    } on Exception catch (_) {
      rethrow;
    }
  } else if (response.statusCode == authCode) {
    throw Exception(response.statusCode);
  } else {
    if (serializeError != null) {
      throw serializeError(data);
    } else {
      final Map errors = data;
      final errorList = [];
      try {
        if (errors.keys.contains('text')) {
          //handle password error message appearing in list
          //issue
          //remove if resolved from the backend.
          errorList.add(errors['text']);
          throw Exception(errorList[0]);
        } else if (errors.keys.isNotEmpty) {
          for (String errorKey in errors.keys) {
            errorList.add('${errors[errorKey]}');
          }

          throw Exception((errorList[0] as String)
              .substring(9, (errorList[0] as String).length - 2));
        } else {
          throw Exception(response.statusCode);
        }
      } on Exception catch (_) {
        rethrow;
      }
    }
  }
}
