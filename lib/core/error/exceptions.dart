/// Thrown by datasources when an operation fails. Repositories catch these
/// and translate them into [Failure]s via [mapExceptionToFailure] — see
/// `failure.dart`.
sealed class AppException implements Exception {
  const AppException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => message;
}

class BadRequestException extends AppException {
  const BadRequestException(super.message, {super.statusCode});
}

class UnauthorizedException extends AppException {
  const UnauthorizedException(super.message, {super.statusCode});
}

class ForbiddenException extends AppException {
  const ForbiddenException(super.message, {super.statusCode});
}

class NotFoundException extends AppException {
  const NotFoundException(super.message, {super.statusCode});
}

class ConflictException extends AppException {
  const ConflictException(super.message, {super.statusCode});
}

class ValidationException extends AppException {
  const ValidationException(super.message, {super.statusCode, this.errors});

  final Map<String, List<String>>? errors;
}

class TooManyRequestsException extends AppException {
  const TooManyRequestsException(super.message, {super.statusCode});
}

class ServerException extends AppException {
  const ServerException(super.message, {super.statusCode});
}

class NetworkException extends AppException {
  const NetworkException([super.message = 'No internet connection']);
}

class ApiTimeoutException extends AppException {
  const ApiTimeoutException([super.message = 'The request timed out']);
}

class RequestCancelledException extends AppException {
  const RequestCancelledException([super.message = 'Request was cancelled']);
}

class CacheException extends AppException {
  const CacheException([super.message = 'Cache error']);
}

class UnknownException extends AppException {
  const UnknownException([
    super.message = 'Something went wrong',
    int? statusCode,
  ]) : super(statusCode: statusCode);
}