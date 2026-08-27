import 'package:bookshelf/features/books/presentation/widgets/shimmer_placeholder.dart';
import 'package:flutter/material.dart';

/// Loading placeholder for the stats row + description block on
/// [BookDetailScreen], shown while `bookDetailsProvider` is loading. The
/// stats portion mirrors `BookStatsRow`'s actual chip layout (icon, value,
/// label, divided) so the skeleton's shape matches what pops in.
class BookDetailsSkeleton extends StatelessWidget {
  const BookDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerPlaceholder(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _StatChipSkeleton(),
                VerticalDivider(width: 24),
                _StatChipSkeleton(),
                VerticalDivider(width: 24),
                _StatChipSkeleton(),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const ShimmerBar(width: double.infinity, height: 14),
          const SizedBox(height: 8),
          const ShimmerBar(width: double.infinity, height: 14),
          const SizedBox(height: 8),
          const ShimmerBar(width: 180, height: 14),
        ],
      ),
    );
  }
}

/// Mirrors `_StatChip`'s icon/value/label shape from `book_stats_row.dart`.
class _StatChipSkeleton extends StatelessWidget {
  const _StatChipSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShimmerBar(width: 20, height: 20, borderRadius: 10),
        SizedBox(height: 4),
        ShimmerBar(width: 32, height: 16),
        SizedBox(height: 2),
        ShimmerBar(width: 48, height: 12),
      ],
    );
  }
}
