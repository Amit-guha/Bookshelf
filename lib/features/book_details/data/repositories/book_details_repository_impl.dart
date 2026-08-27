import 'package:bookshelf/core/error/failure.dart';
import 'package:bookshelf/core/error/result.dart';
import 'package:bookshelf/features/book_details/data/datasource/book_details_remote_datasource.dart';
import 'package:bookshelf/features/book_details/data/models/book_details_model.dart';
import 'package:bookshelf/features/book_details/data/models/book_read_access_model.dart';
import 'package:bookshelf/features/book_details/domain/entities/book_details.dart';
import 'package:bookshelf/features/book_details/domain/entities/book_read_access.dart';
import 'package:bookshelf/features/book_details/domain/repositories/book_details_repository.dart';

class BookDetailsRepositoryImpl implements BookDetailsRepository {
  const BookDetailsRepositoryImpl(this._datasource);

  final BookDetailsRemoteDatasource _datasource;

  @override
  Future<Result<BookDetails>> getBookDetails(
    String workKey, {
    String? editionKey,
  }) async {
    try {
      final workJson = await _datasource.getBookDetails(workKey);
      final ratingsJson = await _safeFetch(
        () => _datasource.getRatings(workKey),
      );
      final editionJson = editionKey == null
          ? null
          : await _safeFetch(() => _datasource.getEditionDetails(editionKey));
      return Success(
        BookDetailsModel.fromJson(
          workJson: workJson,
          ratingsJson: ratingsJson,
          editionJson: editionJson,
        ).toEntity(),
      );
    } catch (e) {
      return ResultFailure(mapExceptionToFailure(e));
    }
  }

  /// Ratings/edition lookups are supplementary — if either fails (e.g. no
  /// ratings yet for a work), the core detail load shouldn't fail with it.
  Future<Map<String, dynamic>?> _safeFetch(
    Future<Map<String, dynamic>> Function() fetch,
  ) async {
    try {
      return await fetch();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Result<BookReadAccess>> getReadAccess(String editionKey) async {
    try {
      final json = await _datasource.getReadAccess(editionKey);
      return Success(BookReadAccessModel.fromJson(json).toEntity());
    } catch (e) {
      return ResultFailure(mapExceptionToFailure(e));
    }
  }
}
