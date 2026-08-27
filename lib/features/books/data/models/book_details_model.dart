import 'package:bookshelf/features/books/domain/entities/book_details.dart';

/// Maps OpenLibrary's work/ratings/edition JSON responses to [BookDetails].
/// `description` is inconsistently either a plain string or a
/// `{type, value}` object, depending on the work.
class BookDetailsModel {
  const BookDetailsModel({
    required this.key,
    required this.title,
    this.description,
    this.subjects = const [],
    this.pageCount,
    this.averageRating,
    this.ratingCount,
  });

  /// [workJson] is required (the `/works/{id}.json` response). [ratingsJson]
  /// (`/works/{id}/ratings.json`) and [editionJson] (`/books/{id}.json`) are
  /// optional — the repository fetches them best-effort and passes `null`
  /// when unavailable.
  factory BookDetailsModel.fromJson({
    required Map<String, dynamic> workJson,
    Map<String, dynamic>? ratingsJson,
    Map<String, dynamic>? editionJson,
  }) {
    final rawDescription = workJson['description'];
    final description = switch (rawDescription) {
      String value => value,
      Map<String, dynamic> value => value['value'] as String?,
      _ => null,
    };
    final summary = ratingsJson?['summary'] as Map<String, dynamic>?;

    return BookDetailsModel(
      key: workJson['key'] as String? ?? '',
      title: workJson['title'] as String? ?? '',
      description: description,
      subjects:
          (workJson['subjects'] as List?)?.map((e) => e.toString()).toList() ??
          const [],
      pageCount: editionJson?['number_of_pages'] as int?,
      averageRating: (summary?['average'] as num?)?.toDouble(),
      ratingCount: summary?['count'] as int?,
    );
  }

  final String key;
  final String title;
  final String? description;
  final List<String> subjects;
  final int? pageCount;
  final double? averageRating;
  final int? ratingCount;

  BookDetails toEntity() => BookDetails(
    key: key,
    title: title,
    description: description,
    subjects: subjects,
    pageCount: pageCount,
    averageRating: averageRating,
    ratingCount: ratingCount,
  );
}
