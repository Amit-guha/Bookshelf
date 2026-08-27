import 'package:bookshelf/core/error/result.dart';
import 'package:bookshelf/features/author/domain/entities/author.dart';

abstract class AuthorRepository {
  Future<Result<Author>> getAuthor(String key);
}
