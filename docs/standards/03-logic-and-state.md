# 03 Logic and State

## Result and Failure
Defined once in `core/errors`:
```dart
sealed class Result<T> { const Result(); }
final class Success<T> extends Result<T> { const Success(this.value); final T value; }
final class Err<T> extends Result<T> { const Err(this.failure); final Failure failure; }

sealed class Failure { const Failure(); }
// NetworkFailure, StorageFailure, PermissionFailure, ValidationFailure,
// NotFoundFailure, UnexpectedFailure (extend as needed)
```
- Exceptions MUST NOT cross the data to domain boundary. Repositories catch and convert.
- Failures carry a machine-readable kind, never a user-facing sentence. The UI maps a failure to a localized message.
- Never swallow an error silently. Log it (see 06) and convert it.

## Cubit and states
- States are immutable (sealed classes or Equatable) and describe everything the screen needs. No nullable "magic" fields standing in for a state.
- A state exists for loading, success, empty, and error when the screen loads data.
- Emit only on real change. Avoid emitting after `close()`.
- Cancel every subscription and timer in `close()`.
- No `BuildContext` in a Cubit, ever. Side effects to the UI (snackbar, navigation) are modeled as one-shot state or a listener stream, not as context calls.
- A Cubit calls use cases only.

## Use cases
One operation, one class, one public method `call`. Inputs and outputs are domain types. Orchestrating several repositories belongs here, not in the Cubit.

## Business rules
Rules live in the domain (entities and use cases). If a rule appears in a widget or Cubit, it is in the wrong place.

## Time, randomness, IO
- `DateTime.now()` MUST NOT appear in domain or data code. Inject a `Clock` (package:clock or an own interface).
- Randomness, platform services, storage and network are injected behind interfaces so tests can fake them.
- Time zones: store instants in UTC; convert to local only at the presentation edge or through one dedicated service.

## Pure functions first
Calculations are pure and side-effect free where possible. They are the easiest code to test exhaustively.

## Concurrency
No shared mutable state across async boundaries. Heavy computation runs off the UI isolate. Long-lived platform work (alarms, notifications) is scheduled, not polled.

## Persistence of settings
Through the `KeyValueStore` interface. Keys are constants in one file.
