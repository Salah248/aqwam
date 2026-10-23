# Project Profile: Aqwam (أقوَم)

Everything here applies in addition to the general standards.

## Product
Free, ad-free, offline-first Islamic app: Quran with one tafsir, prayer times with countdown and notifications, adhkar with an interactive counter, daily reminders, Hijri calendar. Arabic primary (RTL), English second. Android first, iOS-ready. Code license GPL-3.0; content keeps its source's license.

## Absolute rule: religious text
- NEVER write, edit, correct, complete, shorten or translate any Quran ayah, hadith, dhikr, du'a, tafsir or religious date from model memory.
- Religious content comes ONLY from the content pipeline built from verified, recorded sources.
- Never hand-edit content data files. A content change needs a documented source and the owner's review.
- Placeholder text in design or tests is clearly marked as placeholder.
- Content integrity tests always pass (114 surahs, 6236 ayat, ayah count per surah, file checksum).

## Stack decisions
Flutter, flutter_bloc (Cubit), get_it, go_router, Drift for user data, a bundled read-only SQLite content database, adhan for calculations, flutter_local_notifications plus native Android code where needed, just_audio and audio_service, geolocator, hijri, ARB localization, bloc_test and mocktail, very_good_analysis. Verify the current version and maintenance of each package before adding it.

## Data
- Two stores: bundled read-only content DB, and user-data DB. Updating content never touches user data.
- Audio is never bundled or committed. It streams from the source, and users download per surah on demand.
- Every source is in `docs/SOURCES.md`. The in-app "Sources and credits" screen lists all attributions.

## Prayer times and notifications
- Times are calculated on-device for every day. Calculation method and Asr school are chosen automatically from the country, stored internally, and NOT shown in the UI in V1.
- Prayer state machine: before adhan (countdown to the next prayer), at adhan (banner and iqama countdown, minutes and seconds only), after iqama (brief "established" state, then the next prayer). The current prayer is highlighted. Friday is labeled on Dhuhr. After Isha the next prayer is labeled "tomorrow".
- Notifications work with the app closed: a persistent countdown notification using the system chronometer in count-down mode (no minus sign), adhan alert (sound or silent per user choice), iqama countdown, optional pre-prayer reminder, daily reminders.
- Scheduling: rolling window of upcoming days, refreshed on app open, device reboot, time zone or clock change, and by a daily background job. Verify the window size on devices.
- Exact alarms: check the permission before every scheduling call and degrade gracefully when it is missing. Explain the permission in onboarding. Do not rely on `USE_EXACT_ALARM`; verify current Play policy before release.
- Notification small icon is a separate monochrome asset. Separate channels for the persistent countdown (silent, low importance) and the adhan alert.

## UI specifics
- Tokens come from `docs/design/tokens.json`. In Dart `accentGold` is named `accent`. `pageInk`, `pageBg` and the `system` group are presentation-only and are not implemented.
- Design references: `docs/design/figma-export-light.html` and `figma-export-dark.html`, and the Figma file. They are visual references only; never copy religious text from them.
- Quran text: Amiri Quran, centered, continuous flow, never justified, no kashida, no character changes. One surah or one juz is loaded at a time.
- Ornaments are original vector assets. Never copy artwork from another app or a printed mushaf.
- Digits: a single formatter. Arabic-Indic by default in Arabic, Western in English, user can override. Nothing else formats digits.
- Bottom navigation labels and other small text must stay readable: target at least 11 sp and re-check on a real device.

## Privacy
No accounts, no ads, no analytics, no tracking. Location is used only to calculate prayer times and stays on the device. The privacy policy states that the audio host sees the user's IP when audio is downloaded.

## Scope guard
V1 scope is defined in `docs/` (plan section 3 and later decisions). Anything outside it needs the owner's approval first. Postponed: page-style mushaf, word-level audio, home-screen widget, favorites, streaks and re-engagement notifications, Qibla, backup, iOS.

## Task order
Tasks follow the roadmap in the plan (section 18). Do not start a task before the previous one passes the review.
