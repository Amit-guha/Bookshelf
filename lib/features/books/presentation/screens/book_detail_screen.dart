import 'package:bookshelf/features/books/domain/entities/book.dart';
import 'package:bookshelf/features/books/domain/entities/book_read_access.dart';
import 'package:bookshelf/features/books/presentation/providers/book_providers.dart';
import 'package:bookshelf/features/books/presentation/routes/book_routes.dart';
import 'package:bookshelf/features/books/presentation/widgets/book_details_skeleton.dart';
import 'package:bookshelf/features/books/presentation/widgets/book_detail_header.dart';
import 'package:bookshelf/features/books/presentation/widgets/book_read_access_button.dart';
import 'package:bookshelf/features/books/presentation/widgets/book_stats_row.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetailScreen extends ConsumerWidget {
  const BookDetailScreen({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final editionKey = book.editionKey;
    final detailsAsync = ref.watch(
      bookDetailsProvider(book.key, editionKey: editionKey),
    );
    final readAccessAsync = editionKey == null
        ? null
        : ref.watch(bookReadAccessProvider(editionKey));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: theme.colorScheme.onSurface,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookDetailHeader(book: book),
              const SizedBox(height: 20),
              if (readAccessAsync != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: BookReadAccessButton(
                    readAccessAsync: readAccessAsync,
                    onRead: () => _openReader(context, readAccessAsync.value),
                    onOpenArchive: () =>
                        _openArchivePage(readAccessAsync.value),
                  ),
                ),
              detailsAsync.when(
                data: (details) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: BookStatsRow(
                        details: details,
                        availability: readAccessAsync?.value?.availability,
                      ),
                    ),
                    Text(
                      details.description ?? 'No description available.',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
                loading: () => const BookDetailsSkeleton(),
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

  /// `webview_flutter` has no Flutter Web implementation, so on web the
  /// in-app reader falls back to opening Internet Archive's reader in a new
  /// browser tab instead.
  void _openReader(BuildContext context, BookReadAccess? access) {
    final readerUrl = access?.readerUrl;
    if (readerUrl == null) return;
    if (kIsWeb) {
      launchUrl(Uri.parse(readerUrl), mode: LaunchMode.externalApplication);
      return;
    }
    context.pushNamed(
      BookRoutes.readName,
      extra: (readerUrl: readerUrl, title: book.title),
    );
  }

  void _openArchivePage(BookReadAccess? access) {
    final previewUrl = access?.previewUrl;
    if (previewUrl == null) return;
    launchUrl(Uri.parse(previewUrl), mode: LaunchMode.externalApplication);
  }
}
