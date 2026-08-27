class Book {
  const Book({
    required this.key,
    required this.title,
    this.authorNames = const [],
    this.coverUrl,
    this.firstPublishYear,
    this.editionKey,
  });

  final String key;
  final String title;
  final List<String> authorNames;
  final String? coverUrl;
  final int? firstPublishYear;

  /// The edition OLID used to look up read/borrow access via
  /// [BookRepository.getReadAccess] — `null` when the source API didn't
  /// surface a representative edition for this work.
  final String? editionKey;
}