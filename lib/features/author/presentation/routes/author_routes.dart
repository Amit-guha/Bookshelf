import 'package:bookshelf/features/author/presentation/screens/author_screen.dart';
import 'package:go_router/go_router.dart';

abstract class AuthorRoutes {
  static const detail = '/authors/detail';
  static const detailName = 'author-detail';
}

final authorRoutes = <RouteBase>[
  GoRoute(
    path: AuthorRoutes.detail,
    name: AuthorRoutes.detailName,
    builder: (context, state) {
      final authorKey = state.extra as String;
      return AuthorScreen(authorKey: authorKey);
    },
  ),
];
