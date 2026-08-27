import 'package:bookshelf/features/reader/presentation/screens/book_reader_screen.dart';
import 'package:go_router/go_router.dart';

/// Extra payload for [ReaderRoutes.read] — a URL and title to display.
typedef ReaderArgs = ({String readerUrl, String title});

abstract class ReaderRoutes {
  static const read = '/reader';
  static const readName = 'reader-read';
}

final readerRoutes = <RouteBase>[
  GoRoute(
    path: ReaderRoutes.read,
    name: ReaderRoutes.readName,
    builder: (context, state) {
      final args = state.extra as ReaderArgs;
      return BookReaderScreen(readerUrl: args.readerUrl, title: args.title);
    },
  ),
];
