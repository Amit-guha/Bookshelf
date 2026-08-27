import 'package:bookshelf/core/error/result.dart';
import 'package:bookshelf/features/author/domain/entities/author.dart';
import 'package:bookshelf/features/author/domain/repositories/author_repository.dart';

class GetAuthor {
  const GetAuthor(this._repository);

  final AuthorRepository _repository;

  Future<Result<Author>> call(String key) => _repository.getAuthor(key);
}
