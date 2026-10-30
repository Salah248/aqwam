# Engineering Standards

These standards are project-agnostic and reusable in any Flutter project. Project-specific rules live ONLY in `PROJECT-PROFILE.md`.

## Files
| File | Scope |
|---|---|
| 01-architecture.md | Structure, layers, dependency rule, DI, naming |
| 02-ui-design.md | Design tokens, RTL, accessibility, UI states, widgets |
| 03-logic-and-state.md | Result/Failure, Cubit, use cases, streams, time |
| 04-data-and-content.md | Data sources, offline-first, content integrity, downloads |
| 05-testing.md | What to test, how, coverage, required test matrix |
| 06-quality-performance-security.md | Lints, performance, privacy, dependencies |
| 07-git-and-pr.md | Branches, commits, pull requests |
| 08-review-and-dod.md | Feature gate, review report, Definition of Done |
| 09-roles-and-mentoring.md | Who does what, how the agent reviews and teaches |
| PROJECT-PROFILE.md | Rules specific to this project |

## Precedence
PROJECT-PROFILE.md > standards 01 to 09 > agent defaults. If two rules conflict or a rule is unclear: STOP and ask the owner. Never guess.

## Keywords
MUST / MUST NOT = blocking. SHOULD = expected, deviation needs a written reason in the PR. MAY = optional.

## Deviations
A standard changes only by the owner. A one-off deviation requires an ADR at `docs/adr/NNN-title.md` (context, decision, consequences) approved by the owner BEFORE the code is written.

## Agent protocol (every task)
1. Read this file, 09-roles-and-mentoring.md, the standards that apply to the task, and PROJECT-PROFILE.md.
2. Before doing anything, post a short plan: what you will do, files to touch, and open questions. If something is ambiguous, ask.
3. Work on the current branch only. Small, atomic commits (see 07). Never push or merge; the owner does.
4. Do ONLY what the owner asked. By default the owner writes the feature code; you review and teach (see 09). Implement a piece yourself only when the owner explicitly asks for that piece. No extra features, no drive-by refactors.
5. When you write code, mirror the owner's style, improve it, and explain every improvement (see 09).
6. Run: `dart format .`, `flutter analyze`, `flutter test`. Report the results honestly.
7. Self-review against 08-review-and-dod.md and output the report (PASS/FAIL per section, every violation with rule, reason, files, minimal fix).
8. End with: what changed, what was tested, what was NOT done, and anything the owner must decide.

## Task prompt template (owner copies this)
```
Read docs/standards/README.md and the standards relevant to this task, then PROJECT-PROFILE.md. Follow the agent protocol.

TASK: <title>
GOAL: <one sentence>
SCOPE: <what is in>
OUT OF SCOPE: <what is out>
DESIGN REFERENCE: <Figma frame names / docs/design file> (if UI)
ACCEPTANCE: <observable results>
```
