import 'package:bookshelf/core/network/api_client.dart';
import 'package:bookshelf/features/book_details/data/datasource/book_details_remote_datasource.dart';
import 'package:bookshelf/features/book_details/data/repositories/book_details_repository_impl.dart';
import 'package:bookshelf/features/book_details/domain/entities/book_details.dart';
import 'package:bookshelf/features/book_details/domain/entities/book_read_access.dart';
import 'package:bookshelf/features/book_details/domain/repositories/book_details_repository.dart';
import 'package:bookshelf/features/book_details/domain/usecases/get_book_details.dart';
import 'package:bookshelf/features/book_details/domain/usecases/get_book_read_access.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book_details_providers.g.dart';

@riverpod
BookDetailsRemoteDatasource bookDetailsRemoteDatasource(Ref ref) =>
    BookDetailsRemoteDatasource(ref.watch(apiClientProvider));

@riverpod
BookDetailsRepository bookDetailsRepository(Ref ref) =>
    BookDetailsRepositoryImpl(ref.watch(bookDetailsRemoteDatasourceProvider));

@riverpod
GetBookDetails getBookDetailsUsecase(Ref ref) =>
    GetBookDetails(ref.watch(bookDetailsRepositoryProvider));

@riverpod
GetBookReadAccess getBookReadAccessUsecase(Ref ref) =>
    GetBookReadAccess(ref.watch(bookDetailsRepositoryProvider));

@riverpod
Future<BookDetails> bookDetails(
  Ref ref,
  String workKey, {
  String? editionKey,
}) async {
  final usecase = ref.watch(getBookDetailsUsecaseProvider);
  final result = await usecase(workKey, editionKey: editionKey);
  return result.when(success: (details) => details, failure: (failure) => throw failure);
}

@riverpod
Future<BookReadAccess> bookReadAccess(Ref ref, String editionKey) async {
  final usecase = ref.watch(getBookReadAccessUsecaseProvider);
  final result = await usecase(editionKey);
  return result.when(success: (access) => access, failure: (failure) => throw failure);
}
