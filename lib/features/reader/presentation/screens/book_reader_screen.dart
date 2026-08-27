import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BookReaderScreen extends ConsumerStatefulWidget {
  const BookReaderScreen({
    super.key,
    required this.readerUrl,
    required this.title,
  });

  final String readerUrl;
  final String title;

  @override
  ConsumerState<BookReaderScreen> createState() => _BookReaderScreenState();
}

class _BookReaderScreenState extends ConsumerState<BookReaderScreen> {
  late final WebViewController _controller;

  /// 0-100, or null once the page finishes loading — Internet Archive's
  /// reader is a heavy JS app, so this can take a few seconds and the
  /// WebView would otherwise sit blank with no feedback.
  int? _loadProgress = 0;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) => setState(() => _loadProgress = progress),
          onPageFinished: (_) => setState(() => _loadProgress = null),
        ),
      )
      ..loadRequest(Uri.parse(widget.readerUrl));
  }

  @override
  Widget build(BuildContext context) {
    final loadProgress = _loadProgress;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: loadProgress == null
            ? null
            : PreferredSize(
                preferredSize: const Size.fromHeight(2),
                child: LinearProgressIndicator(value: loadProgress / 100),
              ),
      ),
      body: SafeArea(child: WebViewWidget(controller: _controller)),
    );
  }
}
