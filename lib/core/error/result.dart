import 'package:bookshelf/core/error/failure.dart';

/// Either-style return type for repositories and usecases: either a [T] on
/// [Success] or a [Failure] on [ResultFailure]. Framework-agnostic — safe to
/// use from `domain/`.
sealed class Result<T> {
  const Result();

  R when<R>({
    required R Function(T data) success,
    required R Function(Failure failure) failure,
  }) => switch (this) {
    Success<T>(:final data) => success(data),
    ResultFailure<T>(failure: final f) => failure(f),
  };
}

class Success<T> extends Result<T> {
  const Success(this.data);

  final T data;
}

class ResultFailure<T> extends Result<T> {
  const ResultFailure(this.failure);

  final Failure failure;
}