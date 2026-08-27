import 'package:bookshelf/core/constants/api_constants.dart';
import 'package:bookshelf/core/network/api_client.dart';
import 'package:bookshelf/core/network/interceptors/auth_interceptor.dart';
import 'package:dio/dio.dart';

class BookDetailsRemoteDatasource {
  const BookDetailsRemoteDatasource(this._apiClient);

  final ApiClient _apiClient;

  /// [workKey] is a work's `key` field as returned by the Trending/Subjects
  /// APIs, e.g. `/works/OL45804W` — the leading `/works/` segment is
  /// stripped to build the work detail path.
  Future<Map<String, dynamic>> getBookDetails(String workKey) async {
    final olid = workKey.split('/').last;
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiConstants.workPath(olid),
      options: Options(extra: const {requiresAuthExtraKey: false}),
    );
    return response.data ?? const {};
  }

  /// [workKey] is a work's `key` field, e.g. `/works/OL45804W`.
  Future<Map<String, dynamic>> getRatings(String workKey) async {
    final olid = workKey.split('/').last;
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiConstants.ratingsPath(olid),
      options: Options(extra: const {requiresAuthExtraKey: false}),
    );
    return response.data ?? const {};
  }

  /// [editionKey] is a `Book.editionKey` (edition OLID, e.g. `OL50444320M`).
  Future<Map<String, dynamic>> getEditionDetails(String editionKey) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiConstants.editionPath(editionKey),
      options: Options(extra: const {requiresAuthExtraKey: false}),
    );
    return response.data ?? const {};
  }

  /// [editionKey] is a `Book.editionKey` (edition OLID, e.g. `OL50444320M`).
  Future<Map<String, dynamic>> getReadAccess(String editionKey) async {
    final bibkey = 'OLID:$editionKey';
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiConstants.books,
      queryParameters: {
        'bibkeys': bibkey,
        'format': 'json',
        'jscmd': 'data',
      },
      options: Options(extra: const {requiresAuthExtraKey: false}),
    );
    return (response.data?[bibkey] as Map<String, dynamic>?) ?? const {};
  }
}
