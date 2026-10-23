# 07 Git and Pull Requests

## Branches
- `main` is protected. Nobody commits to it directly.
- One task per branch. Names: `feat/…`, `fix/…`, `refactor/…`, `test/…`, `docs/…`, `chore/…`, kebab-case, short and specific (for example `feat/prayer-engine`).
- Start from an up-to-date `main`.

## Commits
Conventional Commits: `type(scope): summary`. Types: feat, fix, refactor, test, docs, chore, perf, build, ci. Imperative mood, at most 72 characters in the summary. Atomic: each commit builds and passes tests. No "WIP", no "fix stuff".

## Never commit
Build outputs, `.dart_tool`, local IDE settings (`.vscode`, `.idea`) unless the owner shares them, `local.properties`, keystores and secrets, large binaries (audio, big datasets), generated files that the build recreates (unless the project profile says otherwise).

## Pull requests
- Small and focused: about 400 changed lines or fewer, excluding generated files and lock files. Larger work is split into a series.
- Use the PR template. Required sections: summary, what changed, how it was tested, screenshots (light and dark, RTL) for UI, the review report from 08, risks, follow-ups.
- CI must be green before merge. The owner reviews and squash-merges. The branch is deleted after merge.
- Agents MUST NOT push, merge, force-push or rewrite history. The owner does.

## Dependencies and lock files
`pubspec.lock` is committed for apps. Dependency changes are called out in the PR.

## Releases
Version numbers follow semantic versioning with Flutter's build number. A release has a tag and a changelog entry written for users.
