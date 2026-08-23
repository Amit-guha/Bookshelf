import 'package:bookshelf/core/error/result.dart';
import 'package:bookshelf/features/books/domain/entities/book_details.dart';
import 'package:bookshelf/features/books/domain/repositories/book_repository.dart';

class GetBookDetails {
  const GetBookDetails(this._repository);

  final BookRepository _repository;

  Future<Result<BookDetails>> call(String key) => _repository.getBookDetails(key);
}
