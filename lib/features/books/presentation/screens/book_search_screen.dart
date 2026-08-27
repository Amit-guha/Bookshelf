import 'package:bookshelf/features/books/domain/entities/book.dart';
import 'package:bookshelf/features/books/presentation/providers/book_providers.dart';
import 'package:bookshelf/features/books/presentation/routes/book_routes.dart';
import 'package:bookshelf/features/books/presentation/widgets/book_grid_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BookSearchScreen extends ConsumerStatefulWidget {
  const BookSearchScreen({super.key});

  @override
  ConsumerState<BookSearchScreen> createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends ConsumerState<BookSearchScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchAsync = ref.watch(bookSearchProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: 'Search for books by title',
            border: InputBorder.none,
            suffixIcon: ValueListenableBuilder(
              valueListenable: _controller,
              builder: (context, value, child) => value.text.isEmpty
                  ? const SizedBox.shrink()
                  : IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _controller.clear();
                        ref.read(bookSearchProvider.notifier).search('');
                      },
                    ),
            ),
          ),
          onChanged: (query) =>
              ref.read(bookSearchProvider.notifier).search(query),
        ),
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: _controller,
          builder: (context, value, child) => value.text.trim().isEmpty
              ? const Center(child: Text('Search for books by title'))
              : BookGridSection(
                  booksAsync: searchAsync,
                  onBookTap: (book) => _openBookDetail(context, book),
                ),
        ),
      ),
    );
  }

  void _openBookDetail(BuildContext context, Book book) {
    context.pushNamed(BookRoutes.detailName, extra: book);
  }
}
