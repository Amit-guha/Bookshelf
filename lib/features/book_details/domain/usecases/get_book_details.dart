import 'package:bookshelf/core/error/result.dart';
import 'package:bookshelf/features/book_details/domain/entities/book_details.dart';
import 'package:bookshelf/features/book_details/domain/repositories/book_details_repository.dart';

class GetBookDetails {
  const GetBookDetails(this._repository);

  final BookDetailsRepository _repository;

  Future<Result<BookDetails>> call(String workKey, {String? editionKey}) =>
      _repository.getBookDetails(workKey, editionKey: editionKey);
}
