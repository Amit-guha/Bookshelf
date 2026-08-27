import 'package:bookshelf/features/book_details/data/models/book_details_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BookDetailsModel.fromJson', () {
    test('merges work, ratings, and edition JSON', () {
      final model = BookDetailsModel.fromJson(
        workJson: const {
          'key': '/works/OL66554W',
          'title': 'Pride and Prejudice',
          'description': 'A classic novel.',
          'subjects': ['Fiction', 'Romance'],
        },
        ratingsJson: const {
          'summary': {'average': 4.21, 'count': 402},
        },
        editionJson: const {'number_of_pages': 345},
      );

      expect(model.key, '/works/OL66554W');
      expect(model.title, 'Pride and Prejudice');
      expect(model.description, 'A classic novel.');
      expect(model.subjects, ['Fiction', 'Romance']);
      expect(model.averageRating, 4.21);
      expect(model.ratingCount, 402);
      expect(model.pageCount, 345);
    });

    test('handles a {type, value} description object', () {
      final model = BookDetailsModel.fromJson(
        workJson: const {
          'key': '/works/OL1W',
          'title': 'Some Work',
          'description': {'type': '/type/text', 'value': 'A description.'},
        },
      );

      expect(model.description, 'A description.');
    });

    test('leaves rating/page fields null when ratings/edition are absent', () {
      final model = BookDetailsModel.fromJson(
        workJson: const {'key': '/works/OL1W', 'title': 'Some Work'},
      );

      expect(model.averageRating, isNull);
      expect(model.ratingCount, isNull);
      expect(model.pageCount, isNull);
    });
  });
}
