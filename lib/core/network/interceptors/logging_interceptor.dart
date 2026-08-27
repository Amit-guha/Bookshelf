import 'dart:convert';
import 'dart:developer' as developer;

import 'package:bookshelf/core/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Logs requests, responses, and errors in debug builds only.
///
/// Redacts the `Authorization` header, pretty-prints JSON bodies, tags
/// request/response pairs with elapsed time, and truncates large bodies —
/// then emits everything one line at a time so Android logcat (and `flutter
/// logs`/`adb logcat`, which drop or garble long single-line entries) stay
/// readable.
class LoggingInterceptor extends Interceptor {
  const LoggingInterceptor();

  static const _maxBodyLength = 4000;
  static const _maxLineLength = 800;
  static const _requestStartTimeKey = 'log_request_start_time';
  static const _divider = '------------------------------------------------'
      '------------------------------';

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    options.extra[_requestStartTimeKey] = DateTime.now();
    if (kDebugMode) {
      _logBlock([
        '⬆️  ${options.method} ${options.uri}',
        'Headers: ${_redactHeaders(options.headers)}',
        if (options.data != null) 'Body: ${_formatBody(options.data)}',
      ]);
    }
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (kDebugMode) {
      final requestOptions = response.requestOptions;
      _logBlock([
        '⬇️  ${response.statusCode} ${requestOptions.method} '
            '${requestOptions.uri} '
            '(${_elapsedMs(requestOptions)}ms)',
        'Body: ${_formatBody(response.data)}',
      ]);
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      final requestOptions = err.requestOptions;
      _logBlock(
        [
          '❌ ${err.response?.statusCode} ${requestOptions.method} '
              '${requestOptions.uri} '
              '(${_elapsedMs(requestOptions)}ms)',
          'Type: ${err.type}',
          'Message: ${err.message}',
          if (err.response?.data != null)
            'Body: ${_formatBody(err.response?.data)}',
        ],
        error: err,
        stackTrace: err.stackTrace,
      );
    }
    handler.next(err);
  }

  /// Logs each line as its own `developer.log` call (further wrapping
  /// overlong lines) so entries never get truncated by logcat/adb's
  /// per-line buffer or collapsed into one unreadable blob.
  void _logBlock(List<String> lines, {Object? error, StackTrace? stackTrace}) {
    developer.log(_divider, name: 'Dio');
    for (final line in lines) {
      for (final wrapped in _wrap(line)) {
        developer.log(wrapped, name: 'Dio');
      }
    }
    if (error != null) {
      developer.log(
        'Dio error details',
        name: 'Dio',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Iterable<String> _wrap(String line) sync* {
    if (line.length <= _maxLineLength) {
      yield line;
      return;
    }
    for (var i = 0; i < line.length; i += _maxLineLength) {
      final end = (i + _maxLineLength).clamp(0, line.length);
      yield line.substring(i, end);
    }
  }

  int? _elapsedMs(RequestOptions options) {
    final start = options.extra[_requestStartTimeKey];
    if (start is! DateTime) return null;
    return DateTime.now().difference(start).inMilliseconds;
  }

  String _formatBody(dynamic data) {
    if (data == null) return 'null';
    var text = data.toString();
    try {
      final decodable = data is String ? jsonDecode(data) : data;
      if (decodable is Map || decodable is List) {
        text = const JsonEncoder.withIndent('  ').convert(decodable);
      }
    } catch (_) {
      // Not JSON — fall back to the raw toString() above.
    }
    if (text.length > _maxBodyLength) {
      return '${text.substring(0, _maxBodyLength)}… '
          '(truncated, ${text.length} chars total)';
    }
    return text;
  }

  Map<String, dynamic> _redactHeaders(Map<String, dynamic> headers) {
    if (!headers.containsKey(ApiConstants.authorizationHeader)) {
      return headers;
    }
    return {...headers, ApiConstants.authorizationHeader: 'Bearer ***'};
  }
}
