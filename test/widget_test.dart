import 'package:bookshelf/core/error/result.dart';
import 'package:bookshelf/features/books/domain/entities/book.dart';
import 'package:bookshelf/features/books/domain/entities/book_details.dart';
import 'package:bookshelf/features/books/domain/entities/trending_period.dart';
import 'package:bookshelf/features/books/domain/repositories/book_repository.dart';
import 'package:bookshelf/features/books/presentation/providers/book_providers.dart';
import 'package:bookshelf/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeBookRepository implements BookRepository {
  @override
  Future<Result<List<Book>>> getTrendingBooks(TrendingPeriod period) async =>
      const Success([]);

  @override
  Future<Result<List<Book>>> getBooksBySubject(
    String subject, {
    int limit = 20,
  }) async => const Success([]);

  @override
  Future<Result<BookDetails>> getBookDetails(String key) async =>
      Success(BookDetails(key: key, title: ''));
}

void main() {
  testWidgets('renders home screen with trending and classic book sections', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          bookRepositoryProvider.overrideWithValue(_FakeBookRepository()),
        ],
        child: const MyApp(),
      ),
    );
    await tester.pump();

    expect(find.text('Bookshelf'), findsOneWidget);
    expect(find.text('Trending Books'), findsOneWidget);
    expect(find.text('Classic Books'), findsOneWidget);
  });
}