# bookshelf

Flutter app. Currently the stock `flutter create` counter template (`lib/main.dart`,
`test/widget_test.dart`) — no custom architecture or dependencies yet beyond
`cupertino_icons` and `flutter_lints`. See Architecture below for the target structure
new features should follow as they're built out.

## Role

You are a Flutter developer working on this codebase. Write idiomatic, null-safe
Dart and Flutter code that follows the architecture and conventions documented
below. Favor the project's established patterns (feature-first layering, Riverpod
codegen, go_router) over generic Flutter advice, and keep changes consistent with
the existing structure rather than introducing new patterns ad hoc.

## Architecture

Feature-first, clean-architecture layering (data / domain / presentation) per feature,
with cross-cutting concerns under `core/`:

```
lib/
├── core/
│   ├── network/
│   │   └── dio_provider.dart
│   ├── error/
│   │   ├── exceptions.dart      # thrown by datasources
│   │   └── failure.dart         # returned by repositories/usecases
│   ├── theme/
│   │   └── app_theme.dart
│   ├── router/
│   │   └── app_router.dart
│   ├── constants/
│   │   ├── api_constants.dart   # base URLs, endpoints, timeouts
│   │   └── app_constants.dart   # app-wide non-API constants (padding, durations, keys...)
│   ├── enums/
│   │   └── ...                  # shared enums used across features
│   ├── extensions/
│   │   └── ...                  # extension methods on Dart/Flutter core types
│   └── utils/
│       └── ...                  # shared, stateless, framework-agnostic utilities
│
├── features/
│   └── books/
│       ├── data/
│       │   ├── datasource/               # remote/local datasources
│       │   │   └── book_remote_datasource.dart
│       │   ├── models/                   # DTOs — fromJson/toJson + toEntity()
│       │   │   └── book_model.dart
│       │   └── repositories/             # implements domain/repositories/*.dart
│       │       └── book_repository_impl.dart
│       │
│       ├── domain/                       # plain Dart, no Flutter/Riverpod imports
│       │   ├── entities/
│       │   │   └── book.dart
│       │   ├── repositories/             # abstract interfaces only
│       │   │   └── book_repository.dart
│       │   └── usecases/                 # one class per usecase, plain Dart
│       │       └── search_books.dart
│       │
│       └── presentation/
│           ├── providers/                # @riverpod notifiers/state, call usecases
│           │   └── book_providers.dart
│           ├── routes/                   # <feature>_routes.dart — GoRoute list + path/name constants
│           │   └── book_routes.dart
│           ├── screens/                  # route targets, "smart" widgets
│           │   ├── book_search_screen.dart
│           │   └── book_detail_screen.dart
│           └── widgets/                  # reusable UI pieces, no direct provider reads
│               └── book_card.dart
│
└── main.dart
```

Conventions:

### Dependency Direction (MUST NOT VIOLATE)

- `domain/` MUST know nothing about:
  - `data/`
  - `presentation/`
  - Riverpod
  - Flutter
  - Dio
  - GoRouter
  - other framework/infrastructure packages
- `data/` MUST implement interfaces defined in `domain/`.
- `data/` MAY depend on `domain/` and `core/`.
- `data/` MUST NOT depend on `presentation/`.
- `presentation/` MAY depend on:
  - `domain/`
  - `core/`
  - Flutter
  - Riverpod
  - GoRouter
- Screens MUST NOT import `data/` directly.
- Screens MUST NOT access datasources or repository implementations
  directly.
- Repository interfaces MUST live in: `domain/repositories/`
- Repository implementations MUST live in: `data/repositories/`

The intended dependency direction is:

```text
presentation → domain ← data
```

- Usecase classes stay framework-agnostic — plain Dart, testable without Flutter. The
  `@riverpod` wiring for a usecase lives in `presentation/providers/`, not in
  `domain/usecases/`.
- `data/models/` classes map to `domain/entities/` via a `toEntity()` method (or a
  mapper class if the mapping gets non-trivial) — entities stay free of JSON concerns.
- Datasources throw `core/error/exceptions.dart` types; repositories catch those and
  return `core/error/failure.dart` types (e.g. via a `Result`/`Either`-style return).
- State management: Riverpod with code generation (`@riverpod` annotation from
  `riverpod_annotation`, not manual `Provider`/`StateNotifierProvider` declarations).
  Providers colocated per feature in `presentation/providers/`. Cross-feature/shared
  providers (e.g. `dio_provider.dart`) live in `core/`.
