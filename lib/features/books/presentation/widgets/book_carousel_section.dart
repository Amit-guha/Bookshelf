import 'package:bookshelf/features/books/domain/entities/book.dart';
import 'package:bookshelf/features/books/presentation/widgets/book_cover_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A titled, horizontally-scrolling row of [BookCoverCard]s. Renders
/// [booksAsync]'s loading/error/data states — screens pass the provider's
/// `AsyncValue` straight through rather than unwrapping it themselves.
class BookCarouselSection extends StatelessWidget {
  const BookCarouselSection({
    super.key,
    required this.title,
    required this.booksAsync,
    this.onBookTap,
  });

  final String title;
  final AsyncValue<List<Book>> booksAsync;
  final ValueChanged<Book>? onBookTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        ),
        const SizedBox(height: 12),
        SizedBox(height: 260, child: _buildBody(context)),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return booksAsync.when(
      data: (books) {
        if (books.isEmpty) {
          return const Center(child: Text('No books found'));
        }
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: books.length,
          separatorBuilder: (context, index) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final book = books[index];
            return BookCoverCard(
              book: book,
              onTap: onBookTap == null ? null : () => onBookTap!(book),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Text(
          'Failed to load $title',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}