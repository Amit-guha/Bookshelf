import 'package:bookshelf/features/books/domain/entities/book.dart';
import 'package:bookshelf/features/books/presentation/screens/book_detail_screen.dart';
import 'package:bookshelf/features/books/presentation/screens/book_reader_screen.dart';
import 'package:go_router/go_router.dart';

/// Extra payload for [BookRoutes.read] — a book's reader URL and title.
typedef BookReadArgs = ({String readerUrl, String title});

abstract class BookRoutes {
  static const detail = '/books/detail';
  static const detailName = 'book-detail';

  static const read = '/books/read';
  static const readName = 'book-read';
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
    path: BookRoutes.read,
    name: BookRoutes.readName,
    builder: (context, state) {
      final args = state.extra as BookReadArgs;
      return BookReaderScreen(readerUrl: args.readerUrl, title: args.title);
    },
  ),
];
