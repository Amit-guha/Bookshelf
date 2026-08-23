abstract class ApiConstants {
  static const baseUrl = 'https://openlibrary.org';

  static const connectTimeout = Duration(seconds: 30);
  static const receiveTimeout = Duration(seconds: 30);
  static const sendTimeout = Duration(seconds: 30);

  static const authorizationHeader = 'Authorization';
  static const contentTypeHeader = 'Content-Type';

  // Search API.
  static const search = '/search.json';
  static const searchAuthors = '/search/authors.json';

  // Legacy Partner ("Read") API — bulk lookup by ISBN/OCLC/LCCN bibkeys.
  static const books = '/api/books';

  // Covers API lives on a separate host from [baseUrl].
  static const coversBaseUrl = 'https://covers.openlibrary.org';

  static String trendingPath(String period) => '/trending/$period.json';
  static String subjectPath(String subject) => '/subjects/$subject.json';
  static String workPath(String olid) => '/works/$olid.json';
  static String editionPath(String olid) => '/books/$olid.json';
  static String authorPath(String olid) => '/authors/$olid.json';
  static String isbnPath(String isbn) => '/isbn/$isbn.json';

  /// [key] is one of `isbn`, `oclc`, `lccn`, `id`, or `olid`; [size] is `S`,
  /// `M`, or `L`.
  static String coverUrl({
    required String key,
    required String value,
    String size = 'M',
  }) => '$coversBaseUrl/b/$key/$value-$size.jpg';
}