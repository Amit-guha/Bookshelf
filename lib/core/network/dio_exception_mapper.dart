import 'package:bookshelf/core/constants/http_status_code.dart';
import 'package:bookshelf/core/error/exceptions.dart';
import 'package:dio/dio.dart';

/// Maps a raw [DioException] to a typed [AppException]. Keeps Dio-specific
/// types confined to `core/network/` — nothing above this layer should ever
/// see a [DioException].
AppException mapDioException(DioException exception) {
  return switch (exception.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout ||
    DioExceptionType.transformTimeout => const ApiTimeoutException(),
    DioExceptionType.connectionError => const NetworkException(),
    DioExceptionType.cancel => const RequestCancelledException(),
    DioExceptionType.badCertificate => const NetworkException(
      'Invalid certificate',
    ),
    DioExceptionType.badResponse => _mapBadResponse(exception),
    DioExceptionType.unknown => UnknownException(
      exception.message ?? 'Unexpected network error',
    ),
  };
}

AppException _mapBadResponse(DioException exception) {
  final statusCode = exception.response?.statusCode;
  final data = exception.response?.data;
  final message = _extractMessage(data) ?? exception.message ?? 'Something went wrong';

  return switch (statusCode) {
    HttpStatusCode.badRequest => BadRequestException(
      message,
      statusCode: statusCode,
    ),
    HttpStatusCode.unauthorized => UnauthorizedException(
      message,
      statusCode: statusCode,
    ),
    HttpStatusCode.forbidden => ForbiddenException(
      message,
      statusCode: statusCode,
    ),
    HttpStatusCode.notFound => NotFoundException(
      message,
      statusCode: statusCode,
    ),
    HttpStatusCode.conflict => ConflictException(
      message,
      statusCode: statusCode,
    ),
    HttpStatusCode.unprocessableEntity => ValidationException(
      message,
      statusCode: statusCode,
      errors: _extractValidationErrors(data),
    ),
    HttpStatusCode.tooManyRequests => TooManyRequestsException(
      message,
      statusCode: statusCode,
    ),
    _ when statusCode != null && statusCode >= 500 => ServerException(
      message,
      statusCode: statusCode,
    ),
    _ => UnknownException(message, statusCode),
  };
}

String? _extractMessage(dynamic data) {
  if (data is Map<String, dynamic>) {
    return data['message'] as String? ?? data['error'] as String?;
  }
  return null;
}

Map<String, List<String>>? _extractValidationErrors(dynamic data) {
  if (data is! Map<String, dynamic>) return null;
  final errors = data['errors'];
  if (errors is! Map) return null;

  return errors.map(
    (key, value) => MapEntry(
      key.toString(),
      value is List ? value.map((e) => e.toString()).toList() : [value.toString()],
    ),
  );
}