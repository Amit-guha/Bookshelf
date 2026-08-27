import 'package:bookshelf/core/error/result.dart';
import 'package:bookshelf/features/book_details/domain/entities/book_details.dart';
import 'package:bookshelf/features/book_details/domain/entities/book_read_access.dart';

abstract class BookDetailsRepository {
  Future<Result<BookDetails>> getBookDetails(String workKey, {String? editionKey});

  Future<Result<BookReadAccess>> getReadAccess(String editionKey);
}
