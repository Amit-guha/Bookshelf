import 'package:bookshelf/features/book_details/domain/entities/book_details.dart';
import 'package:bookshelf/features/book_details/domain/entities/book_read_access.dart';
import 'package:flutter/material.dart';

/// A Play-Store-style row of rating/format/page-count stat chips. Only shows
/// the chips for fields that actually have data — returns an empty widget
/// rather than rendering placeholders for missing rating/page-count/ebook
/// info.
class BookStatsRow extends StatelessWidget {
  const BookStatsRow({super.key, required this.details, this.availability});

  final BookDetails details;
  final EbookAvailability? availability;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ratingCount = details.ratingCount;
    final averageRating = details.averageRating;
    final pageCount = details.pageCount;

    final stats = <_Stat>[
      if (ratingCount != null && ratingCount > 0 && averageRating != null)
        _Stat(
          icon: Icons.star,
          value: averageRating.toStringAsFixed(1),
          label: '$ratingCount reviews',
        ),
      if (availability != null && availability != EbookAvailability.none)
        _Stat(
          icon: Icons.menu_book,
          value: 'Ebook',
          label: availability == EbookAvailability.full ? 'Free' : 'Borrow',
        ),
      if (pageCount != null)
        _Stat(
          icon: Icons.description_outlined,
          value: '$pageCount',
          label: 'Pages',
        ),
    ];

    if (stats.isEmpty) return const SizedBox.shrink();

    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (var i = 0; i < stats.length; i++) ...[
            if (i > 0) const VerticalDivider(width: 24),
            _StatChip(stat: stats[i], theme: theme),
          ],
        ],
      ),
    );
  }
}

class _Stat {
  const _Stat({required this.icon, required this.value, required this.label});

  final IconData icon;
  final String value;
  final String label;
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.stat, required this.theme});

  final _Stat stat;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(stat.icon, size: 20, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(height: 4),
        Text(stat.value, style: theme.textTheme.titleSmall),
        Text(
          stat.label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
