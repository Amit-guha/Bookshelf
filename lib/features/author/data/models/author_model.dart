import 'package:bookshelf/core/constants/api_constants.dart';
import 'package:bookshelf/features/author/domain/entities/author.dart';

/// Maps an OpenLibrary "author" JSON response to [Author]. `bio` is
/// inconsistently either a plain string or a `{type, value}` object, same
/// as work `description`.
class AuthorModel {
  const AuthorModel({
    required this.key,
    required this.name,
    this.bio,
    this.photoUrl,
    this.birthDate,
    this.deathDate,
  });

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    final rawBio = json['bio'];
    final bio = switch (rawBio) {
      String value => value,
      Map<String, dynamic> value => value['value'] as String?,
      _ => null,
    };
    final photos = json['photos'] as List?;
    final firstPhotoId = photos != null && photos.isNotEmpty
        ? photos.first
        : null;

    return AuthorModel(
      key: json['key'] as String? ?? '',
      name: json['name'] as String? ?? '',
      bio: bio,
      photoUrl: firstPhotoId == null
          ? null
          : ApiConstants.authorPhotoUrl(firstPhotoId.toString()),
      birthDate: json['birth_date'] as String?,
      deathDate: json['death_date'] as String?,
    );
  }

  final String key;
  final String name;
  final String? bio;
  final String? photoUrl;
  final String? birthDate;
  final String? deathDate;

  Author toEntity() => Author(
    key: key,
    name: name,
    bio: bio,
    photoUrl: photoUrl,
    birthDate: birthDate,
    deathDate: deathDate,
  );
}
