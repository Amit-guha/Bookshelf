import 'package:bookshelf/core/error/result.dart';
import 'package:bookshelf/features/books/domain/entities/book.dart';
import 'package:bookshelf/features/books/domain/entities/trending_period.dart';

abstract class BookRepository {
  Future<Result<List<Book>>> getTrendingBooks(TrendingPeriod period);

  Future<Result<List<Book>>> getBooksBySubject(String subject, {int limit});

  Future<Result<List<Book>>> searchBooks(String query, {int limit});
}
