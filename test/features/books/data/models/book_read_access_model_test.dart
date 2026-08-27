import 'package:bookshelf/features/books/data/models/book_read_access_model.dart';
import 'package:bookshelf/features/books/domain/entities/book_read_access.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BookReadAccessModel.fromJson', () {
    test('maps "full" availability with a reader URL', () {
      final model = BookReadAccessModel.fromJson({
        'ebooks': [
          {
            'availability': 'full',
            'read_url': 'https://archive.org/stream/bwb_KS-179-237',
            'preview_url': 'https://archive.org/details/bwb_KS-179-237',
          },
        ],
      });

      expect(model.availability, EbookAvailability.full);
      expect(model.readerUrl, 'https://archive.org/stream/bwb_KS-179-237');
      expect(model.previewUrl, 'https://archive.org/details/bwb_KS-179-237');
    });

    test('maps "borrow" availability', () {
      final model = BookReadAccessModel.fromJson({
        'ebooks': [
          {
            'availability': 'borrow',
            'preview_url': 'https://archive.org/details/some-id',
          },
        ],
      });

      expect(model.availability, EbookAvailability.borrowable);
      expect(model.readerUrl, isNull);
      expect(model.previewUrl, 'https://archive.org/details/some-id');
    });

    test('maps a missing ebooks key to none', () {
      final model = BookReadAccessModel.fromJson(const {});

      expect(model.availability, EbookAvailability.none);
      expect(model.readerUrl, isNull);
      expect(model.previewUrl, isNull);
    });

    test('maps an unrecognized availability value to restricted', () {
      final model = BookReadAccessModel.fromJson({
        'ebooks': [
          {'availability': 'printdisabled'},
        ],
      });

      expect(model.availability, EbookAvailability.restricted);
    });
  });
}
