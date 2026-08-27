// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authorRemoteDatasource)
final authorRemoteDatasourceProvider = AuthorRemoteDatasourceProvider._();

final class AuthorRemoteDatasourceProvider
    extends
        $FunctionalProvider<
          AuthorRemoteDatasource,
          AuthorRemoteDatasource,
          AuthorRemoteDatasource
        >
    with $Provider<AuthorRemoteDatasource> {
  AuthorRemoteDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authorRemoteDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authorRemoteDatasourceHash();

  @$internal
  @override
  $ProviderElement<AuthorRemoteDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AuthorRemoteDatasource create(Ref ref) {
    return authorRemoteDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthorRemoteDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthorRemoteDatasource>(value),
    );
  }
}

String _$authorRemoteDatasourceHash() =>
    r'60336a7515b6776823570e839bd7e3ef9ef3d5e1';

@ProviderFor(authorRepository)
final authorRepositoryProvider = AuthorRepositoryProvider._();

final class AuthorRepositoryProvider
    extends
        $FunctionalProvider<
          AuthorRepository,
          AuthorRepository,
          AuthorRepository
        >
    with $Provider<AuthorRepository> {
  AuthorRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authorRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authorRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthorRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthorRepository create(Ref ref) {
    return authorRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthorRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthorRepository>(value),
    );
  }
}

String _$authorRepositoryHash() => r'6ed403beba7cbd1dee4c190138b405651f6338f3';

@ProviderFor(getAuthorUsecase)
final getAuthorUsecaseProvider = GetAuthorUsecaseProvider._();

final class GetAuthorUsecaseProvider
    extends $FunctionalProvider<GetAuthor, GetAuthor, GetAuthor>
    with $Provider<GetAuthor> {
  GetAuthorUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getAuthorUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getAuthorUsecaseHash();

  @$internal
  @override
  $ProviderElement<GetAuthor> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetAuthor create(Ref ref) {
    return getAuthorUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetAuthor value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetAuthor>(value),
    );
  }
}

String _$getAuthorUsecaseHash() => r'd8158e6513cc34c6a23356fac0fff16f01598b40';

@ProviderFor(author)
final authorProvider = AuthorFamily._();

final class AuthorProvider
    extends $FunctionalProvider<AsyncValue<Author>, Author, FutureOr<Author>>
    with $FutureModifier<Author>, $FutureProvider<Author> {
  AuthorProvider._({
    required AuthorFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'authorProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$authorHash();

  @override
  String toString() {
    return r'authorProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Author> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Author> create(Ref ref) {
    final argument = this.argument as String;
    return author(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AuthorProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$authorHash() => r'a174164ebede829233746a4677a88eb04d4f5dd8';

final class AuthorFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Author>, String> {
  AuthorFamily._()
    : super(
        retry: null,
        name: r'authorProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AuthorProvider call(String key) =>
      AuthorProvider._(argument: key, from: this);

  @override
  String toString() => r'authorProvider';
}
