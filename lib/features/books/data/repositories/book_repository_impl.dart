import 'package:bookshelf/core/error/failure.dart';
import 'package:bookshelf/core/error/result.dart';
import 'package:bookshelf/features/books/data/datasource/book_remote_datasource.dart';
import 'package:bookshelf/features/books/data/models/book_details_model.dart';
import 'package:bookshelf/features/books/data/models/book_model.dart';
import 'package:bookshelf/features/books/data/models/book_read_access_model.dart';
import 'package:bookshelf/features/books/domain/entities/book.dart';
import 'package:bookshelf/features/books/domain/entities/book_details.dart';
import 'package:bookshelf/features/books/domain/entities/book_read_access.dart';
import 'package:bookshelf/features/books/domain/entities/trending_period.dart';
import 'package:bookshelf/features/books/domain/repositories/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  const BookRepositoryImpl(this._datasource);

  final BookRemoteDatasource _datasource;

  @override
  Future<Result<List<Book>>> getTrendingBooks(TrendingPeriod period) async {
    try {
      final json = await _datasource.getTrendingBooks(period);
      final books = json
          .map((work) => BookModel.fromTrendingJson(work).toEntity())
          .toList();
      return Success(books);
    } catch (e) {
      return ResultFailure(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<List<Book>>> getBooksBySubject(
    String subject, {
    int limit = 20,
  }) async {
    try {
      final json = await _datasource.getBooksBySubject(
        subject,
        limit: limit,
      );
      final books = json
          .map((work) => BookModel.fromSubjectJson(work).toEntity())
          .toList();
      return Success(books);
    } catch (e) {
      return ResultFailure(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<BookDetails>> getBookDetails(
    String workKey, {
    String? editionKey,
  }) async {
    try {
      final workJson = await _datasource.getBookDetails(workKey);
      final ratingsJson = await _safeFetch(
        () => _datasource.getRatings(workKey),
      );
      final editionJson = editionKey == null
          ? null
          : await _safeFetch(() => _datasource.getEditionDetails(editionKey));
      return Success(
        BookDetailsModel.fromJson(
          workJson: workJson,
          ratingsJson: ratingsJson,
          editionJson: editionJson,
        ).toEntity(),
      );
    } catch (e) {
      return ResultFailure(mapExceptionToFailure(e));
    }
  }

  /// Ratings/edition lookups are supplementary — if either fails (e.g. no
  /// ratings yet for a work), the core detail load shouldn't fail with it.
  Future<Map<String, dynamic>?> _safeFetch(
    Future<Map<String, dynamic>> Function() fetch,
  ) async {
    try {
      return await fetch();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Result<BookReadAccess>> getReadAccess(String editionKey) async {
    try {
      final json = await _datasource.getReadAccess(editionKey);
      return Success(BookReadAccessModel.fromJson(json).toEntity());
    } catch (e) {
      return ResultFailure(mapExceptionToFailure(e));
    }
  }
}