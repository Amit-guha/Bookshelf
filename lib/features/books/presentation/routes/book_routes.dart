import 'package:bookshelf/features/books/domain/entities/book.dart';
import 'package:bookshelf/features/books/presentation/screens/book_detail_screen.dart';
import 'package:bookshelf/features/books/presentation/screens/book_search_screen.dart';
import 'package:go_router/go_router.dart';

abstract class BookRoutes {
  static const detail = '/books/detail';
  static const detailName = 'book-detail';

  static const search = '/books/search';
  static const searchName = 'book-search';
}

final bookRoutes = <RouteBase>[
  GoRoute(
    path: BookRoutes.detail,
    name: BookRoutes.detailName,
    builder: (context, state) {
      final book = state.extra as Book;
      return BookDetailScreen(book: book);
    },
  ),
  GoRoute(
    path: BookRoutes.search,
    name: BookRoutes.searchName,
    builder: (context, state) => const BookSearchScreen(),
  ),
];
