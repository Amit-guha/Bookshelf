enum EbookAvailability { full, borrowable, restricted, none }

class BookReadAccess {
  const BookReadAccess({
    required this.availability,
    this.readerUrl,
    this.previewUrl,
  });

  final EbookAvailability availability;

  /// Set when [availability] is [EbookAvailability.full] — Internet
  /// Archive's reader page for the book.
  final String? readerUrl;

  /// Set when [availability] is [EbookAvailability.borrowable] or
  /// [EbookAvailability.restricted] — Internet Archive's details page, where
  /// the user can borrow or request access.
  final String? previewUrl;
}
