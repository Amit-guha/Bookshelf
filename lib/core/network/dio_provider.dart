import 'package:bookshelf/core/constants/api_constants.dart';
import 'package:bookshelf/core/network/interceptors/auth_interceptor.dart';
import 'package:bookshelf/core/network/interceptors/error_interceptor.dart';
import 'package:bookshelf/core/network/interceptors/logging_interceptor.dart';
import 'package:bookshelf/core/network/token_storage.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';
const _refreshPath = '/auth/refresh';

@riverpod
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: ApiConstants.connectTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
      sendTimeout: ApiConstants.sendTimeout,
      headers: const {ApiConstants.contentTypeHeader: 'application/json'},
    ),
  );

  // Plain client with no interceptors — used by AuthInterceptor to call the
  // refresh endpoint without recursing back into this same chain.
  final refreshDio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: ApiConstants.connectTimeout,
    ),
  );

  // Order matters: logging sees the raw request/response/error first; auth
  // gets a chance to resolve a 401 via refresh-and-retry; error mapping runs
  // last so a successfully-retried request never reaches it.
  dio.interceptors.addAll([
    const LoggingInterceptor(),
    AuthInterceptor(
      dio: dio,
      refreshDio: refreshDio,
      tokenStorage: ref.watch(tokenStorageProvider),
      refreshPath: _refreshPath,
    ),
    const ErrorInterceptor(),
  ]);

  return dio;
}