import 'package:bookshelf/core/error/result.dart';
import 'package:bookshelf/features/books/domain/entities/book.dart';
import 'package:bookshelf/features/books/domain/repositories/book_repository.dart';

class SearchBooks {
  const SearchBooks(this._repository);

  final BookRepository _repository;

  Future<Result<List<Book>>> call(String query, {int limit = 20}) =>
      _repository.searchBooks(query, limit: limit);
}
