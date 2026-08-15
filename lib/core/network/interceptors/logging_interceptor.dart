import 'dart:developer' as developer;

import 'package:bookshelf/core/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Logs requests, responses, and errors in debug builds only. Redacts the
/// `Authorization` header so tokens never end up in logs.
class LoggingInterceptor extends Interceptor {
  const LoggingInterceptor();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    if (kDebugMode) {
      developer.log(
        '--> ${options.method} ${options.uri}\n'
        'Headers: ${_redactHeaders(options.headers)}\n'
        'Body: ${options.data}',
        name: 'Dio',
      );
    }
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (kDebugMode) {
      developer.log(
        '<-- ${response.statusCode} ${response.requestOptions.uri}\n'
        'Body: ${response.data}',
        name: 'Dio',
      );
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      developer.log(
        '<-- ERROR ${err.response?.statusCode} ${err.requestOptions.uri}\n'
        'Message: ${err.message}\n'
        'Body: ${err.response?.data}',
        name: 'Dio',
        error: err,
        stackTrace: err.stackTrace,
      );
    }
    handler.next(err);
  }

  Map<String, dynamic> _redactHeaders(Map<String, dynamic> headers) {
    if (!headers.containsKey(ApiConstants.authorizationHeader)) {
      return headers;
    }
    return {...headers, ApiConstants.authorizationHeader: 'Bearer ***'};
  }
}