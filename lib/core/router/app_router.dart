import 'package:bookshelf/features/books/presentation/routes/book_routes.dart';
import 'package:bookshelf/features/home/presentation/routes/home_routes.dart';
import 'package:bookshelf/features/reader/presentation/routes/reader_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@riverpod
GoRouter goRouter(Ref ref) {
  return GoRouter(routes: [...homeRoutes, ...bookRoutes, ...readerRoutes]);
}