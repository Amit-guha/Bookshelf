import 'package:bookshelf/features/books/domain/entities/book.dart';
import 'package:bookshelf/features/books/domain/entities/trending_period.dart';
import 'package:bookshelf/features/books/presentation/providers/book_providers.dart';
import 'package:bookshelf/features/books/presentation/routes/book_routes.dart';
import 'package:bookshelf/features/books/presentation/widgets/book_grid_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _periodTabs = <(String label, TrendingPeriod period)>[
    ('This Week', TrendingPeriod.weekly),
    ('This Month', TrendingPeriod.monthly),
    ('This Year', TrendingPeriod.yearly),
    ('All Time', TrendingPeriod.forever),
  ];

  /// Genre tabs — subject slugs recognized by OpenLibrary's Subjects API
  /// (`/subjects/{slug}.json`), fetched live via [booksBySubjectProvider].
  static const _genreTabs = <(String label, String subject)>[
    ('Romance', 'romance'),
    ('Thriller', 'thriller'),
    ('Fantasy', 'fantasy'),
    ('Mystery', 'mystery'),
    ('Horror', 'horror'),
    ('Sci-Fi', 'science_fiction'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _periodTabs.length + _genreTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bookshelf'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => context.pushNamed(BookRoutes.searchName),
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: [
              for (final tab in _genreTabs) Tab(text: tab.$1),
              for (final tab in _periodTabs) Tab(text: tab.$1),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              for (final tab in _genreTabs) _GenreGrid(subject: tab.$2),
              for (final tab in _periodTabs) _TrendingGrid(period: tab.$2),
            ],
          ),
        ),
      ),
    );
  }
}

class _TrendingGrid extends ConsumerWidget {
  const _TrendingGrid({required this.period});

  final TrendingPeriod period;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksAsync = ref.watch(trendingBooksProvider(period));
    return BookGridSection(
      booksAsync: booksAsync,
      onBookTap: (book) => _openBookDetail(context, book),
    );
  }
}

class _GenreGrid extends ConsumerWidget {
  const _GenreGrid({required this.subject});

  final String subject;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksAsync = ref.watch(booksBySubjectProvider(subject));
    return BookGridSection(
      booksAsync: booksAsync,
      onBookTap: (book) => _openBookDetail(context, book),
    );
  }
}

void _openBookDetail(BuildContext context, Book book) {
  context.pushNamed(BookRoutes.detailName, extra: book);
}
