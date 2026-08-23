import 'package:bookshelf/features/home/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

abstract class HomeRoutes {
  static const home = '/';
  static const homeName = 'home';
}

final homeRoutes = <RouteBase>[
  GoRoute(
    path: HomeRoutes.home,
    name: HomeRoutes.homeName,
    builder: (context, state) => const HomeScreen(),
  ),
];