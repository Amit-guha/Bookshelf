import 'package:bookshelf/core/error/result.dart';
import 'package:bookshelf/features/books/domain/entities/book_read_access.dart';
import 'package:bookshelf/features/books/domain/repositories/book_repository.dart';

class GetBookReadAccess {
  const GetBookReadAccess(this._repository);

  final BookRepository _repository;

  Future<Result<BookReadAccess>> call(String editionKey) =>
      _repository.getReadAccess(editionKey);
}