- Generated files (`*.g.dart`) sit next to their source file. After adding/editing an
  `@riverpod` provider or a `freezed`/`json_serializable` model, run:
  `dart run build_runner build --delete-conflicting-outputs`
  (or `dart run build_runner watch --delete-conflicting-outputs` while iterating).
- `presentation/screens/`: one file per route target, named `<feature>_<noun>_screen.dart`
  (e.g. `book_search_screen.dart`, `book_detail_screen.dart`). These are "smart" widgets —
  they watch providers and own page-level logic. `presentation/widgets/` stays "dumb":
  purely presentational, data and callbacks passed in via constructor, no provider reads.
- `core/constants/`, `core/enums/`, `core/extensions/` are for things genuinely shared
  across features. Something used by only one feature belongs next to that feature
  instead (e.g. a `book`-only enum lives in `features/books/domain/entities/`, not `core/`).
- Tests mirror this tree under `test/` (e.g. `test/features/books/domain/usecases/search_books_test.dart`).
- In `pubspec.yaml`: `flutter_riverpod`, `riverpod_annotation`, `dio`, `go_router`,
  `json_annotation`, `freezed_annotation`; dev deps `build_runner`, `riverpod_generator`,
  `freezed`, `json_serializable`.

## Network Conventions

Dio is the project's HTTP client and MUST remain inside the `core/` or
`data/` infrastructure layer. Domain and presentation layers MUST NOT
depend on Dio.

### Dio Client

- The shared Dio instance MUST live under:
  `core/network/`
- The shared Dio instance MUST be provided through Riverpod code generation.
- New providers MUST use `@riverpod`.
- The Dio provider MUST be responsible only for configuring and providing
  the shared Dio instance.
- Dio configuration MAY include:
  - base URL
  - connection timeout
  - receive timeout
  - send timeout
  - default headers
  - interceptors
- Feature-specific API configuration MUST NOT be placed in the global
  Dio provider.
- Non-trivial interceptors SHOULD be defined as separate classes under:
  `core/network/interceptors/`
- Interceptors SHOULD be attached to the shared Dio instance inside the
  Dio provider rather than defined inline.
- API endpoints and API-specific constants MUST live in:
  `core/constants/api_constants.dart`
  or the appropriate feature-specific data layer when the endpoint is
  feature-owned.

Example:

```dart
@riverpod
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    ),
  );

  return dio;
}
```

## Navigation

`go_router` provides app-wide navigation, exposed through Riverpod codegen like everything
else in state management. `core/router/app_router.dart` defines a single
`@riverpod GoRouter goRouter(Ref ref)` provider that builds the `GoRouter` instance;
`main.dart` consumes it via `MaterialApp.router(routerConfig: ref.watch(goRouterProvider))`.

### Routing Conventions (MUST NOT VIOLATE)

- Each feature MUST define its own `List<RouteBase>` in:
  `presentation/routes/<feature>_routes.dart`.
- `core/router/app_router.dart` MUST only compose feature route lists
  and configure truly global router settings.
- `core/router/app_router.dart` MUST NOT contain feature-specific
  `GoRoute` definitions inline.
- Feature-specific routes MUST remain inside their owning feature.
- Route parameters MUST be extracted inside the feature's routes file
  using `state.pathParameters[...]`, `state.queryParameters[...]`,
  or other appropriate `GoRouterState` APIs.
- Extracted route parameters MUST be passed to screens through plain
  constructor parameters.
- Screens MUST NOT import or depend on `go_router`.
- Screens MUST NOT receive `GoRouterState`.
- Screens MUST remain testable independently of the routing framework.
- Domain and data layers MUST NOT import or depend on `go_router`.
- Navigation MUST be initiated from the presentation layer or through
  an explicitly defined navigation abstraction.

Example `features/books/presentation/routes/book_routes.dart`:

```dart
abstract class BookRoutes {
  static const search = '/books';
  static const searchName = 'book-search';
}

final bookRoutes = <RouteBase>[
  GoRoute(
    path: BookRoutes.search,
    name: BookRoutes.searchName,
    builder: (context, state) => const BookSearchScreen(),
  ),
];
```

### Nested / Shell Navigation

- Cross-feature navigation structures such as `StatefulShellRoute`,
  bottom navigation shells, and shared navigation scaffolds MAY live
  in `core/router/`.
- Feature-specific child routes MUST still be defined by their owning
  feature and composed into the shell from `core/router/`.
- `core/router/` MUST NOT contain feature business logic.
- `core/router/` MUST NOT contain feature-specific screens or widgets,
  except navigation-specific scaffolding required by the shell.

### Route Naming

- Route path constants MUST be defined alongside the feature routes.
- Route names MUST be stable and descriptive.
- Route paths MUST NOT be duplicated as raw string literals throughout
  the application.
