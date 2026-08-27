import 'package:bookshelf/features/book_details/domain/entities/book_read_access.dart';

/// Maps one bibkey entry from OpenLibrary's
/// `/api/books?bibkeys=OLID:{id}&jscmd=data` response to [BookReadAccess].
/// Editions with no scanned copy simply omit the `ebooks` key.
class BookReadAccessModel {
  const BookReadAccessModel({
    required this.availability,
    this.readerUrl,
    this.previewUrl,
  });

  factory BookReadAccessModel.fromJson(Map<String, dynamic> json) {
    final ebooks = json['ebooks'] as List?;
    final ebook = ebooks != null && ebooks.isNotEmpty
        ? ebooks.first as Map<String, dynamic>
        : null;
    if (ebook == null) {
      return const BookReadAccessModel(availability: EbookAvailability.none);
    }

    return BookReadAccessModel(
      availability: _parseAvailability(ebook['availability'] as String?),
      readerUrl: ebook['read_url'] as String?,
      previewUrl: ebook['preview_url'] as String?,
    );
  }

  static EbookAvailability _parseAvailability(String? value) => switch (value) {
    'full' => EbookAvailability.full,
    'borrow' => EbookAvailability.borrowable,
    null => EbookAvailability.none,
    _ => EbookAvailability.restricted,
  };

  final EbookAvailability availability;
  final String? readerUrl;
  final String? previewUrl;

  BookReadAccess toEntity() => BookReadAccess(
    availability: availability,
    readerUrl: readerUrl,
    previewUrl: previewUrl,
  );
}
