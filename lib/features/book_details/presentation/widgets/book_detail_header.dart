import 'package:bookshelf/core/widgets/shimmer_placeholder.dart';
import 'package:bookshelf/features/books/domain/entities/book.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Cover + title/author/publish-year row for [BookDetailScreen]'s header.
class BookDetailHeader extends StatelessWidget {
  const BookDetailHeader({super.key, required this.book, this.onAuthorTap});

  final Book book;

  /// Called with [book.authorKey] when the author name is tapped — only
  /// wired up when that key is non-null, so a book with no resolvable
  /// author doesn't show a dead tap target.
  final ValueChanged<String>? onAuthorTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AspectRatio(
              aspectRatio: 2 / 3,
              child: book.coverUrl != null
                  ? CachedNetworkImage(
                      imageUrl: book.coverUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const ShimmerPlaceholder(
                        child: ShimmerBar(
                          width: double.infinity,
                          height: double.infinity,
                          borderRadius: 0,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          _CoverPlaceholder(theme: theme),
                    )
                  : _CoverPlaceholder(theme: theme),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                book.title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (book.authorNames.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: _AuthorName(
                    text: book.authorNames.join(', '),
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                    onTap: book.authorKey == null
                        ? null
                        : () => onAuthorTap?.call(book.authorKey!),
                  ),
                ),
              if (book.firstPublishYear != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    'First published ${book.firstPublishYear}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AuthorName extends StatelessWidget {
  const _AuthorName({required this.text, this.style, this.onTap});

  final String text;
  final TextStyle? style;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Text(text, style: style);
    if (onTap == null) return content;
    return GestureDetector(onTap: onTap, child: content);
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
