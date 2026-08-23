import 'package:bookshelf/features/books/domain/entities/book.dart';
import 'package:bookshelf/features/books/domain/entities/trending_period.dart';
import 'package:bookshelf/features/books/presentation/providers/book_providers.dart';
import 'package:bookshelf/features/books/presentation/routes/book_routes.dart';
import 'package:bookshelf/features/books/presentation/widgets/book_carousel_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trendingBooksAsync = ref.watch(
      trendingBooksProvider(TrendingPeriod.daily),
    );
    final classicBooksAsync = ref.watch(booksBySubjectProvider('classics'));

    return Scaffold(
      appBar: AppBar(title: const Text('Bookshelf')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            BookCarouselSection(
              title: 'Trending Books',
              booksAsync: trendingBooksAsync,
              onBookTap: (book) => _openBookDetail(context, book),
            ),
            const SizedBox(height: 24),
            BookCarouselSection(
              title: 'Classic Books',
              booksAsync: classicBooksAsync,
              onBookTap: (book) => _openBookDetail(context, book),
            ),
          ],
        ),
      ),
    );
  }

  void _openBookDetail(BuildContext context, Book book) {
    context.pushNamed(BookRoutes.detailName, extra: book);
  }
}