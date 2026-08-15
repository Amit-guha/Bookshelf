import 'package:bookshelf/core/network/dio_exception_mapper.dart';
import 'package:dio/dio.dart';

/// Translates every [DioException] that reaches it into a typed
/// [AppException] carried on [DioException.error], so callers never need to
/// inspect Dio-specific status codes/types themselves.
///
/// Placed last in the interceptor chain (see `dio_provider.dart`) so that
/// [AuthInterceptor] gets a chance to resolve a request via token refresh
/// before an error is mapped and surfaced.
class ErrorInterceptor extends Interceptor {
  const ErrorInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final appException = mapDioException(err);
    handler.next(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: appException,
        stackTrace: err.stackTrace,
        message: appException.message,
      ),
    );
  }
}