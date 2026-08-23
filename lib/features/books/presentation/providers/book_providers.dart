import 'package:bookshelf/core/network/api_client.dart';
import 'package:bookshelf/features/books/data/datasource/book_remote_datasource.dart';
import 'package:bookshelf/features/books/data/repositories/book_repository_impl.dart';
import 'package:bookshelf/features/books/domain/entities/book.dart';
import 'package:bookshelf/features/books/domain/entities/book_details.dart';
import 'package:bookshelf/features/books/domain/entities/trending_period.dart';
import 'package:bookshelf/features/books/domain/repositories/book_repository.dart';
import 'package:bookshelf/features/books/domain/usecases/get_book_details.dart';
import 'package:bookshelf/features/books/domain/usecases/get_books_by_subject.dart';
import 'package:bookshelf/features/books/domain/usecases/get_trending_books.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book_providers.g.dart';

@riverpod
BookRemoteDatasource bookRemoteDatasource(Ref ref) =>
    BookRemoteDatasource(ref.watch(apiClientProvider));

@riverpod
BookRepository bookRepository(Ref ref) =>
    BookRepositoryImpl(ref.watch(bookRemoteDatasourceProvider));

@riverpod
GetTrendingBooks getTrendingBooksUsecase(Ref ref) =>
    GetTrendingBooks(ref.watch(bookRepositoryProvider));

@riverpod
GetBooksBySubject getBooksBySubjectUsecase(Ref ref) =>
    GetBooksBySubject(ref.watch(bookRepositoryProvider));

@riverpod
GetBookDetails getBookDetailsUsecase(Ref ref) =>
    GetBookDetails(ref.watch(bookRepositoryProvider));

@riverpod
Future<List<Book>> trendingBooks(Ref ref, TrendingPeriod period) async {
  final usecase = ref.watch(getTrendingBooksUsecaseProvider);
  final result = await usecase(period);
  return result.when(success: (books) => books, failure: (failure) => throw failure);
}

@riverpod
Future<List<Book>> booksBySubject(Ref ref, String subject) async {
  final usecase = ref.watch(getBooksBySubjectUsecaseProvider);
  final result = await usecase(subject);
  return result.when(success: (books) => books, failure: (failure) => throw failure);
}

@riverpod
Future<BookDetails> bookDetails(Ref ref, String key) async {
  final usecase = ref.watch(getBookDetailsUsecaseProvider);
  final result = await usecase(key);
  return result.when(success: (details) => details, failure: (failure) => throw failure);
}