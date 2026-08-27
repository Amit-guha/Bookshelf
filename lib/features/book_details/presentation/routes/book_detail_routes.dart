import 'package:bookshelf/features/book_details/presentation/screens/book_detail_screen.dart';
import 'package:bookshelf/features/books/domain/entities/book.dart';
import 'package:go_router/go_router.dart';

abstract class BookDetailRoutes {
  static const detail = '/books/detail';
  static const detailName = 'book-detail';
}

final bookDetailRoutes = <RouteBase>[
  GoRoute(
    path: BookDetailRoutes.detail,
    name: BookDetailRoutes.detailName,
    builder: (context, state) {
      final book = state.extra as Book;
      return BookDetailScreen(book: book);
    },
  ),
];
