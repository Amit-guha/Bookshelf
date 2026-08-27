import 'package:bookshelf/core/error/result.dart';
import 'package:bookshelf/features/books/domain/entities/book.dart';
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
  Future<Result<List<Book>>> searchBooks(String query, {int limit = 20}) async =>
      const Success([]);
}

void main() {
  testWidgets('renders home screen with trending period and genre tabs', (
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
    expect(find.text('This Week'), findsOneWidget);
    expect(find.text('This Month'), findsOneWidget);
    expect(find.text('This Year'), findsOneWidget);
    expect(find.text('All Time'), findsOneWidget);
    expect(find.text('Romance'), findsOneWidget);
    expect(find.text('Thriller'), findsOneWidget);
    expect(find.text('Fantasy'), findsOneWidget);
    expect(find.text('Mystery'), findsOneWidget);
    expect(find.text('Horror'), findsOneWidget);
    expect(find.text('Sci-Fi'), findsOneWidget);
  });
}
