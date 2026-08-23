import 'package:bookshelf/features/books/domain/entities/book_details.dart';

/// Maps an OpenLibrary "work" JSON response to [BookDetails]. `description`
/// is inconsistently either a plain string or a `{type, value}` object,
/// depending on the work.
class BookDetailsModel {
  const BookDetailsModel({
    required this.key,
    required this.title,
    this.description,
    this.subjects = const [],
  });

  factory BookDetailsModel.fromWorkJson(Map<String, dynamic> json) {
    final rawDescription = json['description'];
    final description = switch (rawDescription) {
      String value => value,
      Map<String, dynamic> value => value['value'] as String?,
      _ => null,
    };

    return BookDetailsModel(
      key: json['key'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: description,
      subjects:
          (json['subjects'] as List?)?.map((e) => e.toString()).toList() ??
          const [],
    );
  }

  final String key;
  final String title;
  final String? description;
  final List<String> subjects;

  BookDetails toEntity() => BookDetails(
    key: key,
    title: title,
    description: description,
    subjects: subjects,
  );
}
