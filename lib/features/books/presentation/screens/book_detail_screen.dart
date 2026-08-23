import 'package:bookshelf/features/books/domain/entities/book.dart';
import 'package:bookshelf/features/books/presentation/providers/book_providers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookDetailScreen extends ConsumerWidget {
  const BookDetailScreen({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final detailsAsync = ref.watch(bookDetailsProvider(book.key));

    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  width: 180,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: AspectRatio(
                      aspectRatio: 2 / 3,
                      child: book.coverUrl != null
                          ? CachedNetworkImage(
                              imageUrl: book.coverUrl!,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  _CoverPlaceholder(theme: theme),
                            )
                          : _CoverPlaceholder(theme: theme),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(book.title, style: theme.textTheme.headlineSmall),
              if (book.authorNames.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    book.authorNames.join(', '),
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              if (book.firstPublishYear != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    'First published ${book.firstPublishYear}',
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              const SizedBox(height: 16),
              detailsAsync.when(
                data: (details) => Text(
                  details.description ?? 'No description available.',
                  style: theme.textTheme.bodyMedium,
                ),
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Text(
                  'Failed to load description.',
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CoverPlaceholder extends StatelessWidget {
  const _CoverPlaceholder({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Icon(Icons.menu_book, color: theme.colorScheme.onSurfaceVariant),
    );
  }
}
