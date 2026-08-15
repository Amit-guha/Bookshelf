import 'package:bookshelf/core/error/exceptions.dart';

/// Returned by repositories/usecases instead of throwing. See
/// `core/error/result.dart` for the `Result<T>` wrapper used to carry these.
sealed class Failure {
  const Failure(this.message);

  final String message;
}

class BadRequestFailure extends Failure {
  const BadRequestFailure(super.message);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(super.message);
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure(super.message);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}

class ConflictFailure extends Failure {
  const ConflictFailure(super.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message, {this.errors});

  final Map<String, List<String>>? errors;
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}

/// Translates a caught exception into a domain-level [Failure]. Repository
/// implementations are the intended caller — see the Data Layer conventions
/// in AGENTS.md.
Failure mapExceptionToFailure(Object exception) {
  if (exception is! AppException) {
    return UnknownFailure(exception.toString());
  }

  return switch (exception) {
    BadRequestException() => BadRequestFailure(exception.message),
    UnauthorizedException() => UnauthorizedFailure(exception.message),
    ForbiddenException() => ForbiddenFailure(exception.message),
    NotFoundException() => NotFoundFailure(exception.message),
    ConflictException() => ConflictFailure(exception.message),
    ValidationException(:final errors) => ValidationFailure(
      exception.message,
      errors: errors,
    ),
    TooManyRequestsException() => ServerFailure(exception.message),
    ServerException() => ServerFailure(exception.message),
    NetworkException() => NetworkFailure(exception.message),
    ApiTimeoutException() => NetworkFailure(exception.message),
    RequestCancelledException() => UnknownFailure(exception.message),
    CacheException() => CacheFailure(exception.message),
    UnknownException() => UnknownFailure(exception.message),
  };
}