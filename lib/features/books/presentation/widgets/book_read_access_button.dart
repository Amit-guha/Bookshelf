import 'package:bookshelf/features/books/domain/entities/book_read_access.dart';
import 'package:bookshelf/features/books/presentation/widgets/shimmer_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Renders [readAccessAsync]'s loading/error/data states as pill-shaped
/// action buttons — screens pass the provider's `AsyncValue` straight
/// through rather than unwrapping it themselves.
///
/// A freely-readable ("full") book shows both "Read now" (in-app) and "View
/// on Archive.org" (external, when a preview URL is also available); a
/// borrowable/restricted book shows a single "Borrow on Archive.org" button.
/// [onOpenArchive] backs both the "View on Archive.org" and "Borrow on
/// Archive.org" buttons — same action, opening `previewUrl` externally.
class BookReadAccessButton extends StatelessWidget {
  const BookReadAccessButton({
    super.key,
    required this.readAccessAsync,
    required this.onRead,
    required this.onOpenArchive,
  });

  final AsyncValue<BookReadAccess> readAccessAsync;
  final VoidCallback onRead;
  final VoidCallback onOpenArchive;

  static const _shape = StadiumBorder();

  @override
  Widget build(BuildContext context) {
    return readAccessAsync.when(
      data: (access) => switch (access.availability) {
        EbookAvailability.full when access.readerUrl != null => Row(
          children: [
            Expanded(
              child: FilledButton.icon(
                style: FilledButton.styleFrom(shape: _shape),
                onPressed: onRead,
                icon: const Icon(Icons.menu_book),
                label: const Text('Read now'),
              ),
            ),
            if (access.previewUrl != null) ...[
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(shape: _shape),
                  onPressed: onOpenArchive,
                  icon: const Icon(Icons.open_in_new),
                  label: const Text('View on Archive.org'),
                ),
              ),
            ],
          ],
        ),
        EbookAvailability.borrowable ||
        EbookAvailability.restricted when access.previewUrl != null =>
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(shape: _shape),
              onPressed: onOpenArchive,
              icon: const Icon(Icons.open_in_new),
              label: const Text('Borrow on Archive.org'),
            ),
          ),
        _ => const SizedBox.shrink(),
      },
      loading: () => const ShimmerPlaceholder(
        child: ShimmerBar(width: double.infinity, height: 48, borderRadius: 24),
      ),
      error: (error, stackTrace) => const SizedBox.shrink(),
    );
  }
}
