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

@ProviderFor(getBookDetailsUsecase)
final getBookDetailsUsecaseProvider = GetBookDetailsUsecaseProvider._();

final class GetBookDetailsUsecaseProvider
    extends $FunctionalProvider<GetBookDetails, GetBookDetails, GetBookDetails>
    with $Provider<GetBookDetails> {
  GetBookDetailsUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getBookDetailsUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getBookDetailsUsecaseHash();

  @$internal
  @override
  $ProviderElement<GetBookDetails> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetBookDetails create(Ref ref) {
    return getBookDetailsUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetBookDetails value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetBookDetails>(value),
    );
  }
}

String _$getBookDetailsUsecaseHash() =>
    r'8e7283fa056c692e896f687055deff712d577d51';

@ProviderFor(trendingBooks)
final trendingBooksProvider = TrendingBooksFamily._();

final class TrendingBooksProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Book>>,
          List<Book>,
          FutureOr<List<Book>>
        >
    with $FutureModifier<List<Book>>, $FutureProvider<List<Book>> {
  TrendingBooksProvider._({
    required TrendingBooksFamily super.from,
    required TrendingPeriod super.argument,
  }) : super(
         retry: null,
         name: r'trendingBooksProvider',
         isAutoDispose: true,
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

String _$trendingBooksHash() => r'7e66ed655e88cafb4b03846c373c2304aab1db72';

final class TrendingBooksFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Book>>, TrendingPeriod> {
  TrendingBooksFamily._()
    : super(
        retry: null,
        name: r'trendingBooksProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

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
         isAutoDispose: true,
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

String _$booksBySubjectHash() => r'2aea1e4e751ebb4e7c4328b68a8f7d23d0b677fc';

final class BooksBySubjectFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Book>>, String> {
  BooksBySubjectFamily._()
    : super(
        retry: null,
        name: r'booksBySubjectProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BooksBySubjectProvider call(String subject) =>
      BooksBySubjectProvider._(argument: subject, from: this);

  @override
  String toString() => r'booksBySubjectProvider';
}

@ProviderFor(bookDetails)
final bookDetailsProvider = BookDetailsFamily._();

final class BookDetailsProvider
    extends
        $FunctionalProvider<
          AsyncValue<BookDetails>,
          BookDetails,
          FutureOr<BookDetails>
        >
    with $FutureModifier<BookDetails>, $FutureProvider<BookDetails> {
  BookDetailsProvider._({
    required BookDetailsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'bookDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bookDetailsHash();

  @override
  String toString() {
    return r'bookDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<BookDetails> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<BookDetails> create(Ref ref) {
    final argument = this.argument as String;
    return bookDetails(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is BookDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bookDetailsHash() => r'999b98bb3685fdf6ff6b45deb48068ee3f8b2fde';

final class BookDetailsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<BookDetails>, String> {
  BookDetailsFamily._()
    : super(
        retry: null,
        name: r'bookDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BookDetailsProvider call(String key) =>
      BookDetailsProvider._(argument: key, from: this);

  @override
  String toString() => r'bookDetailsProvider';
}
