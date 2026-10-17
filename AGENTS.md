# Aqwam (أقوَم) — Rules for AI coding agents

Aqwam is a free, ad-free, offline-first, open-source Islamic app (Flutter; Android first, iOS-ready). Code license: GPL-3.0. Content keeps the license of its source.

## 1. Absolute rule: religious text
- NEVER write, edit, "fix", complete, shorten or translate any Quran ayah, hadith, dhikr, du'a or tafsir from model memory.
- Religious content comes ONLY from the content pipeline: verified sources -> build script -> read-only SQLite content DB.
- Never hand-edit content data files. Any content change needs a documented source and owner review.
- Content integrity tests must always pass (114 surahs, 6236 ayat, ayah count per surah, file checksum).

## 2. Architecture
- Feature-first structure. Layers per feature: data / domain / presentation.
- No business logic in widgets.
- Everything platform-specific (notifications, audio, permissions, storage, location) sits behind an interface, so iOS can be added by changing one layer.
- State management: Cubit (flutter_bloc). States are explicit and immutable. Errors are handled explicitly, never swallowed.
- DI: get_it. Navigation: go_router.
- Two separate databases: bundled read-only content DB, and user-data DB (Drift). Updating content must never touch user data.
- The app name lives in ONE config place. Never hard-code it.

## 3. UI
- Colors, spacing (multiples of 4/8), typography and radii come ONLY from design tokens. No hard-coded values in screens.
- No hard-coded strings. Use ARB localization. Arabic (RTL) is the primary language, English is secondary.
- Minimum touch target 48dp, sufficient contrast, respect the user's font scale, add TalkBack labels.
- Every screen has designed loading, empty and error states.

## 4. Performance
- Use builder-based lists, const widgets, and minimize rebuilds. Measure with DevTools before optimizing.
- Core features must work offline. Network is only for downloads (audio, books) and external links.

## 5. Notifications
- Schedule a rolling window (next ~7 days). Reschedule on app open, device boot, timezone change and settings change.
- Handle the Android notification permission and exact-alarm permission according to the CURRENT Android docs (verify, do not assume).
- The notification small icon is a separate white-on-transparent asset.

## 6. Quality gates
- Every change ships with tests: unit tests, bloc_test for Cubits, content integrity tests.
- Lints: very_good_analysis. CI (analyze + tests) must pass before merge.
- New dependency: justify it, pin the version, check maintenance, and check its license is compatible with GPL-3.0.
- Small PRs. Clear commit messages.

## 7. Sources and credits
- Every content source is recorded in docs/SOURCES.md with its license and obligations. Never add content without an entry.
- The in-app "Sources and credits" screen must list every source that requires attribution.

## 8. When unsure
Ask the owner. Propose a compromise that satisfies all sides. Do not guess, especially on religious content.
