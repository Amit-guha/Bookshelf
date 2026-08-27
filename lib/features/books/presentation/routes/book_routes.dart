import 'package:bookshelf/features/books/presentation/screens/book_search_screen.dart';
import 'package:go_router/go_router.dart';

abstract class BookRoutes {
  static const search = '/books/search';
  static const searchName = 'book-search';
}

final bookRoutes = <RouteBase>[
  GoRoute(
    path: BookRoutes.search,
    name: BookRoutes.searchName,
    builder: (context, state) => const BookSearchScreen(),
  ),
];
