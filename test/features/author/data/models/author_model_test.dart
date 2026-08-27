import 'package:bookshelf/features/author/data/models/author_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthorModel.fromJson', () {
    test('maps a plain-string bio and a photo', () {
      final model = AuthorModel.fromJson(const {
        'key': '/authors/OL79034A',
        'name': 'Frank Herbert',
        'bio': 'An American science-fiction author.',
        'birth_date': '8 October 1920',
        'death_date': '11 February 1986',
        'photos': [14852808, 14852807],
      });

      expect(model.key, '/authors/OL79034A');
      expect(model.name, 'Frank Herbert');
      expect(model.bio, 'An American science-fiction author.');
      expect(model.birthDate, '8 October 1920');
      expect(model.deathDate, '11 February 1986');
      expect(
        model.photoUrl,
        'https://covers.openlibrary.org/a/id/14852808-M.jpg',
      );
    });

    test('handles a {type, value} bio object', () {
      final model = AuthorModel.fromJson(const {
        'key': '/authors/OL1A',
        'name': 'Some Author',
        'bio': {'type': '/type/text', 'value': 'A bio.'},
      });

      expect(model.bio, 'A bio.');
    });

    test('leaves photoUrl null when photos is missing or empty', () {
      final missing = AuthorModel.fromJson(const {
        'key': '/authors/OL1A',
        'name': 'Some Author',
      });
      final empty = AuthorModel.fromJson(const {
        'key': '/authors/OL1A',
        'name': 'Some Author',
        'photos': [],
      });

      expect(missing.photoUrl, isNull);
      expect(empty.photoUrl, isNull);
    });
  });
}
