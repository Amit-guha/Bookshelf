class BookDetails {
  const BookDetails({
    required this.key,
    required this.title,
    this.description,
    this.subjects = const [],
  });

  final String key;
  final String title;
  final String? description;
  final List<String> subjects;
}
