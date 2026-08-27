// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bookRemoteDatasource)
final bookRemoteDatasourceProvider = BookRemoteDatasourceProvider._();

final class BookRemoteDatasourceProvider
    extends
        $FunctionalProvider<
          BookRemoteDatasource,
          BookRemoteDatasource,
          BookRemoteDatasource
        >
    with $Provider<BookRemoteDatasource> {
  BookRemoteDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookRemoteDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookRemoteDatasourceHash();

  @$internal
  @override
  $ProviderElement<BookRemoteDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BookRemoteDatasource create(Ref ref) {
    return bookRemoteDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BookRemoteDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BookRemoteDatasource>(value),
    );
  }
}

String _$bookRemoteDatasourceHash() =>
    r'e67432bb6f9bfc539daa8e92c1d6f38b3a89bbab';

@ProviderFor(bookRepository)
final bookRepositoryProvider = BookRepositoryProvider._();

final class BookRepositoryProvider
    extends $FunctionalProvider<BookRepository, BookRepository, BookRepository>
    with $Provider<BookRepository> {
  BookRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookRepositoryHash();

  @$internal
  @override
  $ProviderElement<BookRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BookRepository create(Ref ref) {
    return bookRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BookRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BookRepository>(value),
    );
  }
}

String _$bookRepositoryHash() => r'f5f13ded058d45b7885fcba7c66f8b975a1369af';

@ProviderFor(getTrendingBooksUsecase)
final getTrendingBooksUsecaseProvider = GetTrendingBooksUsecaseProvider._();

final class GetTrendingBooksUsecaseProvider
    extends
        $FunctionalProvider<
          GetTrendingBooks,
          GetTrendingBooks,
          GetTrendingBooks
        >
    with $Provider<GetTrendingBooks> {
  GetTrendingBooksUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getTrendingBooksUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getTrendingBooksUsecaseHash();

  @$internal
  @override
  $ProviderElement<GetTrendingBooks> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetTrendingBooks create(Ref ref) {
    return getTrendingBooksUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetTrendingBooks value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetTrendingBooks>(value),
    );
  }
}

String _$getTrendingBooksUsecaseHash() =>
    r'8a0b87e7b38dd26ccef1e64aa7cd6968af69b49c';

@ProviderFor(getBooksBySubjectUsecase)
final getBooksBySubjectUsecaseProvider = GetBooksBySubjectUsecaseProvider._();

final class GetBooksBySubjectUsecaseProvider
    extends
        $FunctionalProvider<
          GetBooksBySubject,
          GetBooksBySubject,
          GetBooksBySubject
        >
    with $Provider<GetBooksBySubject> {
  GetBooksBySubjectUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getBooksBySubjectUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getBooksBySubjectUsecaseHash();

  @$internal
  @override
  $ProviderElement<GetBooksBySubject> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetBooksBySubject create(Ref ref) {
    return getBooksBySubjectUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetBooksBySubject value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetBooksBySubject>(value),
    );
  }
}

String _$getBooksBySubjectUsecaseHash() =>
    r'c954c43a1d3b63299ebcba34a3eacbe0d1cdcaca';

@ProviderFor(searchBooksUsecase)
final searchBooksUsecaseProvider = SearchBooksUsecaseProvider._();

final class SearchBooksUsecaseProvider
    extends $FunctionalProvider<SearchBooks, SearchBooks, SearchBooks>
    with $Provider<SearchBooks> {
  SearchBooksUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchBooksUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchBooksUsecaseHash();

  @$internal
  @override
  $ProviderElement<SearchBooks> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SearchBooks create(Ref ref) {
    return searchBooksUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchBooks value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchBooks>(value),
    );
  }
}

String _$searchBooksUsecaseHash() =>
    r'079027e36f8e1e48a3e6217d77dbedd04090827f';

/// `keepAlive: true` — the home screen's tabs tear down their off-screen
/// widgets (TabBarView doesn't keep inactive tabs alive by default), which
/// drops this provider's only listener. Without keepAlive that would dispose
/// the cached list and force a fresh API call every time a tab is revisited.

@ProviderFor(trendingBooks)
final trendingBooksProvider = TrendingBooksFamily._();