- When navigation to a route is required outside the route definition,
  use the corresponding route/path constant rather than duplicating
  the path string.

### Route Responsibility

- Routes are responsible for translating router state into screen
  constructor parameters.
- Screens are responsible for rendering UI and handling presentation
  events.
- Routes MUST NOT contain business logic.
- Business logic MUST live in the domain layer/use cases.
- Route definitions SHOULD remain thin and declarative.

## Screen & Widget Conventions (MUST NOT VIOLATE)

- Route-target widgets MUST end with `Screen`.
  Examples: `BooksScreen`, `BookDetailsScreen`, `ReaderScreen`.
- Non-route UI components MUST NOT use the `Screen` suffix.
  Examples: `BookCard`, `BookCover`, `BookListItem`.
- Screens SHOULD use `ConsumerWidget` by default.
- `ConsumerStatefulWidget` MAY be used when the screen genuinely requires
  widget lifecycle methods such as `initState()` or `dispose()`.
- When `ConsumerStatefulWidget` is used:
  - Lifecycle-bound objects such as `TextEditingController`, `FocusNode`,
    `AnimationController`, `ScrollController`, and similar resources
    MUST be disposed in `dispose()` when owned by the widget.
  - `initState()` and `dispose()` MUST contain only UI/widget lifecycle
    concerns.
  - Business logic MUST NOT be implemented in `State` methods.
  - API calls, repository access, use case execution, and application
    state mutations MUST be initiated through Riverpod providers/notifiers.
  - Business logic MUST remain in the appropriate domain layer.
- Screens MUST contain state wiring and UI/layout composition only.
- Screens MUST NOT contain business logic.
- Screens MUST NOT access repositories, datasources, or external services
  directly.
- Screens MAY read/watch Riverpod providers and forward user interactions
  to providers/notifiers.
- Screens SHOULD primarily contain:
  - Riverpod state wiring
  - event forwarding
  - navigation callbacks
  - UI/layout composition
- Complex business logic, domain calculations, and reusable derived state
  MUST NOT be implemented inside `build()`.
- Business-related or reusable derived state MUST live in the appropriate:
  - Riverpod provider/notifier
  - use case
  - domain entity
- Simple presentation-only transformations MAY remain in `build()`.
  Examples:
  - `text.toUpperCase()`
  - simple null fallbacks
  - basic display formatting
  - simple conditional UI values
- Small private widgets used only by one screen MAY remain in the same
  screen file.
- A widget SHOULD be moved to `presentation/widgets/<name>.dart` when:
  - it is reused by 2 or more screens, OR
  - it contains 3+ distinct UI states or conditional branches in its
    render logic, OR
  - it would benefit from its own widget test, OR
  - it makes the parent screen difficult to understand.
- Widgets MUST NOT be split into separate files solely to reduce line count.
- Screen files SHOULD remain focused and readable. Avoid arbitrary
  line-count rules; responsibility and complexity are more important
  than file length.

## Utils Conventions (MUST NOT VIOLATE)

- `core/utils/` MUST contain only genuinely shared, stateless utilities.
- Utilities in `core/utils/` MUST:
  - have no `BuildContext` dependency
  - have no Riverpod `Ref` dependency
  - have no dependency on feature-specific code
  - avoid side effects
  - produce deterministic results for the same inputs
- A utility MUST NOT be placed in `core/utils/` merely because it
  "might be useful someday."
- A utility SHOULD already be used by 2 or more features before being
  promoted to `core/utils/`.
- A utility used by only one feature MUST remain within that feature,
  preferably in: `features/<feature>/presentation/utils/`.
- `helper.dart`, `common_utils.dart`, or type-named grab-bags
  (`string_utils.dart`, `list_utils.dart`) MUST NOT be added.
- Files MUST be named by what they do:
  `date_formatter.dart`, `currency_formatter.dart`, `validators.dart`.
- Dart extension methods SHOULD be preferred over static utility classes
  where it reads naturally.

  Example: `date.toDisplayDate()` is preferred over `DateUtils.format(date)`.

- Before adding a new file to `core/utils/`, an existing package
  (`intl`, `collection`, etc.) MUST be checked for equivalent functionality
  first.

## Assets Conventions

- Shared application assets MUST live under the project-root `assets/`
  directory.
- Assets MUST NOT be placed inside `lib/`.
- Shared assets SHOULD be organized by type:
  - `assets/images/`
  - `assets/icons/`
  - `assets/fonts/`
- Feature-specific assets MAY live under:
  `features/<feature>/assets/` when the asset is genuinely owned by
  only that feature.
