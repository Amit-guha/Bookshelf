import 'package:bookshelf/features/books/domain/entities/book.dart';
import 'package:bookshelf/features/books/presentation/widgets/book_cover_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A 3-column grid of [BookCoverCard]s. Renders [booksAsync]'s
/// loading/error/data states — screens pass the provider's `AsyncValue`
/// straight through rather than unwrapping it themselves.
class BookGridSection extends StatelessWidget {
  const BookGridSection({super.key, required this.booksAsync, this.onBookTap});

  final AsyncValue<List<Book>> booksAsync;
  final ValueChanged<Book>? onBookTap;

  @override
  Widget build(BuildContext context) {
    return booksAsync.when(
      data: (books) {
        if (books.isEmpty) {
          return const Center(child: Text('No books found'));
        }
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 20,
            crossAxisSpacing: 12,
            childAspectRatio: 0.6,
          ),
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
            return BookCoverCard(
              key: ValueKey(book.key),
              book: book,
              onTap: onBookTap == null ? null : () => onBookTap!(book),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) =>
          const Center(child: Text('Failed to load books')),
    );
  }
}
