import 'package:bookshelf/core/error/failure.dart';
import 'package:bookshelf/core/error/result.dart';
import 'package:bookshelf/features/books/data/datasource/book_remote_datasource.dart';
import 'package:bookshelf/features/books/data/models/book_details_model.dart';
import 'package:bookshelf/features/books/data/models/book_model.dart';
import 'package:bookshelf/features/books/domain/entities/book.dart';
import 'package:bookshelf/features/books/domain/entities/book_details.dart';
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
  Future<Result<BookDetails>> getBookDetails(String key) async {
    try {
      final json = await _datasource.getBookDetails(key);
      return Success(BookDetailsModel.fromWorkJson(json).toEntity());
    } catch (e) {
      return ResultFailure(mapExceptionToFailure(e));
    }
  }
}