- Feature-specific assets MUST NOT be moved to the shared `assets/`
  directory merely for convenience.
- Assets MUST be declared in `pubspec.yaml` before they are used.
- Asset paths MUST NOT be duplicated as arbitrary strings throughout
  the application when a centralized asset reference provides a clear
  benefit.
- Asset organization MUST remain simple; directories MUST NOT be
  created speculatively for assets that do not exist.

## Riverpod Conventions

Riverpod with code generation is the project's dependency injection and
state-management solution.

### Provider Declaration

- New providers MUST use `@riverpod` from `riverpod_annotation`.
- The following MUST NOT be manually declared for new code unless there is
  a specific compatibility or architectural reason:
  - `Provider`
  - `FutureProvider`
  - `StreamProvider`
  - `StateProvider`
  - `StateNotifierProvider`
- `StateNotifier` SHOULD NOT be introduced for new code.
- Providers MUST be used for dependency wiring and application/presentation
  state management.
- Providers MUST NOT become a replacement for domain use cases.
- Business logic MUST remain in the appropriate domain/usecase layer.

### Provider Location

- Feature providers MUST be colocated by feature under:

```text
features/<feature>/presentation/providers/
```

## Domain Layer

The domain layer contains the application's business rules, entities,
repository contracts, and use cases.

The domain layer MUST remain independent of Flutter, Riverpod, Dio,
GoRouter, API models, and other infrastructure/framework concerns.

See **Dependency Direction** above for the complete list of forbidden
dependencies.

- `domain/` MAY depend only on:
  - Dart core libraries
  - other domain classes
  - explicitly approved pure-Dart packages when required
- The domain layer MUST be independently testable without Flutter or
  Riverpod.

### Entities

- Domain entities MUST be plain Dart classes.
- Entities MUST NOT import:
  - Flutter
  - Riverpod
  - Dio
  - GoRouter
  - data models
  - API-specific packages
- Entities MUST represent application/domain concepts rather than
  external API response structures.
- Entities MUST NOT contain JSON serialization concerns.
- Entities MUST NOT contain API-specific fields solely because an API
  happens to provide them.
- Entities SHOULD contain domain-related behavior and business rules
  when that behavior naturally belongs to the entity.

Example:

```dart
class Book {
  final String id;
  final String title;
  final String? author;
  final String? coverUrl;

  const Book({
    required this.id,
    required this.title,
    this.author,
    this.coverUrl,
  });
}
```

### Use Cases

- Use case classes MUST remain framework-agnostic.
- Use cases MUST be plain Dart classes.
- Use cases MUST NOT import:
  - Flutter
  - Riverpod
  - Dio
  - GoRouter
  - data models
  - datasource implementations
  - repository implementations
- Use cases MAY depend on:
  - domain entities
  - domain repository interfaces
  - other domain-level abstractions
  - approved pure-Dart packages when genuinely required.
- Use cases MUST be independently testable without Flutter or Riverpod.
- Each use case SHOULD represent one meaningful application or business
  operation.
- Use cases MUST depend on repository interfaces defined in:
  `domain/repositories/`
- Use cases MUST NOT access datasources directly.
- Use cases MUST NOT access repository implementations directly.
- Use cases MUST NOT contain presentation or UI logic.
- Use cases MUST NOT perform:
  - navigation
  - API calls directly
  - database access directly
  - local storage access directly
  - UI state management
  - snackbar/dialog/toast handling
- Riverpod wiring for use cases MUST live in:
  `presentation/providers/`
- Use cases MUST NOT contain `@riverpod` annotations.
- Use cases MUST expose domain-level types and MUST NOT return:
  - API models
  - database models
  - datasource models
  - Dio responses
  - HTTP responses
  - Riverpod `AsyncValue`
  - Flutter-specific types

#### Preferred Dependency Flow

```text
UseCase
   ↓
Domain Repository Interface
```

## Data Layer

The data layer is responsible for external data access, local persistence,
caching, data transformation, and implementation of domain repository
contracts.

The data layer MUST NOT contain presentation logic or domain business rules.

See **Dependency Direction** above for the base `data/` ↔ `domain/`/`core/`
dependency rules.

### Dependency Direction

- `data/` MUST depend only on:
  - `domain/`
  - `core/`
  - approved infrastructure/data packages.
- `data/` MUST NOT depend on:
  - `presentation/`
  - screens
  - widgets
  - GoRouter
  - presentation providers
  - Riverpod Notifiers
  - UI state
- Repository implementations MUST implement repository interfaces defined
  in `domain/repositories/`.
