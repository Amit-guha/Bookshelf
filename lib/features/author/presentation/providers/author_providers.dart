import 'package:bookshelf/core/network/api_client.dart';
import 'package:bookshelf/features/author/data/datasource/author_remote_datasource.dart';
import 'package:bookshelf/features/author/data/repositories/author_repository_impl.dart';
import 'package:bookshelf/features/author/domain/entities/author.dart';
import 'package:bookshelf/features/author/domain/repositories/author_repository.dart';
import 'package:bookshelf/features/author/domain/usecases/get_author.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'author_providers.g.dart';

@riverpod
AuthorRemoteDatasource authorRemoteDatasource(Ref ref) =>
    AuthorRemoteDatasource(ref.watch(apiClientProvider));

@riverpod
AuthorRepository authorRepository(Ref ref) =>
    AuthorRepositoryImpl(ref.watch(authorRemoteDatasourceProvider));

@riverpod
GetAuthor getAuthorUsecase(Ref ref) =>
    GetAuthor(ref.watch(authorRepositoryProvider));

@riverpod
Future<Author> author(Ref ref, String key) async {
  final usecase = ref.watch(getAuthorUsecaseProvider);
  final result = await usecase(key);
  return result.when(success: (author) => author, failure: (failure) => throw failure);
}
