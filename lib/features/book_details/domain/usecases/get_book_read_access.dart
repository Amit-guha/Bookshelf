import 'package:bookshelf/core/error/result.dart';
import 'package:bookshelf/features/book_details/domain/entities/book_read_access.dart';
import 'package:bookshelf/features/book_details/domain/repositories/book_details_repository.dart';

class GetBookReadAccess {
  const GetBookReadAccess(this._repository);

  final BookDetailsRepository _repository;

  Future<Result<BookReadAccess>> call(String editionKey) =>
      _repository.getReadAccess(editionKey);
}
