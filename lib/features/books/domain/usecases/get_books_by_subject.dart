import 'package:bookshelf/core/error/result.dart';
import 'package:bookshelf/features/books/domain/entities/book.dart';
import 'package:bookshelf/features/books/domain/repositories/book_repository.dart';

class GetBooksBySubject {
  const GetBooksBySubject(this._repository);

  final BookRepository _repository;

  Future<Result<List<Book>>> call(String subject, {int limit = 20}) =>
      _repository.getBooksBySubject(subject, limit: limit);
}