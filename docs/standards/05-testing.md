# 05 Testing

## Principles
- Tests describe behavior, not implementation. They are deterministic: no real network, no real clock, no real file system, no real platform channels.
- Use fakes and mocks (mocktail). Inject a fake `Clock`.
- One behavior per test. Name: `should <result> when <condition>`. Arrange, act, assert.
- Every bug fix starts with a failing test that reproduces it.

## What to test per layer
| Layer | Required tests |
|---|---|
| Entities | Invariants and behavior |
| Mappers | Every field, null and edge values, round trips |
| Models | Parsing of valid, missing and malformed data |
| Data sources | Against fakes of the underlying client; timeouts and errors convert correctly |
| Repositories | Success, each failure kind, exception to `Failure` conversion, mapping |
| Use cases | Delegation and any orchestration logic |
| Cubits (bloc_test) | EVERY state and transition: loading, success, empty, error, plus retry |
| Widgets | Key screens in each state; light and dark; Arabic RTL; large text scale; semantics labels exist |
| Golden tests | Design-critical screens only, with fixed fonts and device size |
| Integration | The critical user flows end to end on an emulator |

## Required matrix for every feature
Loading, Success, Empty, Error (with retry). Add when relevant: offline, permission denied, first run, restored state after app restart.

## Content and data integrity
Content builds and migrations have their own tests (counts, checksums, upgrade from each previous schema version). These run in CI.

## Time-dependent logic
Prayer times, countdowns, schedules and calendars are tested with a fake clock across: day boundaries, time zone changes, daylight saving transitions, leap years, and device clock changes.

## Platform features (alarms, notifications, widgets, audio)
Unit-test the scheduling logic with fakes. Then run the manual device checklist in `08-review-and-dod.md`. Manual results are recorded in the PR.

## Coverage
Defaults, adjustable by the owner: domain and data at least 90 percent of lines, Cubits 100 percent of states and transitions, whole project at least 80 percent. CI fails below the threshold. Coverage is a floor, not the goal; behaviors above are the goal.

## Rules
- No test depends on another test's state or on execution order.
- No `sleep`/real delays. Use fake async.
- Flaky tests are fixed or removed, never retried into passing.
- Test code follows the same naming and cleanliness rules as production code.
