import 'dart:async';

import 'package:bookshelf/core/network/api_client.dart';
import 'package:bookshelf/features/books/data/datasource/book_remote_datasource.dart';
import 'package:bookshelf/features/books/data/repositories/book_repository_impl.dart';
import 'package:bookshelf/features/books/domain/entities/book.dart';
import 'package:bookshelf/features/books/domain/entities/trending_period.dart';
import 'package:bookshelf/features/books/domain/repositories/book_repository.dart';
import 'package:bookshelf/features/books/domain/usecases/get_books_by_subject.dart';
import 'package:bookshelf/features/books/domain/usecases/get_trending_books.dart';
import 'package:bookshelf/features/books/domain/usecases/search_books.dart';
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
SearchBooks searchBooksUsecase(Ref ref) =>
    SearchBooks(ref.watch(bookRepositoryProvider));

/// `keepAlive: true` — the home screen's tabs tear down their off-screen
/// widgets (TabBarView doesn't keep inactive tabs alive by default), which
/// drops this provider's only listener. Without keepAlive that would dispose
/// the cached list and force a fresh API call every time a tab is revisited.
@Riverpod(keepAlive: true)
Future<List<Book>> trendingBooks(Ref ref, TrendingPeriod period) async {
  final usecase = ref.watch(getTrendingBooksUsecaseProvider);
  final result = await usecase(period);
  return result.when(success: (books) => books, failure: (failure) => throw failure);
}

@Riverpod(keepAlive: true)
Future<List<Book>> booksBySubject(Ref ref, String subject) async {
  final usecase = ref.watch(getBooksBySubjectUsecaseProvider);
  final result = await usecase(subject);
  return result.when(success: (books) => books, failure: (failure) => throw failure);
}

/// Search-as-you-type: [search] debounces 400ms and fires nothing for an
/// empty query, rather than firing one request per keystroke.
@riverpod
class BookSearch extends _$BookSearch {
  Timer? _debounce;

  @override
  Future<List<Book>> build() async {
    ref.onDispose(() => _debounce?.cancel());
    return const [];
  }

  void search(String query) {
    _debounce?.cancel();
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      state = const AsyncData([]);
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 400), () async {
      state = const AsyncLoading();
      final usecase = ref.read(searchBooksUsecaseProvider);
      final result = await usecase(trimmed);
      state = result.when(
        success: AsyncData.new,
        failure: (failure) => AsyncError(failure, StackTrace.current),
      );
    });
  }
}
