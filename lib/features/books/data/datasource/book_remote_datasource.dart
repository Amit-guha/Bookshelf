import 'package:bookshelf/core/constants/api_constants.dart';
import 'package:bookshelf/core/network/api_client.dart';
import 'package:bookshelf/core/network/interceptors/auth_interceptor.dart';
import 'package:bookshelf/features/books/domain/entities/trending_period.dart';
import 'package:dio/dio.dart';

class BookRemoteDatasource {
  const BookRemoteDatasource(this._apiClient);

  final ApiClient _apiClient;

  Future<List<Map<String, dynamic>>> getTrendingBooks(
    TrendingPeriod period,
  ) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiConstants.trendingPath(_periodSegment(period)),
      options: Options(extra: const {requiresAuthExtraKey: false}),
    );
    return _worksFrom(response.data);
  }

  Future<List<Map<String, dynamic>>> getBooksBySubject(
    String subject, {
    required int limit,
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiConstants.subjectPath(subject),
      queryParameters: {'limit': limit},
      options: Options(extra: const {requiresAuthExtraKey: false}),
    );
    return _worksFrom(response.data);
  }

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

  List<Map<String, dynamic>> _worksFrom(Map<String, dynamic>? data) {
    final works = data?['works'] as List?;
    return works?.cast<Map<String, dynamic>>() ?? const [];
  }

  String _periodSegment(TrendingPeriod period) => switch (period) {
    TrendingPeriod.daily => 'daily',
    TrendingPeriod.weekly => 'weekly',
    TrendingPeriod.monthly => 'monthly',
    TrendingPeriod.yearly => 'yearly',
    TrendingPeriod.forever => 'forever',
  };
}