import 'package:bookshelf/core/error/failure.dart';
import 'package:bookshelf/core/error/result.dart';
import 'package:bookshelf/features/author/data/datasource/author_remote_datasource.dart';
import 'package:bookshelf/features/author/data/models/author_model.dart';
import 'package:bookshelf/features/author/domain/entities/author.dart';
import 'package:bookshelf/features/author/domain/repositories/author_repository.dart';

class AuthorRepositoryImpl implements AuthorRepository {
  const AuthorRepositoryImpl(this._datasource);

  final AuthorRemoteDatasource _datasource;

  @override
  Future<Result<Author>> getAuthor(String key) async {
    try {
      final json = await _datasource.getAuthor(key);
      return Success(AuthorModel.fromJson(json).toEntity());
    } catch (e) {
      return ResultFailure(mapExceptionToFailure(e));
    }
  }
}
