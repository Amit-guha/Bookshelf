import 'package:bookshelf/core/constants/api_constants.dart';
import 'package:bookshelf/features/books/domain/entities/book.dart';

/// Maps OpenLibrary "work" JSON to [Book]. The Trending and Subjects APIs
/// return slightly different field names for the same concepts (author
/// names, cover id) — [fromTrendingJson]/[fromSubjectJson] normalize both
/// into this same shape.
class BookModel {
  const BookModel({
    required this.key,
    required this.title,
    this.authorNames = const [],
    this.coverId,
    this.firstPublishYear,
    this.editionKey,
    this.authorKey,
  });

  factory BookModel.fromTrendingJson(Map<String, dynamic> json) => BookModel(
    key: json['key'] as String? ?? '',
    title: json['title'] as String? ?? '',
    authorNames:
        (json['author_name'] as List?)?.map((e) => e.toString()).toList() ??
        const [],
    coverId: json['cover_i'] as int?,
    firstPublishYear: json['first_publish_year'] as int?,
    editionKey: json['cover_edition_key'] as String?,
    authorKey: _authorKeyFrom(_firstOrNull(json['author_key'] as List?)),
  );

  factory BookModel.fromSubjectJson(Map<String, dynamic> json) => BookModel(
    key: json['key'] as String? ?? '',
    title: json['title'] as String? ?? '',
    authorNames:
        (json['authors'] as List?)
            ?.map((a) => (a as Map<String, dynamic>)['name']?.toString() ?? '')
            .where((name) => name.isNotEmpty)
            .toList() ??
        const [],
    coverId: json['cover_id'] as int?,
    firstPublishYear: json['first_publish_year'] as int?,
    editionKey: json['cover_edition_key'] as String?,
    authorKey: _authorKeyFrom(
      (_firstOrNull(json['authors'] as List?) as Map<String, dynamic>?)?['key'],
    ),
  );

  final String key;
  final String title;
  final List<String> authorNames;
  final int? coverId;
  final int? firstPublishYear;
  final String? editionKey;
  final String? authorKey;

  Book toEntity() => Book(
    key: key,
    title: title,
    authorNames: authorNames,
    coverUrl: coverId != null
        ? ApiConstants.coverUrl(key: 'id', value: coverId.toString())
        : null,
    firstPublishYear: firstPublishYear,
    editionKey: editionKey,
    authorKey: authorKey,
  );

  static Object? _firstOrNull(List? list) =>
      list != null && list.isNotEmpty ? list.first : null;

  /// Normalizes both shapes OpenLibrary returns an author key in — a bare
  /// OLID (`trending`/`search`'s `author_key`) or a prefixed one
  /// (`subjects`' `authors[].key`, e.g. `/authors/OL79034A`) — to a bare
  /// OLID.
  static String? _authorKeyFrom(dynamic key) =>
      key?.toString().split('/').last;
}
