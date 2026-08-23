class Book {
  const Book({
    required this.key,
    required this.title,
    this.authorNames = const [],
    this.coverUrl,
    this.firstPublishYear,
  });

  final String key;
  final String title;
  final List<String> authorNames;
  final String? coverUrl;
  final int? firstPublishYear;
}