- Datasources MUST NOT depend on repositories.
- Datasources MUST NOT depend on presentation.
- Data models MUST NOT be exposed outside the data layer.
- Infrastructure-specific types MUST NOT leak into the domain layer.

The intended dependency direction is:

```text
presentation → domain ← data
```

### Datasources

- Datasources MUST live in:
  `features/<feature>/data/datasources/`
- Datasources MUST handle one specific data source.
- Remote datasources MUST handle API/network communication.
- Local datasources MUST handle local persistence or caching.
- Datasources MUST NOT contain domain business rules.
- Datasources MUST NOT access repositories.
- Datasources MUST NOT access presentation.
- Datasources MUST NOT return `AsyncValue`.
- Datasources MUST NOT perform navigation.
- Datasources MUST throw data/infrastructure-specific exceptions when
  their operations fail.
- Datasources MUST NOT catch and translate infrastructure exceptions into
  domain `Failure` types. Error translation is the repository's
  responsibility.

### Data Models

- Data models MUST live in:
  `features/<feature>/data/models/`
- Data models MAY contain JSON serialization.
- Data models MUST represent external API or persistence structures.
- Data models MUST NOT contain domain business rules.
- Data models MUST NOT be exposed to the domain or presentation layers.
- Data models MUST map to domain entities using `toEntity()` or a
  dedicated mapper when the mapping is non-trivial.
- Domain entities MUST NOT contain JSON serialization concerns.
- Database-specific models MUST remain inside the data layer.

### Repository Implementations

- Repository implementations MUST live in:
  `features/<feature>/data/repositories/`
- Repository implementations MUST implement domain repository interfaces.
- Repositories MUST coordinate datasources.
- Repositories MUST NOT access presentation.
- Repositories MUST NOT contain UI logic.
- Repositories MUST NOT expose API models or database models.
- Repositories MUST convert data models into domain entities before
  returning data to the domain layer.
- Repositories MUST catch datasource/infrastructure-specific exceptions.
- Repositories MUST translate infrastructure-specific exceptions into
  the project's domain-level `Failure` representation.
- Raw `DioException`, HTTP, database, or other infrastructure-specific
  exceptions MUST NOT escape from repository methods.
- Repositories SHOULD convert unexpected infrastructure exceptions into
  an appropriate generic `Failure`.
- Repositories MUST NOT contain business rules that belong in the domain
  layer.

### Data Flow

The preferred data flow is:

```text
Datasource
    ↓
Data Model
    ↓
Repository
    ↓
Domain Entity / Failure
    ↓
UseCase
    ↓
Riverpod Notifier
    ↓
AsyncData / AsyncError
    ↓
Screen
```

## Environment

- Flutter 3.44.1 (stable), Dart 3.12.1, SDK constraint `^3.12.1`.
- Xcode 26.6 (SDK 26.5). iOS Simulator runtimes installed: 26.4 and 26.5.
  Use a simulator whose OS version matches the installed runtimes (`xcrun simctl list devices`)
  or `xcodebuild -showdestinations` will fail to resolve the destination.
- Android SDK 36.1 via Android Studio's bundled JDK.

## Commands

### Development

- Get dependencies:
  `flutter pub get`
- Run the app:
  `flutter run` (pick a device with `-d <id>`; `flutter devices` lists connected ones)
- Analyze/lint:
  `flutter analyze` (rules in `analysis_options.yaml`, based on `package:flutter_lints`)
- Run tests:
  `flutter test`
- Clean build artifacts:
  `flutter clean`

### Code Generation

- Generate Riverpod and other generated code:
  `dart run build_runner build --delete-conflicting-outputs`
- Watch for changes during development:
  `dart run build_runner watch --delete-conflicting-outputs`

### Android Builds

- Build release APK:
  `flutter build apk --release`
- Build architecture-specific APKs:
  `flutter build apk --split-per-abi`
- Build release App Bundle for Google Play:
  `flutter build appbundle --release`

### iOS Builds

- Build release IPA:
  `flutter build ipa --release`
- Build iOS release application:
  `flutter build ios --release`

### Recommended Validation

Before considering a feature complete, run:

```text
flutter pub get
    ↓
dart run build_runner build --delete-conflicting-outputs
    ↓
flutter analyze
    ↓
flutter test
```

## iOS-specific notes

- First run on a machine requires CocoaPods install, handled automatically by `flutter run`/`flutter build ios`.
- The iOS Simulator is a separate macOS app (`Simulator.app`) driven by Xcode/`simctl` — it cannot be embedded
  inside Android Studio's tool-window emulator feature, which is Android-only.