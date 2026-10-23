# 08 Review and Definition of Done

## When this applies
At the end of every task, feature or screen. Nothing moves to the next task until the review passes.

## Reviewer rules
- Review ONLY against these standards and PROJECT-PROFILE.md. Never suggest architecture or style outside them.
- Never refactor code that passes.
- Every issue must state: the rule violated (file and section), the reason, the affected files, the minimal fix, and the severity.
- Severity: BLOCKER (a MUST is violated), MAJOR (a SHOULD violated without reason), MINOR (polish).

## Feature gate: PASS or FAIL per section
| # | Section | Passes when |
|---|---|---|
| 1 | Architecture (01) | Structure, layer rules, dependency rule, DI and naming all hold; no layer knows what it must not |
| 2 | Logic and state (03) | Result/Failure used; Cubit rules hold; no business rule outside the domain; time is injected; subscriptions cancelled |
| 3 | UI and design (02) | Tokens only; no hard-coded strings; RTL correct; accessibility met; every state designed; matches the design reference in both themes; works at 200 percent text |
| 4 | Data and content (04) | Offline works; stores separated; integrity tests pass; sources recorded; downloads behave |
| 5 | Testing (05) | Required matrix covered; coverage thresholds met; no flaky tests |
| 6 | Quality, performance, security (06) | Analyzer clean; no dead code; budgets met; permissions justified; dependencies justified |
| 7 | Git and PR (07) | Branch, commits, PR template, size, CI green |
| 8 | Project profile | Every rule in PROJECT-PROFILE.md that applies is met |

The overall result is FAIL if any section has a BLOCKER. Score = passed sections divided by 8, shown as a percentage, with the list of open issues.

## Definition of Done
- The feature works as described in the task acceptance criteria.
- All eight sections PASS.
- `dart format`, `flutter analyze`, `flutter test` are clean and CI is green.
- No dead code, no stray TODO, no new warning.
- Dependencies are registered; no duplicate logic.
- Loading, success, empty and error states are implemented and tested.
- A screen matches the design in light and dark, in RTL, at 200 percent text scale.
- The manual device checklist below was run when the task touches the platform.
- The review report is attached to the PR.

## Manual device checklist (platform-touching tasks)
- A real device, ideally from a manufacturer with aggressive battery management, plus the emulator.
- Notifications and alarms: fire on time with the app open, in background, and after the app is swiped away; after reboot; after the time zone changes; after the device clock changes; with battery optimization on; with the exact alarm permission denied.
- Permissions: first run, denial, "don't ask again", and re-granting from system settings.
- Orientation, split screen, and font size at the maximum setting.
- TalkBack pass on the main flow.
- Airplane mode: core features still work.

## Report template the agent must output
```
REVIEW REPORT
1 Architecture ........ PASS | FAIL
2 Logic and state ..... PASS | FAIL
3 UI and design ....... PASS | FAIL
4 Data and content .... PASS | FAIL
5 Testing ............. PASS | FAIL
6 Quality/perf/sec .... PASS | FAIL
7 Git and PR .......... PASS | FAIL
8 Project profile ..... PASS | FAIL
SCORE: x / 8

ISSUES (if any)
- [BLOCKER|MAJOR|MINOR] Rule: <file section> | Reason | Files | Minimal fix

NOT DONE / DEFERRED: ...
OWNER DECISIONS NEEDED: ...
```
