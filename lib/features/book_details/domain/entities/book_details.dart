class BookDetails {
  const BookDetails({
    required this.key,
    required this.title,
    this.description,
    this.subjects = const [],
    this.pageCount,
    this.averageRating,
    this.ratingCount,
  });

  final String key;
  final String title;
  final String? description;
  final List<String> subjects;
  final int? pageCount;
  final double? averageRating;
  final int? ratingCount;
}
