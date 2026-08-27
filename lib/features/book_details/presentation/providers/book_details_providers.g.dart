// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_details_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bookDetailsRemoteDatasource)
final bookDetailsRemoteDatasourceProvider =
    BookDetailsRemoteDatasourceProvider._();

final class BookDetailsRemoteDatasourceProvider
    extends
        $FunctionalProvider<
          BookDetailsRemoteDatasource,
          BookDetailsRemoteDatasource,
          BookDetailsRemoteDatasource
        >
    with $Provider<BookDetailsRemoteDatasource> {
  BookDetailsRemoteDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookDetailsRemoteDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookDetailsRemoteDatasourceHash();

  @$internal
  @override
  $ProviderElement<BookDetailsRemoteDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BookDetailsRemoteDatasource create(Ref ref) {
    return bookDetailsRemoteDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BookDetailsRemoteDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BookDetailsRemoteDatasource>(value),
    );
  }
}

String _$bookDetailsRemoteDatasourceHash() =>
    r'6b66b94bd75c7e9c095e8de91d3d8af2555d9635';

@ProviderFor(bookDetailsRepository)
final bookDetailsRepositoryProvider = BookDetailsRepositoryProvider._();

final class BookDetailsRepositoryProvider
    extends
        $FunctionalProvider<
          BookDetailsRepository,
          BookDetailsRepository,
          BookDetailsRepository
        >
    with $Provider<BookDetailsRepository> {
  BookDetailsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookDetailsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookDetailsRepositoryHash();

  @$internal
  @override
  $ProviderElement<BookDetailsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BookDetailsRepository create(Ref ref) {
    return bookDetailsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BookDetailsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BookDetailsRepository>(value),
    );
  }
}

String _$bookDetailsRepositoryHash() =>
    r'1278b31cee4b646b3a502db10f7b1c314a4ddaec';

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
    r'e44bb874165472a47eb243af5dbdbdffca609349';

@ProviderFor(getBookReadAccessUsecase)
final getBookReadAccessUsecaseProvider = GetBookReadAccessUsecaseProvider._();

final class GetBookReadAccessUsecaseProvider
    extends
        $FunctionalProvider<
          GetBookReadAccess,
          GetBookReadAccess,
          GetBookReadAccess
        >
    with $Provider<GetBookReadAccess> {
  GetBookReadAccessUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getBookReadAccessUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getBookReadAccessUsecaseHash();

  @$internal
  @override
  $ProviderElement<GetBookReadAccess> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetBookReadAccess create(Ref ref) {
    return getBookReadAccessUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetBookReadAccess value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetBookReadAccess>(value),
    );
  }
}

String _$getBookReadAccessUsecaseHash() =>
    r'fa7649cd061b081a6d9533677c00e8d93e884788';

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
    required (String, {String? editionKey}) super.argument,
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
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<BookDetails> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<BookDetails> create(Ref ref) {
    final argument = this.argument as (String, {String? editionKey});
    return bookDetails(ref, argument.$1, editionKey: argument.editionKey);
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

String _$bookDetailsHash() => r'43cffcb643516a21e919271c8b39466a33465e24';

final class BookDetailsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<BookDetails>,
          (String, {String? editionKey})
        > {
  BookDetailsFamily._()
    : super(
        retry: null,
        name: r'bookDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BookDetailsProvider call(String workKey, {String? editionKey}) =>
      BookDetailsProvider._(
        argument: (workKey, editionKey: editionKey),
        from: this,
      );

  @override
  String toString() => r'bookDetailsProvider';
}

@ProviderFor(bookReadAccess)
final bookReadAccessProvider = BookReadAccessFamily._();

final class BookReadAccessProvider
    extends
        $FunctionalProvider<
          AsyncValue<BookReadAccess>,
          BookReadAccess,
          FutureOr<BookReadAccess>
        >
    with $FutureModifier<BookReadAccess>, $FutureProvider<BookReadAccess> {
  BookReadAccessProvider._({
    required BookReadAccessFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'bookReadAccessProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bookReadAccessHash();

  @override
  String toString() {
    return r'bookReadAccessProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<BookReadAccess> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<BookReadAccess> create(Ref ref) {
    final argument = this.argument as String;
    return bookReadAccess(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is BookReadAccessProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bookReadAccessHash() => r'f7b115d65fe25920daf520abc86c041c6e765b94';

final class BookReadAccessFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<BookReadAccess>, String> {
  BookReadAccessFamily._()
    : super(
        retry: null,
        name: r'bookReadAccessProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BookReadAccessProvider call(String editionKey) =>
      BookReadAccessProvider._(argument: editionKey, from: this);

  @override
  String toString() => r'bookReadAccessProvider';
}