/// `keepAlive: true` — the home screen's tabs tear down their off-screen
/// widgets (TabBarView doesn't keep inactive tabs alive by default), which
/// drops this provider's only listener. Without keepAlive that would dispose
/// the cached list and force a fresh API call every time a tab is revisited.

final class TrendingBooksProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Book>>,
          List<Book>,
          FutureOr<List<Book>>
        >
    with $FutureModifier<List<Book>>, $FutureProvider<List<Book>> {
  /// `keepAlive: true` — the home screen's tabs tear down their off-screen
  /// widgets (TabBarView doesn't keep inactive tabs alive by default), which
  /// drops this provider's only listener. Without keepAlive that would dispose
  /// the cached list and force a fresh API call every time a tab is revisited.
  TrendingBooksProvider._({
    required TrendingBooksFamily super.from,
    required TrendingPeriod super.argument,
  }) : super(
         retry: null,
         name: r'trendingBooksProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$trendingBooksHash();

  @override
  String toString() {
    return r'trendingBooksProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Book>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Book>> create(Ref ref) {
    final argument = this.argument as TrendingPeriod;
    return trendingBooks(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TrendingBooksProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$trendingBooksHash() => r'd82cf8fe97ea64026d4cfa9f7d57ce3155979b58';

/// `keepAlive: true` — the home screen's tabs tear down their off-screen
/// widgets (TabBarView doesn't keep inactive tabs alive by default), which
/// drops this provider's only listener. Without keepAlive that would dispose
/// the cached list and force a fresh API call every time a tab is revisited.

final class TrendingBooksFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Book>>, TrendingPeriod> {
  TrendingBooksFamily._()
    : super(
        retry: null,
        name: r'trendingBooksProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// `keepAlive: true` — the home screen's tabs tear down their off-screen
  /// widgets (TabBarView doesn't keep inactive tabs alive by default), which
  /// drops this provider's only listener. Without keepAlive that would dispose
  /// the cached list and force a fresh API call every time a tab is revisited.

  TrendingBooksProvider call(TrendingPeriod period) =>
      TrendingBooksProvider._(argument: period, from: this);

  @override
  String toString() => r'trendingBooksProvider';
}

@ProviderFor(booksBySubject)
final booksBySubjectProvider = BooksBySubjectFamily._();

final class BooksBySubjectProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Book>>,
          List<Book>,
          FutureOr<List<Book>>
        >
    with $FutureModifier<List<Book>>, $FutureProvider<List<Book>> {
  BooksBySubjectProvider._({
    required BooksBySubjectFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'booksBySubjectProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$booksBySubjectHash();

  @override
  String toString() {
    return r'booksBySubjectProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Book>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Book>> create(Ref ref) {
    final argument = this.argument as String;
    return booksBySubject(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is BooksBySubjectProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$booksBySubjectHash() => r'58805a4b24c1247a1935b708797717b6bffd209e';

final class BooksBySubjectFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Book>>, String> {
  BooksBySubjectFamily._()
    : super(
        retry: null,
        name: r'booksBySubjectProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  BooksBySubjectProvider call(String subject) =>
      BooksBySubjectProvider._(argument: subject, from: this);

  @override
  String toString() => r'booksBySubjectProvider';
}

/// Search-as-you-type: [search] debounces 400ms and fires nothing for an
/// empty query, rather than firing one request per keystroke.

@ProviderFor(BookSearch)
final bookSearchProvider = BookSearchProvider._();

/// Search-as-you-type: [search] debounces 400ms and fires nothing for an
/// empty query, rather than firing one request per keystroke.
final class BookSearchProvider
    extends $AsyncNotifierProvider<BookSearch, List<Book>> {
  /// Search-as-you-type: [search] debounces 400ms and fires nothing for an
  /// empty query, rather than firing one request per keystroke.
  BookSearchProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookSearchProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookSearchHash();

  @$internal
  @override
  BookSearch create() => BookSearch();
}

String _$bookSearchHash() => r'320fc404a7654de8fa600ca03b82cc736245e4b3';

/// Search-as-you-type: [search] debounces 400ms and fires nothing for an
/// empty query, rather than firing one request per keystroke.

abstract class _$BookSearch extends $AsyncNotifier<List<Book>> {
  FutureOr<List<Book>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Book>>, List<Book>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Book>>, List<Book>>,
              AsyncValue<List<Book>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
