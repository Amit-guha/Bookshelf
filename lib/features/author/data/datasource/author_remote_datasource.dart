import 'package:bookshelf/core/constants/api_constants.dart';
import 'package:bookshelf/core/network/api_client.dart';
import 'package:bookshelf/core/network/interceptors/auth_interceptor.dart';
import 'package:dio/dio.dart';

class AuthorRemoteDatasource {
  const AuthorRemoteDatasource(this._apiClient);

  final ApiClient _apiClient;

  /// [key] is an author's `key` field, e.g. `/authors/OL79034A`, or a bare
  /// OLID — the leading `/authors/` segment is stripped if present.
  Future<Map<String, dynamic>> getAuthor(String key) async {
    final olid = key.split('/').last;
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiConstants.authorPath(olid),
      options: Options(extra: const {requiresAuthExtraKey: false}),
    );
    return response.data ?? const {};
  }
}
