import 'package:bookshelf/core/error/result.dart';
import 'package:bookshelf/features/books/domain/entities/book.dart';
import 'package:bookshelf/features/books/domain/entities/trending_period.dart';
import 'package:bookshelf/features/books/domain/repositories/book_repository.dart';

class GetTrendingBooks {
  const GetTrendingBooks(this._repository);

  final BookRepository _repository;

  Future<Result<List<Book>>> call(TrendingPeriod period) =>
      _repository.getTrendingBooks(period);
}