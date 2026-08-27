import 'package:bookshelf/core/widgets/shimmer_placeholder.dart';
import 'package:bookshelf/features/author/domain/entities/author.dart';
import 'package:bookshelf/features/author/presentation/providers/author_providers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthorScreen extends ConsumerWidget {
  const AuthorScreen({super.key, required this.authorKey});

  final String authorKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authorAsync = ref.watch(authorProvider(authorKey));

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: authorAsync.when(
            data: (author) => _AuthorContent(author: author),
            loading: () => const _AuthorSkeleton(),
            error: (error, stackTrace) =>
                const Text('Failed to load author.'),
          ),
        ),
      ),
    );
  }
}

class _AuthorContent extends StatelessWidget {
  const _AuthorContent({required this.author});

  final Author author;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final photoUrl = author.photoUrl;
    final dateRange = _dateRange(author);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipOval(
          child: SizedBox(
            width: 120,
            height: 120,
            child: photoUrl != null
                ? CachedNetworkImage(
                    imageUrl: photoUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const ShimmerPlaceholder(
                      child: ShimmerBar(
                        width: double.infinity,
                        height: double.infinity,
                        borderRadius: 0,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        _AuthorPhotoPlaceholder(theme: theme),
                  )
                : _AuthorPhotoPlaceholder(theme: theme),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          author.name,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        if (dateRange != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              dateRange,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            author.bio ?? 'No biography available.',
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  String? _dateRange(Author author) {
    final birth = author.birthDate;
    final death = author.deathDate;
    if (birth == null && death == null) return null;
    if (birth != null && death != null) return '$birth – $death';
    return birth ?? death;
  }
}

class _AuthorSkeleton extends StatelessWidget {
  const _AuthorSkeleton();

  @override
  Widget build(BuildContext context) {
    return ShimmerPlaceholder(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ClipOval(
            child: ShimmerBar(width: 120, height: 120, borderRadius: 0),
          ),
          const SizedBox(height: 16),
          const ShimmerBar(width: 160, height: 20),
          const SizedBox(height: 20),
          const ShimmerBar(width: double.infinity, height: 14),
          const SizedBox(height: 8),
          const ShimmerBar(width: double.infinity, height: 14),
          const SizedBox(height: 8),
          const ShimmerBar(width: 200, height: 14),
        ],
      ),
    );
  }
}

class _AuthorPhotoPlaceholder extends StatelessWidget {
  const _AuthorPhotoPlaceholder({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Icon(Icons.person, color: theme.colorScheme.onSurfaceVariant),
    );
  }
}
