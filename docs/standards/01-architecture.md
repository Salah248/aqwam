# 01 Architecture

Feature-first Clean Architecture, Repository pattern, Cubit for UI state, GetIt for dependency injection, SOLID.

## Dependency rule
`presentation -> domain <- data`. The domain layer is PURE DART: it MUST NOT import Flutter, platform packages, Dio, database packages, or anything from `data/` or `presentation/`.
`core/` holds shared infrastructure. Features MUST NOT import other features directly; share through `core/` or domain interfaces.

## Folder structure
```
lib/
  app/                    app shell, root widget, main navigation, bootstrap
  core/
    theme/  l10n/  di/  router/  errors/  logging/  platform/  widgets/  utils/
  features/<feature>/
    data/
      datasources/  models/  mappers/  repositories/
    domain/
      entities/  repositories/  usecases/
    presentation/
      cubit/  pages/  widgets/
```
Every feature uses exactly this structure. Do not create folders that stay empty.

## Layer responsibilities
| Layer | Does | MUST NOT |
|---|---|---|
| Data source | Talks to exactly ONE external source (HTTP API, local database, platform channel, file or asset) | Contain business rules, UI types, or know any repository, Cubit or entity |
| Model (DTO) | Serialization of one source's data (`fromJson`/`toJson`, or row mapping) | Know Flutter, Cubit, repositories, entities |
| Mapper | Converts model <-> entity. Pure functions | Perform IO or contain business rules |
| Repository interface | Domain abstraction. Returns entities, `Result<T>` or `Stream<T>` | Mention models, JSON, SQL, HTTP |
| Repository implementation | Coordinates data sources, uses mappers, converts exceptions to `Failure`, returns `Result<T>` | Expose models or JSON, know BuildContext or widgets, hold UI state |
| Entity | Immutable core business object, may hold invariant logic | Know Flutter, Cubit, repositories, serialization |
| Use case | ONE application operation. Depends on repository INTERFACES only. Single public `call` | Know Flutter, Cubit or data-layer classes |
| Cubit | Holds UI state, calls use cases, emits states | Use BuildContext, widgets, Dio, JSON, repositories, data sources |
| Page / widget | Renders state, forwards user intent to the Cubit | Contain business logic, parsing, IO |

A use case may be a thin wrapper when the operation is a pass-through. Consistency beats cleverness.

## Streams and long-running work
Countdowns, location updates, audio state: expose as `Stream` from the domain. The Cubit subscribes and MUST cancel in `close()`.

## Dependency injection
Constructor injection everywhere. GetIt is used ONLY in the composition root (`core/di`) and in factory registrations. No `GetIt.I` calls inside business classes. Each feature exposes one `registerXxxFeature(GetIt)` function.

## Shared UI placement
- A widget used by one feature stays in that feature's `presentation/widgets`.
- A widget reused by two or more features moves to `core/widgets`. Never move it earlier.
- App-level screens (shell, navigation) live in `app/`.

## Naming
Files `snake_case.dart`. Classes `UpperCamelCase`. Suffixes: `*_datasource`, `*_model`, `*_mapper`, `*_repository` (interface), `*_repository_impl`, `*_usecase` (verb first, e.g. `GetNextPrayerUsecase`), `*_cubit`, `*_state`, `*_page`. One public class per file unless tightly coupled.

## SOLID checks
- SRP: could this class change for more than one reason? Then split.
- OCP: can behavior be extended without editing it?
- LSP: can a subtype replace it without breaking callers?
- ISP: does the class expose only what its users need?
- DIP: does it depend on abstractions? Business classes depend on interfaces, not implementations.

## Adding a feature (pipeline)
1. Define the data source(s) and what each returns.
2. Design entities.
3. Design the repository interface.
4. Implement models.
5. Implement mappers.
6. Implement data sources.
7. Implement the repository.
8. Implement use cases.
9. Implement the Cubit and its states.
10. Build the UI from the design reference (see 02).
11. Register dependencies.
12. Write tests (see 05).
13. Remove unused code and run the review (see 08).
