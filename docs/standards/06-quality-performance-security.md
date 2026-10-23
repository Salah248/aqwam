# 06 Quality, Performance, Security

## Static quality
- `very_good_analysis` with zero warnings and zero infos. `dart format` clean.
- `// ignore` and `// ignore_for_file` only with a comment explaining why.
- No `print`. Logging goes through one `AppLogger` abstraction in `core/logging` (levels; debug output only in debug builds). Never log personal data.
- No dead code, no commented-out code, no TODO without an issue reference.
- Prefer `final`, immutable data, and explicit types on public APIs.

## Performance
- Profile on a real mid-range Android device, in profile or release mode, not in debug.
- Frame budget: UI work under 16 ms per frame. Investigate any jank.
- Use `const`, builder lists, narrow rebuilds, and cached expensive values.
- Heavy work (parsing, large queries, file IO) runs off the UI isolate.
- Initialize lazily. Keep cold start lean: no work before the first frame that the first screen does not need.
- Dispose controllers, subscriptions, focus nodes and timers.
- Battery: never poll. Use scheduled alarms, system timers, and push-free designs.
- Track APK or app bundle size per release. Remove unused packages and assets.

## Security and privacy
- No analytics, advertising or tracking SDKs unless the owner approves in an ADR.
- Request permissions at the moment of use with a clear reason. Request the minimum. Handle denial gracefully.
- HTTPS only. No secrets, keys or tokens in the repository.
- Personal data stays on the device unless the owner decides otherwise. Document any data that leaves the device.
- Validate all external input. Treat downloaded files as untrusted until verified.

## Dependencies
Before adding a package: justify the need, check maintenance (recent releases, open issues), check its license is compatible with the project license, check it is not duplicated by an existing package, pin the version. Prefer the standard library and existing packages. Record the decision in the PR.

## Accessibility and localization
Defined in 02. They are quality gates, not extras.
