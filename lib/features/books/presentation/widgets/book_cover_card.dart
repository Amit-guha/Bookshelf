import 'package:bookshelf/features/books/domain/entities/book.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BookCoverCard extends StatelessWidget {
  const BookCoverCard({super.key, required this.book, this.onTap});

  final Book book;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final coverUrl = book.coverUrl;

    return SizedBox(
      width: 120,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: coverUrl != null
                    ? CachedNetworkImage(
                        imageUrl: coverUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        // Cards render at ~120 logical px wide — cap the
                        // decoded bitmap size so scrolling doesn't decode
                        // each cover at its full downloaded resolution.
                        memCacheWidth: 240,
                        placeholder: (context, url) =>
                            const _CoverPlaceholder(),
                        errorWidget: (context, url, error) =>
                            const _CoverPlaceholder(),
                      )
                    : const _CoverPlaceholder(),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              book.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium,
            ),
            if (book.authorNames.isNotEmpty)
              Text(
                book.authorNames.first,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CoverPlaceholder extends StatelessWidget {
  const _CoverPlaceholder();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Icon(
        Icons.menu_book,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}