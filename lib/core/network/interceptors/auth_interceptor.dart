// Fields keep an underscore prefix while constructor parameters stay
// unprefixed for a cleaner call site, so initializing formals (`this._x`)
// aren't used here.
// ignore_for_file: prefer_initializing_formals

import 'dart:async';

import 'package:bookshelf/core/constants/api_constants.dart';
import 'package:bookshelf/core/network/token_storage.dart';
import 'package:dio/dio.dart';

/// [RequestOptions.extra] key. Set to `false` to send a request without an
/// `Authorization` header and without triggering refresh-and-retry on 401
/// (e.g. the login/refresh calls themselves).
const requiresAuthExtraKey = 'requiresAuth';
const _retriedExtraKey = 'alreadyRetriedAfterRefresh';


class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required Dio dio,
    required Dio refreshDio,
    required TokenStorage tokenStorage,
    required String refreshPath,
  }) : _dio = dio,
       _refreshDio = refreshDio,
       _tokenStorage = tokenStorage,
       _refreshPath = refreshPath;

  /// Main Dio instance (this interceptor's own client). Failed requests are
  /// retried through it so the retry still passes through logging/error
  /// interceptors — retrying through [_refreshDio] would skip them.
  final Dio _dio;

  /// Separate Dio instance used only to call the refresh endpoint. MUST NOT
  /// carry [AuthInterceptor] itself, or refreshing would recurse.
  final Dio _refreshDio;

  final TokenStorage _tokenStorage;
  final String _refreshPath;

  Completer<bool>? _refreshCompleter;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final requiresAuth = options.extra[requiresAuthExtraKey] as bool? ?? true;
    if (!requiresAuth) {
      handler.next(options);
      return;
    }

    final accessToken = await _tokenStorage.getAccessToken();
    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers[ApiConstants.authorizationHeader] = 'Bearer $accessToken';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final requestOptions = err.requestOptions;
    final requiresAuth =
        requestOptions.extra[requiresAuthExtraKey] as bool? ?? true;
    final alreadyRetried =
        requestOptions.extra[_retriedExtraKey] as bool? ?? false;

    if (err.response?.statusCode != 401 || !requiresAuth || alreadyRetried) {
      handler.next(err);
      return;
    }

    final refreshed = await _refreshToken();
    if (!refreshed) {
      await _tokenStorage.clearTokens();
      handler.next(err);
      return;
    }

    final accessToken = await _tokenStorage.getAccessToken();
    if (accessToken == null || accessToken.isEmpty) {
      await _tokenStorage.clearTokens();
      handler.next(err);
      return;
    }

    try {
      // A new RequestOptions instead of mutating the original in place.
      final retryOptions = requestOptions.copyWith(
        extra: {...requestOptions.extra, _retriedExtraKey: true},
        headers: {
          ...requestOptions.headers,
          ApiConstants.authorizationHeader: 'Bearer $accessToken',
        },
      );

      // Retry through the MAIN Dio instance so the retry still goes
      // through logging/error interceptors like any other request.
      final response = await _dio.fetch<dynamic>(retryOptions);
      handler.resolve(response);
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }

  Future<bool> _refreshToken() {
    final inFlight = _refreshCompleter;
    if (inFlight != null) return inFlight.future;

    final completer = Completer<bool>();
    _refreshCompleter = completer;
    unawaited(_performRefresh(completer));
    return completer.future;
  }

  Future<void> _performRefresh(Completer<bool> completer) async {
    try {
      final refreshToken = await _tokenStorage.getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        completer.complete(false);
        return;
      }

      final response = await _refreshDio.post<Map<String, dynamic>>(
        _refreshPath,
        data: {'refresh_token': refreshToken},
      );

      final data = response.data;
      final newAccessToken = data?['access_token'] as String?;
      if (newAccessToken == null || newAccessToken.isEmpty) {
        completer.complete(false);
        return;
      }

      // Some APIs rotate the refresh token on every use; others return
      // only a new access token and expect the same refresh token reused.
      final newRefreshToken = data?['refresh_token'] as String? ?? refreshToken;

      await _tokenStorage.saveTokens(
        accessToken: newAccessToken,
        refreshToken: newRefreshToken,
      );
      completer.complete(true);
    } catch (_) {
      if (!completer.isCompleted) completer.complete(false);
    } finally {
      _refreshCompleter = null;
    }
  }
}